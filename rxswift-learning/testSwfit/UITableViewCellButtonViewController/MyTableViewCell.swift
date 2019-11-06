//
//  MyTableViewCell.swift
//  testSwfit
//
//  Created by yf on 2019/11/6.
//  Copyright © 2019 yuanf. All rights reserved.
//

import UIKit
import RxSwift


class MyTableViewCell: UITableViewCell {

    var disposeBag = DisposeBag()
    lazy var button:UIButton = {
        let v = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        v.backgroundColor = .red
        v.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(button)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
