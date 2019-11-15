//
//  BaseViewController.swift
//  rxswift-learning
//
//  Created by yf on 2019/11/15.
//  Copyright © 2019 yuanf. All rights reserved.
//

import RxSwift

#if os(iOS)
    import UIKit
    typealias OSViewController = UIViewController

#elseif os(macOS)
    import RxCocoa
    typealias OSViewController = NSViewController
#endif

class BaseViewController: OSViewController {
    var disposeBag = DisposeBag()
}
