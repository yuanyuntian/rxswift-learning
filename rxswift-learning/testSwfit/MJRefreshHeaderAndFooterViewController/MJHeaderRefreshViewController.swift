//
//  MJHeaderRefreshViewController.swift
//  testSwfit
//
//  Created by yf on 2019/11/6.
//  Copyright © 2019 yuanf. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MJRefresh


class MJHeaderRefreshViewController: UIViewController {

    
    //表格
    var tableView:UITableView!
    
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "结合MJRefresh使用1：下拉刷新"
        view.backgroundColor = UIColor.white
        
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style:.plain)
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self,
                                 forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
        
        //设置头部刷新控件
        self.tableView.mj_header = MJRefreshNormalHeader()
        
        //初始化viewModel
        let viewModel = MJRefreshViewModel(headerRefreshing: self.tableView.mj_header.rx.refreshing.asDriver())
        
        //单元格数据绑定
        viewModel.tableData.asDriver().drive(tableView.rx.items){
            (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
            cell?.textLabel?.text = "\(row+1)、\(element)"
            return cell!
        }.disposed(by: disposeBag)
        
        //下拉刷新状态结束的绑定
        viewModel.endHeaderRefreshing.drive(self.tableView.mj_header.rx.endRefreshing).disposed(by: disposeBag)
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
