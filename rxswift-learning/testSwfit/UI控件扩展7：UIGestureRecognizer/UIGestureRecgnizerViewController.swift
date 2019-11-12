//
//  UIGestureRecgnizerViewController.swift
//  rxswift-learning
//
//  Created by yf on 2019/11/12.
//  Copyright © 2019 yuanf. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift


class UIGestureRecgnizerViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "UI控件扩展7：UIGestureRecognizer"
        view.backgroundColor = UIColor.white
        
        let swipe = UISwipeGestureRecognizer()
        swipe.direction = .up
        view.addGestureRecognizer(swipe)
        
        //第一种响应回调的方法
        swipe.rx.event.subscribe(onNext:{
             [weak self] recognizer in
            let point = recognizer.location(in: recognizer.view)
            self?.showAlert(title: "向上滑动", message: "\(point.x)\(point.y)")
        }).disposed(by: disposeBag)
        
        //第二种响应回调方法
        swipe.rx.event.bind { [weak self] recognizer in
            let point = recognizer.location(in: recognizer.view)
            self?.showAlert(title: "向上滑动", message: "\(point.x)\(point.y)")
        }.disposed(by: disposeBag)

        //点击页面，输入框失去焦点
        let tapGe = UITapGestureRecognizer()
        view.addGestureRecognizer(tapGe)
        tapGe.rx.event.subscribe(onNext:{[weak self] _ in
            self?.view.endEditing(true)
        }).disposed(by: disposeBag)
    }
    
    //显示消息提示框
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .cancel))
        self.present(alert, animated: true)
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
