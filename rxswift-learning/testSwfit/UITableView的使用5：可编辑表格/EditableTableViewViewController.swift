//
//  EditableTableViewViewController.swift
//  rxswift-learning
//
//  Created by yf on 2019/11/12.
//  Copyright © 2019 yuanf. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift
import RxDataSources

enum TableEditingCommand {
    case setItems(items:[String])//设置表格数据
    case addItem(item:String)//新增数据
    case moveItem(from:IndexPath, to:IndexPath)//移动数据
    case deleteItem(IndexPath)//删除数据
}


struct TableViewModel {
    //表格数据项
    fileprivate var items:[String]
    
    init(items:[String] = []) {
        self.items = items
    }
    
    //执行响应命令，返回相应结果
    func excute(command:TableEditingCommand) -> TableViewModel {
        switch command {
        case .setItems(let items):
            return TableViewModel(items: items)
        case .addItem(let item):
            var items = self.items
            items.append(item)
            return TableViewModel(items:items)
        case .moveItem(let from, let to):
            var items = self.items
            items.insert(items.remove(at: from.row), at: to.row)
            return TableViewModel(items:items)
        case .deleteItem(let indexPath):
            var items = self.items
            items.remove(at: indexPath.row)
            return TableViewModel(items: items)
        }
    }
}

class EditableTableViewViewController: UIViewController {

    var tableView:UITableView!
    
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "UITableView的使用5：可编辑表格"
        view.backgroundColor = UIColor.white
        
        
        //开始刷新按钮
        let refreshButton = UIButton(type: .custom)
        refreshButton.frame = CGRect(x:10, y:100, width:30, height:20)
        refreshButton.setTitle("刷新", for: .normal)
        view.addSubview(refreshButton)
        refreshButton.backgroundColor = .red
        //停止刷新按钮
        let addButton = UIButton(type: .custom)
        addButton.frame = CGRect(x:100, y:100, width:30, height:20)
        addButton.setTitle("添加", for: .normal)
        view.addSubview(addButton)
        addButton.backgroundColor = .gray
        
        
        
        //创建表格视图
        self.tableView = UITableView(frame: CGRect(x:10, y:200, width:200, height:300), style:.plain)
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self,
                                 forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
        
        //表格模型
        let initialVM = TableViewModel()
        
        //刷新数据命令
        let refreshCommand = refreshButton.rx.tap.asObservable().startWith(()) //为了页面初始化时会自动加载一次
        .flatMapLatest(getRandomresult).map(TableEditingCommand.setItems)
        
        //新增条目命令
        let addCommand = addButton.rx.tap.asObservable()
            .map{"\(arc4random())"}.map(TableEditingCommand.addItem)
        
        //移动位置命令
        let moveCommand = tableView.rx.itemMoved.map(TableEditingCommand.moveItem)
        
         //删除条目命令
        let deleteCommand = tableView.rx.itemDeleted.map(TableEditingCommand.deleteItem)
        
        
        //绑定单元格数据
        Observable.of(refreshCommand, addCommand, moveCommand, deleteCommand).merge().scan(initialVM){(vm:TableViewModel, command:TableEditingCommand) -> TableViewModel in
            return vm.excute(command: command)
            }.startWith(initialVM).map{
                [AnimatableSectionModel(model: "", items: $0.items)]
            }.share(replay: 1).bind(to: tableView.rx.items(dataSource: ViewController.dataSource())).disposed(by:disposeBag)
        
    }
    
    //获取随机数据
    func getRandomresult() -> Observable<[String]> {
        let items = (0..<5).map { _ in
            "\(arc4random())"
        }
        
        return Observable.just(items)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ViewController {
    //创建表格数据源
    static func dataSource() -> RxTableViewSectionedAnimatedDataSource
        <AnimatableSectionModel<String, String>> {
            return RxTableViewSectionedAnimatedDataSource(
                //设置插入、删除、移动单元格的动画效果
                animationConfiguration: AnimationConfiguration(insertAnimation: .top,
                                                               reloadAnimation: .fade,
                                                               deleteAnimation: .left),
                configureCell: {
                    (dataSource, tv, indexPath, element) in
                    let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
                    cell.textLabel?.text = "条目\(indexPath.row)：\(element)"
                    return cell
            },
                canEditRowAtIndexPath: { _, _ in
                    return true //单元格可删除
            },
                canMoveRowAtIndexPath: { _, _ in
                    return true //单元格可移动
            }
            )
    }
}
