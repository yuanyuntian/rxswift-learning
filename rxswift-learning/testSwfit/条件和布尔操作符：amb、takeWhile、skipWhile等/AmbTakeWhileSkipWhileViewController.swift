//
//  AmbTakeWhileSkipWhileViewController.swift
//  rxswift-learning
//
//  Created by yf on 2019/11/8.
//  Copyright © 2019 yuanf. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


class AmbTakeWhileSkipWhileViewController: UIViewController {

    let disposeBag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "过滤操作符：filter、take、skip等"
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
        //takeWhile
        //一次判断Observable序列的每一个值是否满足给定的条件，当第一个不满足条件的事件出现时，订阅事件自动结束。
        Observable.of(2,3,4,5).takeWhile { (item) -> Bool in
            return item < 4
        }.subscribe(onNext: {
            print($0)
            }).disposed(by: disposeBag)
        
        //takeUntil
         //除了订阅源Observable外，通过takeUntil方法可以监听另一个Observable，即notifier。如果notifier发出值或completed通知，那么源Observable便自动完成，停止发送事件。
        let source = PublishSubject<String>()
        let notifier = PublishSubject<String>()
        
        source.takeUntil(notifier).subscribe(onNext: {
            print($0)
        }).disposed(by: disposeBag)
        
        source.onNext("a")
        source.onNext("b")
        source.onNext("c")
        source.onNext("d")
        
        //停止接收消息
        notifier.onCompleted()
        
        source.onNext("e")
        source.onNext("f")
        source.onNext("g")
        
        
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
