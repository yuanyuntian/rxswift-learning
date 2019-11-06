//
//  MJRefreshHeaderAndFooterNetworkService.swift
//  testSwfit
//
//  Created by yf on 2019/11/6.
//  Copyright © 2019 yuanf. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class MJRefreshHeaderAndFooterNetworkService {
    
    func getRandomResult() -> Observable<[String]> {
        print("正在请求数据......")
        let items = (0 ..< 15).map { _ in
            "随机数据\(Int(arc4random()))"
        }
        
        let observable = Observable.just(items)
        return observable.delay(2, scheduler: MainScheduler.instance)
    }
}
