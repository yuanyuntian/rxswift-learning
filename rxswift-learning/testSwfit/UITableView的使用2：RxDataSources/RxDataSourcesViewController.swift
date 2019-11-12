//
//  RxDataSourcesViewController.swift
//  rxswift-learning
//
//  Created by yf on 2019/11/12.
//  Copyright © 2019 yuanf. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift
import RxDataSources

struct Mysection {
    var header:String
    var items:[Item]
}

extension Mysection:AnimatableSectionModelType {
    typealias Item = String
    
    var identity: String {
        return header
    }
    
    init(original: Self, items: [Self.Item]) {
        self = original
        self.items = items
    }
}



class RxDataSourcesViewController: UIViewController {

    let disposeBag = DisposeBag()
    var tableView:UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "UITableView的使用2：RxDataSources"
        view.backgroundColor = UIColor.white
        
        //单分区tabelView
        tableView = UITableView(frame: view.frame, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellid")
        view.addSubview(tableView)
        
        //方法一：自带的section
        //初始化数据
        let items = Observable.just([
            SectionModel(model:"测试", items:[
                "UILable的用法",
                "UIText的用法",
                "UIButton的用法"
            ])
        ])
        
        //创建数据源
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, String>>(configureCell:{
            (dataSource, tableView, indexPath, element) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellid")
                 cell?.textLabel?.text = "\(indexPath.row):\(element)"
                 return cell!
        })
        
        //绑定单元格数据
//        items.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        
        //方法二：自定义的section
        let sections = Observable.just([
            Mysection(header: "测试", items: [
                "UILable的用法",
                "UIText的用法",
                "UIButton的用法"
            ])
        ])
        
        let dataSource_2 = RxTableViewSectionedReloadDataSource<Mysection>(configureCell:{
            (dataSource, tableView, indexPath, element) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellid")
                 cell?.textLabel?.text = "\(indexPath.row):\(element)"
                 return cell!
        })
        
        dataSource_2.titleForHeaderInSection = {
            dataSource, index in
            return dataSource.sectionModels[index].header
        }
        
        sections.bind(to: tableView.rx.items(dataSource: dataSource_2)).disposed(by: disposeBag)

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
