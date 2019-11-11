//
//  UILabelViewController.swift
//  rxswift-learning
//
//  Created by yf on 2019/11/11.
//  Copyright © 2019 yuanf. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa


class UILabelViewController: UIViewController {

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "UI控件扩展1：UILabel"
        view.backgroundColor = UIColor.white
        
        //将数据绑定到text属性上
        let label = UILabel(frame:CGRect(x:100, y:100, width:300, height:100))
        view.addSubview(label)
        
        let timer = Observable<Int>.interval(1, scheduler: MainScheduler.instance)

        timer.map{String(format: "%0.2d:%0.2d.%0.1d", arguments: [($0 / 600) % 600, ($0 % 600 ) / 10, $0 % 10])}.bind(to: label.rx.text).disposed(by: disposeBag)
        
        //将数据绑定到attributeText属性上
        let label_2 = UILabel(frame:CGRect(x:100, y:150, width:300, height:100))
        view.addSubview(label_2)
        
        let timer_2 = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        timer_2.map(formatTimeInterval).bind(to: label_2.rx.attributedText).disposed(by: disposeBag)
        
    }
    
    func formatTimeInterval(ms: NSInteger) -> NSMutableAttributedString {
        let string = String(format: "%0.2d:%0.2d.%0.1d",
                            arguments: [(ms / 600) % 600, (ms % 600 ) / 10, ms % 10])
        //富文本设置
        let attributeString = NSMutableAttributedString(string: string)
        //从文本0开始6个字符字体HelveticaNeue-Bold,16号
        attributeString.addAttribute(NSAttributedString.Key.font,
                                     value: UIFont(name: "HelveticaNeue-Bold", size: 16)!,
                                     range: NSMakeRange(0, 5))
        //设置字体颜色
        attributeString.addAttribute(NSAttributedString.Key.foregroundColor,
                                     value: UIColor.white, range: NSMakeRange(0, 5))
        //设置文字背景颜色
        attributeString.addAttribute(NSAttributedString.Key.backgroundColor,
                                     value: UIColor.orange, range: NSMakeRange(0, 5))
        return attributeString
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
