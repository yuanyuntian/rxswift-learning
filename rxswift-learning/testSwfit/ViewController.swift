//
//  ViewController.swift
//  testSwfit
//
//  Created by yuanf on 2019/9/5.
//  Copyright © 2019 yuanf. All rights reserved.
//

import UIKit

@_exported import RxSwift
@_exported import RxCocoa
@_exported import MJRefresh

class ViewController: UIViewController{

    let disposeBag = DisposeBag()

    @IBOutlet weak var list: UITableView!

    let items = Observable.just([
        "NotificationCenter的使用",
        "订阅UITableViewCell里的按钮点击事件",
        "下拉刷新，上拉记载更多",
        "结合MJRefresh使用1：下拉刷新",
    ])
    
    let chocolates: BehaviorRelay<[String]> = BehaviorRelay(value: [])

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.list.register(UITableViewCell.self, forCellReuseIdentifier:  "Cell")
        self.list.allowsSelection = true

        items.bind(to: self.list.rx.items){(tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = element
            return cell
        }.disposed(by: disposeBag)
    }
}


extension ViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        if indexPath.row == 0 {
            let vc = NotificationCenterViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 1 {
            let vc = UITableViewCellButtonViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 2 {
            let vc = MJHeaderRefreshViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}



