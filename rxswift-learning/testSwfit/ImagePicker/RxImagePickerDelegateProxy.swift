//
//  RxImagePickerDelegateProxy.swift
//  rxswift-learning
//
//  Created by yf on 2019/11/15.
//  Copyright © 2019 yuanf. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit

open class RxImagePickerDelegateProxy:RxNavigationControllerDelegateProxy,UIImagePickerControllerDelegate {
    public init(imagePicker: UIImagePickerController) {
        super.init(navigationController: imagePicker)
    }
}
