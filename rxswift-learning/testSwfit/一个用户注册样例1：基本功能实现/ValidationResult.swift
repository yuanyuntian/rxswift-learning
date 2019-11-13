//
//  ValidationResult.swift
//  rxswift-learning
//
//  Created by yf on 2019/11/13.
//  Copyright © 2019 yuanf. All rights reserved.
//

import Foundation
import UIKit


enum ValidationResult {
    case validating //正在验证中
    case empty //输入为空
    case ok(message:String)//验证通过
    case failed(message:String)//验证失败
}

extension ValidationResult {
    var isValid:Bool{
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}

extension ValidationResult:CustomStringConvertible {
    var description: String{
        switch self {
        case .validating:
            return "正在验证..."
        case .empty:
            return ""
        case let .ok(message):
            return message
        case let .failed(message):
            return message
        }
    }
}

extension ValidationResult {
    var textColor:UIColor {
        switch self {
        case .validating:
            return UIColor.gray
        case .empty:
            return UIColor.black
        case .ok:
            return UIColor(red: 0/255, green: 130/255, blue: 0/255, alpha: 1)
        case .failed:
            return UIColor.red
        }
    }
}
