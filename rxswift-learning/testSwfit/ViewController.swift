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
        "Observable介绍、创建可观察序列",
        "Observable订阅、事件监听、订阅销毁",
        "观察者1： AnyObserver、Binder",
        "观察者2： 自定义可绑定属性",
        "Subjects、Variables",
        "变换操作符：buffer、map、flatMap、scan等",
        "过滤操作符：filter、take、skip等",
        "条件和布尔操作符：amb、takeWhile、skipWhile等",
        "结合操作符：startWith、merge、zip等",
        "算数&聚合操作符：toArray、reduce、concat",
        "连接操作符：connect、publish、replay、multicast",
        "特征序列1：Single、Completable、Maybe",
        "特征序列3：ControlProperty、 ControlEvent",
        "给 UIViewController 添加 RxSwift 扩展",
        "调度器、subscribeOn、observeOn",
        "UI控件扩展1：UILabel",
        "UI控件扩展2：UITextField、UITextView"
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
        }else if indexPath.row == 4 {
            let vc = ObservableIntroduceCreateViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 5 {
            let vc = ObservableSubscribeDoonDisposeViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 6 {
            let vc = AnyObserverBinderViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 7 {
            let vc = CustomBindablePropertyViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 8 {
            let vc = SubjectsVariablesViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 9 {
            let vc = BufferMapFlatMapScanViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 10 {
            let vc = FilterTakeSkipViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 11 {
            let vc = AmbTakeWhileSkipWhileViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 12 {
            let vc = StartWithMergeZipViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 13 {
            let vc = ToArrayReduceConcatViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 14 {
            let vc = ConnectPublishReplayMulticastViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 15 {
            let vc = SingleCompletableMaybeViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 16 {
            let vc = SingleCompletableMaybeViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 17 {
            let vc = UIViewControllerRxExtendViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 18 {
            let vc = SubscribeOnObserveOnViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 19 {
            let vc = UILabelViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 20 {
            let vc = UITextFieldUITextViewViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}



