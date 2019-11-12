//
//  UIButtonUIBarButtonItemViewController.swift
//  rxswift-learning
//
//  Created by yf on 2019/11/12.
//  Copyright © 2019 yuanf. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift


class UIButtonUIBarButtonItemViewController: UIViewController {

    let disposeBag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "UI控件扩展3：UIButton、UIBarButtonItem"
        view.backgroundColor = UIColor.white
        
        //按钮点击响应
        let button = UIButton(type: .custom)
        button.frame = CGRect(x:100 ,y:200, width:50, height:30)
        button.setTitle("点击", for: .normal)
        button.backgroundColor = .gray
        view.addSubview(button)
        
        button.rx.tap.subscribe(onNext:{
            self.showMessage("按钮被点击")
        }).disposed(by: disposeBag)
        
        //或者，其中 rx.title 为 setTitle(_:for:) 的封装。
        button.rx.tap.bind{[weak self] in
            self?.showMessage("按钮被点击")
        }.disposed(by: disposeBag)
        
        //按钮标题的绑定
        Observable<Int>.interval(1, scheduler: MainScheduler.instance).map{
            "\($0)s"
            }.bind(to: button.rx.title(for: .normal)).disposed(by: disposeBag)
        
        Observable<Int>.interval(1, scheduler: MainScheduler.instance).map{
            let name = $0 % 2 == 0 ? "back":"fooward"
            return UIImage(named: name)!
            }.bind(to: button.rx.image()).disposed(by: disposeBag)
        
        //按钮背景图片的绑定
        Observable<Int>.interval(1, scheduler: MainScheduler.instance).map {UIImage(named:"\($0 % 2)")!}.bind(to: button.rx.backgroundImage()).disposed(by: disposeBag)
        
        //按钮是否可用的绑定
        Observable<Int>.interval(5, scheduler: MainScheduler.instance).map {$0 % 5 == 0}.bind(to: button.rx.isEnabled).disposed(by: disposeBag)
        
        
    }
    
    func showMessage(_ text:String) {
        let alertController = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
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
