//
//  ControlPropetyControlEventViewController.swift
//  rxswift-learning
//
//  Created by yf on 2019/11/11.
//  Copyright © 2019 yuanf. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class ControlPropetyControlEventViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "特征序列3：ControlProperty、 ControlEvent"
        view.backgroundColor = UIColor.white
        
        //ControlProperty
        //专门用来描述UI控件属性，拥有该类型的属性都是被观察者（Observable）。
        //具有以下特征：1.不会产生error事件。2.一定是在主线程监听。3.一定是在主线程订阅。4.共享状态变化。
        //其实在RxCocoa下许多UI控件都是被观察者（可观察序列），比如UITextField的rx.text属性类型便是ControlProperty<String?>
        //如果我们想让UITextField里输入的内容实时的显示在另一个label上面，可以：
        let label = UILabel(frame: CGRect(x:100, y:100, width:100, height:30))
        view.addSubview(label)
        
        let textField = UITextField(frame: CGRect(x:100, y:140, width:100, height:30))
        textField.borderStyle = .line
        view.addSubview(textField)
        
        textField.rx.text.bind(to:{_ in
            return label.rx.text
            })


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


