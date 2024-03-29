//
//  MVVMDriverRegisterViewController.swift
//  rxswift-learning
//
//  Created by yf on 2019/11/14.
//  Copyright © 2019 yuanf. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class MVVMDriverRegisterViewController: UIViewController {

    //用户名输入框、以及验证结果显示标签
    @IBOutlet weak var usernameOutlet: UITextField!
    @IBOutlet weak var usernameValidationOutlet: UILabel!
    
    //密码输入框、以及验证结果显示标签
    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var passwordValidationOutlet: UILabel!
    
    //重复密码输入框、以及验证结果显示标签
    @IBOutlet weak var repeatedPasswordOutlet: UITextField!
    @IBOutlet weak var repeatedPasswordValidationOutlet: UILabel!
    
    //注册按钮
    @IBOutlet weak var signupOutlet: UIButton!
    
    let disposeBag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "一个用户注册样例1：基本功能实现"
        view.backgroundColor = UIColor.white
        
        
        //初始化viewmodel
        let viewModel = UserRegitserViewModel(input: (
            username: usernameOutlet.rx.text.orEmpty.asDriver(),
            password: passwordOutlet.rx.text.orEmpty.asDriver(),
            repeatedPassword: repeatedPasswordOutlet.rx.text.orEmpty.asDriver(),
            loginTaps: signupOutlet.rx.tap.asSignal()), dependency: (networkService: UserRegisterNetworkService(), signService: UserRegisterService()))
        
        
        //用户名验证结果
        viewModel.validatedUsername.drive(usernameValidationOutlet.rx.validationResult).disposed(by: disposeBag)
        
        //密码验证结果
        viewModel.validatedPassword.drive(passwordValidationOutlet.rx.validationResult).disposed(by: disposeBag)
        
        //再次输入密码验证结果绑定
         viewModel.validatedPasswordRepeated
             .drive(repeatedPasswordValidationOutlet.rx.validationResult)
             .disposed(by: disposeBag)
        
        
        //注册按钮是否可用
        
        viewModel.signEnabled.drive(onNext: { [weak self](valid) in
            self?.signupOutlet.isEnabled = valid
            self?.signupOutlet.alpha = valid ? 1.0:0.3
        }).disposed(by: disposeBag)
        
        
        //注册结果绑定
        viewModel.signResult.drive(onNext: { [weak self](result) in
            self?.showMessage("注册" + (result ? "成功" : "失败") + "!")
        }).disposed(by: disposeBag)
    }
    
    //详细提示框
     func showMessage(_ message: String) {
         let alertController = UIAlertController(title: nil,
                                                 message: message, preferredStyle: .alert)
         let okAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
         alertController.addAction(okAction)
         self.present(alertController, animated: true, completion: nil)
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
