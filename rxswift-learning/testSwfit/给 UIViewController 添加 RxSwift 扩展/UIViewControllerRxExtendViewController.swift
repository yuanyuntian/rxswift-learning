//
//  UIViewControllerRxExtendViewController.swift
//  rxswift-learning
//
//  Created by yf on 2019/11/11.
//  Copyright © 2019 yuanf. All rights reserved.
//

import UIKit

class UIViewControllerRxExtendViewController: UIViewController {

    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        //页面显示状态完毕
        self.rx.isVisible.subscribe(onNext: { (visible) in
            print("当前页面显示状态：\(visible)")
        }).disposed(by: disposeBag)
        
        

        
        //页面将要显示
        self.rx.viewWillAppear
            .subscribe(onNext: { animated in
                self.title = "给 UIViewController 添加 RxSwift 扩展"
                self.view.backgroundColor = UIColor.yellow
            }).disposed(by: disposeBag)
        
        //页面显示完毕
        self.rx.viewDidAppear
            .subscribe(onNext: { animated in
                print("viewDidAppear")
            }).disposed(by: disposeBag)
        
        
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
