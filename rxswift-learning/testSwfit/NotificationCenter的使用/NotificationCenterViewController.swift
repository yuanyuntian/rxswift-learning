//
//  NotificationCenterViewController.swift
//  testSwfit
//
//  Created by yf on 2019/11/6.
//  Copyright © 2019 yuanf. All rights reserved.
//

import UIKit

class NotificationCenterViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        title = "通知NotificationCenter的使用"

        // Do any additional setup after loading the view.
        
        //监听应用进入后台的通知
        NotificationCenter.default.rx.notification(UIApplication.didEnterBackgroundNotification).takeUntil(self.rx.deallocated).subscribe { (event) in
            print(event.element?.name as Any)
        }
        
        let textField = UITextField(frame: CGRect(x:20, y:100, width:200, height:30))
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.returnKeyType = .done
        self.view.addSubview(textField)
        
        textField.rx.controlEvent(.editingDidEndOnExit).subscribe { _ in
            textField.resignFirstResponder()
        }.disposed(by: disposeBag)
        
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
