//
//  UISwitchUISegmentControlViewController.swift
//  rxswift-learning
//
//  Created by yf on 2019/11/12.
//  Copyright © 2019 yuanf. All rights reserved.
//

import UIKit

class UISwitchUISegmentControlViewController: UIViewController {

    let disposeBag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "UI控件扩展4：UISwitch、UISegmentedControl"
        view.backgroundColor = UIColor.white
        
        //UISwitch
        let mySwitch = UISwitch(frame: CGRect(x:10, y:20, width:80, height:30))
        view.addSubview(mySwitch)
        mySwitch.rx.isOn.asObservable().subscribe(onNext:{print("当前状态：\($0)")}).disposed(by: disposeBag)
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x:10 ,y:70, width:50, height:30)
        button.setTitle("点击", for: .normal)
        view.addSubview(button)
        
        mySwitch.rx.isOn.bind(to: button.rx.isEnabled).disposed(by: disposeBag)
        
        //UIApplication
        mySwitch.rx.value.bind(to: UIApplication.shared.rx.isNetworkActivityIndicatorVisible).disposed(by: disposeBag)
        
        //UISegmentControl
        let segment = UISegmentedControl(frame: CGRect(x:10, y:110, width:150, height:30))
        view.addSubview(segment)
        
        segment.rx.selectedSegmentIndex.asObservable().subscribe(onNext: {print("当前项：\($0)")}).disposed(by: disposeBag)
        let imageView = UIImageView(frame: CGRect(x:10, y:150, width:50, height:50))
        view.addSubview(imageView)
        
        segment.rx.selectedSegmentIndex.asObservable().map {
            let images = ["js.png","php.png","react.png"]
            return UIImage(named:images[$0])!
        }.bind(to: imageView.rx.image).disposed(by: disposeBag)
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
