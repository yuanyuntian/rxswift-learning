//
//  UserRegitserViewModel.swift
//  rxswift-learning
//
//  Created by yf on 2019/11/14.
//  Copyright © 2019 yuanf. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

class UserRegitserViewModel {
    //用户名验证结果
    let validatedUsername:Driver<ValidationResult>
    
    //密码验证结果
    let validatedPassword:Driver<ValidationResult>
    
    //再次输入密码验证结果
    let validatedPasswordRepeated: Driver<ValidationResult>

    //注册按钮是否可用
    let signEnabled: Driver<Bool>
    
    //注册结果
    let signResult: Driver<Bool>
    
    init(input:(username:Driver<String>, password:Driver<String>,
        repeatedPassword:Driver<String>,loginTaps: Signal<Void>), dependency:(networkService: UserRegisterNetworkService, signService: UserRegisterService)) {
        //用户名验证
        validatedUsername = input.username.flatMapLatest{
            username in
            return dependency.signService.validateUsername(username).asDriver(onErrorJustReturn: .failed(message: "服务器发生错误"))
        }
        
        //密码验证
        validatedPassword = input.password.map{
            password in
            return dependency.signService.validatePassword(password)
        }
        
        //重复输入密码验证
        validatedPasswordRepeated = Driver.combineLatest(input.password, input.repeatedPassword, resultSelector: dependency.signService.validateRepeatedPassword)
        
        //注册按钮是否可用
        signEnabled = Driver.combineLatest(validatedUsername,validatedPassword,validatedPasswordRepeated, resultSelector: { username, password, repeatedPassword in
            username.isValid && password.isValid && repeatedPassword.isValid
            }).distinctUntilChanged()
        
        //获取最新的用户名和密码
        let usernameAndPassword = Driver.combineLatest(input.username, input.password){
            (username: $0, password: $1)
        }
        
        //注册按钮点击结果
        signResult = input.loginTaps.withLatestFrom(usernameAndPassword).flatMapLatest {
            pair in
            return dependency.networkService.sign(pair.username, password: pair.password).asDriver(onErrorJustReturn: false)
        }
    }

}
