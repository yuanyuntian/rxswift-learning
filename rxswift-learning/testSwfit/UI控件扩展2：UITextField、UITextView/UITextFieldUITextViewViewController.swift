//
//  UITextFieldUITextViewViewController.swift
//  rxswift-learning
//
//  Created by yf on 2019/11/11.
//  Copyright © 2019 yuanf. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa


class UITextFieldUITextViewViewController: UIViewController {

    let disposeBag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "UI控件扩展2：UITextField、UITextView"
        view.backgroundColor = UIColor.white
        
        //监听单个textfield内容变化(textView同理)
        //.orEmpty可以将String?类型的ControlProperty转换成String，省得我们解包
        let textField = UITextField(frame:CGRect(x:10, y:80, width:200, height:30))
        textField.borderStyle = .roundedRect
        view.addSubview(textField)
        
        textField.rx.text.orEmpty.asObservable().subscribe(onNext: {print($0)}).disposed(by: disposeBag)
        
        textField.rx.text.orEmpty.changed.subscribe(onNext: {print($0)}).disposed(by: disposeBag)
        
        //将内容绑定到其他UI控件上
        //创建文本输入框
        let inputField = UITextField(frame: CGRect(x:10, y:120, width:200, height:30))
        inputField.borderStyle = UITextField.BorderStyle.roundedRect
        self.view.addSubview(inputField)
        
        //创建文本输出框
        let outputField = UITextField(frame: CGRect(x:10, y:180, width:200, height:30))
        outputField.borderStyle = UITextField.BorderStyle.roundedRect
        self.view.addSubview(outputField)
        
        //创建文本标签
        let label = UILabel(frame:CGRect(x:20, y:190, width:220, height:30))
        self.view.addSubview(label)
        
        //创建按钮
        let button:UIButton = UIButton(type:.system)
        button.frame = CGRect(x:20, y:270, width:40, height:30)
        button.setTitle("提交", for:.normal)
        self.view.addSubview(button)
        
        //当文本内容改变
        let input = inputField.rx.text.orEmpty.asDriver()//将普通序列转换成Driver
        .throttle(0.3) //在主线程操作，0.3秒内值若多次改变，取最后一次
        
        //内容绑定到另一个输入框
        input.drive(outputField.rx.text).disposed(by: disposeBag)
        
        input.map { (string) -> String in
            return "当前字数：\(string)"
        }.drive(label.rx.text).disposed(by: disposeBag)
        
        input.map { (str) -> Bool in
            return str.count > 5
        }.drive(button.rx.isEnabled).disposed(by: disposeBag)
        
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
