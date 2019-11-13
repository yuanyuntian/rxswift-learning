//
//  BindingExtensions.swift
//  rxswift-learning
//
//  Created by yf on 2019/11/13.
//  Copyright © 2019 yuanf. All rights reserved.
//

import Foundation

import UIKit
import RxCocoa
import RxSwift

//扩展UILabel

extension Reactive where Base:UILabel {
    //让验证结果可以绑定到label上
    
    var validationResult:Binder<ValidationResult> {
        return Binder(base) {
            label, result in
            label.textColor = result.textColor
            label.text = result.description
        }
    }
}
