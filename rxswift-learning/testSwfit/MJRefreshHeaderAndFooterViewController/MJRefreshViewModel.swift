//
//  MJRefreshViewModel.swift
//  testSwfit
//
//  Created by yf on 2019/11/6.
//  Copyright © 2019 yuanf. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift



class MJRefreshViewModel {
    
    //表格数据列表
    let tableData: Driver<[String]>
    
    //停止刷新状态序列
    let endHeaderRefreshing:Driver<Bool>
    
    init(headerRefreshing:Driver<Void>) {
        let networkService = MJRefreshNetworkService()
        
        self.tableData = headerRefreshing.startWith(()).flatMapLatest{
            _ in
            networkService.getRandomResult()
        }
        //停止刷新序列
        self.endHeaderRefreshing = self.tableData.map { _ in true}
    }
}
