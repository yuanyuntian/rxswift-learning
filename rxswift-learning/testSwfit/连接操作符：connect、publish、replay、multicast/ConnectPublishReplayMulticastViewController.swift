//
//  ConnectPublishReplayMulticastViewController.swift
//  rxswift-learning
//
//  Created by yf on 2019/11/8.
//  Copyright © 2019 yuanf. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


class ConnectPublishReplayMulticastViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "连接操作符：connect、publish、replay、multicast"
        view.backgroundColor = UIColor.white
        
        //可连接序列
        //1.可连接序列和一般序列不同在于：有订阅时候不会立即开始发送事件消息，只有当调用connect()之后才会开始发送值。
        //2.可连接序列可以让所有订阅者订阅后，才开始发送事件消息，从而保证想要的所有订阅者都能接收到事件消息。
/*
        //先看一个普通序列
        //每隔1秒钟发送一个事件
        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        //第一个订阅者（立即开始订阅）
        interval.subscribe(onNext: {print($0)})
        //第二个订阅者（立即开始订阅）
        delay(5) {
            interval.subscribe(onNext: {print($0)})
        }
        //结果是：在第一个订阅者订阅5秒后，第二个订阅者才可以接收到第一个值0，两个订阅者接收值是不同步的。
 */
        //publish
        //将一个正常的序列改造成一个可连接序列，同时该序列不会立即发送事件，只有在调用connect之后才会开始。
 /*
        let observal2 = Observable<Int>.interval(1, scheduler: MainScheduler.instance).publish()
        observal2.subscribe(onNext: {print("订阅1：\($0)")})
        //把事件推迟2秒
        delay(2) {
           observal2.connect()
        }
        
        //延迟5秒开始订阅
        delay(5) {
            observal2.subscribe(onNext: {print("订阅2：\($0)")})
        }
 */
        
/*
        //replay
        //与publish相同之处在于：将一个正常的序列转换为一个可连接序列，同时不会立即发送事件消息，等connect之后才会开始。
        //不同之处在于：设置的bufferSize决定新的订阅者可以接收到订阅之前的几个事件消息。
        let interval3 = Observable<Int>.interval(1, scheduler: MainScheduler.instance).replay(5)
        interval3.subscribe(onNext: {print("订阅1：\($0)")})
        
        //把事件推迟2秒
        delay(2) {
            _ = interval3.connect()
        }
        
        //延迟5秒开始订阅
        delay(10) {
            _ = interval3.subscribe(onNext: {print("订阅2：\($0)")})
        }
  */
        
        //share(relay:)
        //使观察者共享源Observable，并且缓存最新的n个元素，将这些元素直接发送给新的观察者。简单来说，就是replay和refCount的组合。
        let interval6 = Observable<Int>.interval(1, scheduler: MainScheduler.instance).share(replay: 5)
        //第一个订阅者(立即开始订阅)
        _ = interval6.subscribe(onNext: {print("订阅1：\($0)")})
        
        //第二个订阅者(延迟5秒开始订阅)
        delay(15) {
            _ = interval6.subscribe(onNext: {print("订阅2：\($0)")})
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func delay(_ delay:Double, closure: @escaping() -> Void){
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            closure()
        }
    }

}
