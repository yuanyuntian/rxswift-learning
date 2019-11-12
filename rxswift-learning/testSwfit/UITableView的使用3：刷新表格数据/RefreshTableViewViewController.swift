//
//  RefreshTableViewViewController.swift
//  rxswift-learning
//
//  Created by yf on 2019/11/12.
//  Copyright © 2019 yuanf. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift
import RxDataSources


class RefreshTableViewViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    var tableView:UITableView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "UITableView的使用3：刷新表格数据"
        view.backgroundColor = UIColor.white
        
        //开始刷新按钮
        let refreshBtn = UIButton(type: .custom)
        refreshBtn.frame = CGRect(x:10, y:84, width:30, height:20)
        refreshBtn.setTitle("刷新", for: .normal)
        view.addSubview(refreshBtn)
        refreshBtn.backgroundColor = .red
        //停止刷新按钮
        let stopRefreshBtn = UIButton(type: .custom)
        stopRefreshBtn.frame = CGRect(x:60, y:84, width:30, height:20)
        stopRefreshBtn.setTitle("停止", for: .normal)
        view.addSubview(stopRefreshBtn)
        stopRefreshBtn.backgroundColor = .gray
        //表格
        tableView = UITableView(frame: CGRect(x:10, y:114, width:200, height:300), style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellid")
        view.addSubview(tableView)
        
        //随机的表格数据
        let randomResult = refreshBtn.rx.tap.asObservable().startWith(()).throttle(1, scheduler: MainScheduler.instance)
        .flatMapLatest{
            self.getRandomResult().takeUntil(stopRefreshBtn.rx.tap)
        }.share(replay:1)
        
        //创建数据源
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Int>>(configureCell: {
            (dataSource, tableView, indexPath, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellid")
            cell?.textLabel?.text = "条目\(indexPath.row)：\(element)"
            return cell!
        })
        
        randomResult.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    }
    
    func getRandomResult() -> Observable<[SectionModel<String, Int>]>{
        print("正在请求数据")
        
        let items = (0..<5).map { _ in
            Int(arc4random())
        }
        
        let obserable = Observable.just([SectionModel(model:"S", items:items)])
        
        return obserable.delay(1, scheduler: MainScheduler.instance)
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
