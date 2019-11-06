//
//  MJRefreshNetworkService.swift
//  testSwfit
//
//  Created by yf on 2019/11/6.
//  Copyright © 2019 yuanf. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class MJRefreshNetworkService {
    //获取随机数据
    func getRandomResult() -> Driver<[String]> {
        let items = (0..<15).map {
            _ in
            "随机数据\(Int(arc4random()))"
        }
        let observable = Observable.just(items)
        
        return observable.delay(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance).asDriver(onErrorDriveWith: Driver.empty())
    }
}
