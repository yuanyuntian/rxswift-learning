//
//  CustomBindablePropertyViewController.swift
//  rxswift-learning
//
//  Created by yf on 2019/11/7.
//  Copyright © 2019 yuanf. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


class CustomBindablePropertyViewController: UIViewController {

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "观察者2： 自定义可绑定属性"
        view.backgroundColor = UIColor.white
        
        let label = UILabel(frame:CGRect(x:100, y:100, width:200, height:25))
        view.addSubview(label)
        label.text = "可变字号"
        label.textColor = .gray
        
        //如何让创建出的UI控件默认就有一些观察者
        //比如让UILabel都有个fontSize可绑定属性，会根据事件值自动改变标签的字体大小
        
        
        //1.对Reactive类进行扩展
        let observable1 = Observable<Int>.interval(0.5, scheduler: MainScheduler.instance)
        observable1.map { (value) -> CGFloat in
            return CGFloat(value)
            }.bind(to: label.rx.fontSize).disposed(by: disposeBag)
        
        //2.对Reactive类进行扩展
        let observable2 = Observable<Int>.interval(0.5, scheduler: MainScheduler.instance)
        observable2.map{ CGFloat($0) }.bind(to: label.rx.fontSize).disposed(by:disposeBag)
        
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

//RxSwift自带的可绑定属性(UI观察者),例如UIlabel就有text和attributedText这两个可绑定属性
extension Reactive where Base:UILabel {
    public var text:Binder<String> {
        return Binder(self.base) {
            label, text in
            label.text = text
        }
    }
    
    public var attributedText:Binder<NSAttributedString?> {
        return Binder(self.base) {label,text in
            label.attributedText = text
        }
    }
}


//对UI类进行扩展

extension UILabel{
    public var fontSize:Binder<CGFloat> {
        return Binder(self) {label,fontSize in
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}

//对Reactive类进行扩展
extension Reactive where Base :UILabel {
    public var fontSize:Binder<CGFloat>{
        return Binder(self.base) {label, fontSize in
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}
