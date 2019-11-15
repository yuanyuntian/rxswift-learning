//
//  ImagePickerController.swift
//  rxswift-learning
//
//  Created by yf on 2019/11/15.
//  Copyright © 2019 yuanf. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa


class ImagePickerController: BaseViewController {

    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var galleryBtn: UIButton!
    @IBOutlet weak var cropBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cameraBtn.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        cameraBtn.rx.tap
            .flatMapLatest { [weak self] _ in
                return UIImagePickerController.rx.createWithParent(self) { picker in
                    picker.sourceType = .camera
                    picker.allowsEditing = false
                }
                .flatMap { $0.rx.didFinishPickingMediaWithInfo }
                .take(1)
            }
            .map { info in
                return info[.originalImage] as? UIImage
            }
            .bind(to: showImage.rx.image)
            .disposed(by: disposeBag)
        
        galleryBtn.rx.tap
            .flatMapLatest { [weak self] _ in
                return UIImagePickerController.rx.createWithParent(self) { picker in
                    picker.sourceType = .photoLibrary
                    picker.allowsEditing = false
                }
                .flatMap {
                    $0.rx.didFinishPickingMediaWithInfo
                }.take(1)
                
            }.debug()
            .map { info in
                return info[.originalImage] as? UIImage
            }
            .bind(to: showImage.rx.image)
            .disposed(by: disposeBag)
        
        cropBtn.rx.tap
            .flatMapLatest { [weak self] _ in
                return UIImagePickerController.rx.createWithParent(self) { picker in
                    picker.sourceType = .photoLibrary
                    picker.allowsEditing = true
                }
                .flatMap { $0.rx.didFinishPickingMediaWithInfo }
                .take(1)
            }.debug()
            .map { info in
                return info[.editedImage] as? UIImage
            }
            .bind(to: showImage.rx.image)
            .disposed(by: disposeBag)
        
    }
}
