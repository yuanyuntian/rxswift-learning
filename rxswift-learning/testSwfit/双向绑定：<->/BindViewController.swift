//
//  BindViewController.swift
//  rxswift-learning
//
//  Created by yf on 2019/11/12.
//  Copyright © 2019 yuanf. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa


class BindViewController: UIViewController {

    let disposeBag = DisposeBag()

    struct UserViewModel {
        let username = BehaviorRelay(value: "guest")
        
        lazy var userInfo = {
            return self.username.asObservable().map{
                $0 == "gaojun" ? "是你啊" : "你是访客"
                }.share(replay: 1)
        }()
    }
    
    var userVM = UserViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "双向绑定：<->"
        view.backgroundColor = UIColor.white
        
        //简单的双向绑定
        let textField = UITextField(frame: CGRect(x:20, y:84, width:200, height:30))
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        view.addSubview(textField)
        
        let label = UILabel(frame:CGRect(x:20, y:124, width:220, height:30))
        view.addSubview(label)
        
        //将username与textField双向绑定
        userVM.username.asObservable().bind(to: textField.rx.text).disposed(by: disposeBag)
        textField.rx.text.orEmpty.bind(to: userVM.username).disposed(by: disposeBag)

        //将userinfo绑定到Label上
        userVM.userInfo.bind(to: label.rx.text).disposed(by: disposeBag)
        
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
