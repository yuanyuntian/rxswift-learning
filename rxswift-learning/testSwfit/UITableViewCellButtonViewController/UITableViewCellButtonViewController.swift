//
//  UITableViewCellButtonViewController.swift
//  testSwfit
//
//  Created by yf on 2019/11/6.
//  Copyright © 2019 yuanf. All rights reserved.
//

import UIKit

class UITableViewCellButtonViewController: UIViewController {

    var tableView:UITableView!
    
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        // Do any additional setup after loading the view.
        title = "订阅UITableViewCell里的按钮点击事件"
        
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style:.plain)
        //创建一个重用的单元格
        self.tableView!.register(MyTableViewCell.self, forCellReuseIdentifier: "Cell")
        //单元格无法选中
        self.tableView.allowsSelection = false
        self.view.addSubview(self.tableView!)
        
        //初始化数据
        let items = Observable.just([
            "文本输入框的用法",
            "开关按钮的用法",
            "进度条的用法",
            "文本标签的用法",
        ])
        
        items.bind(to: tableView.rx.items) { (tableView, row, element) in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! MyTableViewCell
            cell.textLabel?.text = "\(element)"
            
            cell.button.rx.tap.asDriver().drive(onNext: { [weak self] in
                self?.showAlert(title: "\(row)", message: element)
            }).disposed(by: cell.disposeBag)
            return cell
        }.disposed(by: disposeBag)
        
    }
    
    //显示弹出框信息
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .cancel))
        self.present(alert, animated: true)
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
