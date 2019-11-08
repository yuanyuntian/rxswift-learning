//
//  ToArrayReduceConcatViewController.swift
//  rxswift-learning
//
//  Created by yf on 2019/11/8.
//  Copyright © 2019 yuanf. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


class ToArrayReduceConcatViewController: UIViewController {

    let disposeBag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "算数&聚合操作符：toArray、reduce、concat"
        view.backgroundColor = UIColor.white
        
        //toArray
        //将一个序列变成一个数组，并作为一个单一的序列发送
        Observable.of(1,2,3).toArray().subscribe(onSuccess: { (array) in
            print(array)
            }).disposed(by: disposeBag)
        
        //reduce
        //接收一个初始值和一个操作符，将给定的初始值使用操作符累计运算，得到一个最终的结果，并将其作为单个值发出去。
        Observable.of(1,2,3,4,5).reduce(1) { (value, value2) -> Int in
            return value * value2
        }.subscribe(onNext: {
            print($0)
            }).disposed(by: disposeBag)
        
        print("------")
        //concat
        //将多个序列合并串联起来为一个Observable序列，并且只有当前面一个Observable序列发出了completed事件，才会开始发送下一个Observable事件。
        let subject1 = BehaviorSubject(value: 1)
        let subject2 = BehaviorSubject(value: 2)
        
        let variable = BehaviorRelay(value: subject1)
        variable.concat().subscribe(onNext: {print($0)}).disposed(by: disposeBag)
        subject2.onNext(2)
        subject1.onNext(10)
        subject1.onNext(11)
        subject1.onCompleted()
        variable.accept(subject2)
        subject2.onNext(9)
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
