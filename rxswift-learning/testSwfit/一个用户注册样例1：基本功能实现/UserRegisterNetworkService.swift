//
//  UserRegisterNetworkService.swift
//  rxswift-learning
//
//  Created by yf on 2019/11/14.
//  Copyright © 2019 yuanf. All rights reserved.
//

import Foundation
import RxSwift


class UserRegisterNetworkService {
    //验证用户是否存在
    func userNameAvailabel(_ username:String) -> Observable<Bool> {
        let url = URL(string:"https://github.com/\(username.URLEscaped)")
        let request = URLRequest(url:url!)
        return URLSession.shared.rx.response(request: request).map { pair in
            //如果不存在该用户，则说明这个用户名可用
            return pair.response.statusCode == 404
        }.catchErrorJustReturn(false)
    }
    
    //注册用户
    func sign(_ username:String, password: String) -> Observable<Bool> {
        //模拟请求，平均每三次失败一次
        let signResult = arc4random()%3 == 0 ? false:true
        return Observable.just(signResult).delay(1.5, scheduler: MainScheduler.instance)
    }
}

extension String {
    //字符串的url地址转义
    var URLEscaped:String{
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
}
