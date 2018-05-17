//
//  HomeUsualFeatureCell.swift
//  AlipayDemo
//
//  Created by gaoX on 2017/12/4.
//  Copyright © 2017年 adinnet. All rights reserved.
//

import UIKit
import SnapKit

class HomeUsualFeatureCell: UICollectionViewCell {
    
    lazy var iconLabel: UILabel = {
        return UILabel().chain.font(UIFont.iconFont(ofSize: 24)).textAlignment(.center).build
    }()
    
    lazy var titleLabel: UILabel = {
        return UILabel().chain.systemFont(ofSize: 12).textAlignment(.center).build
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(iconLabel)
        contentView.addSubview(titleLabel)
        
        iconLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(contentView)
            make.height.equalTo(contentView.snp.width)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconLabel.snp.bottom).offset(5)
            make.centerX.equalTo(contentView.snp.centerX)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupUsualFeatureInfo(info: (name: String, icon: String)) {
        iconLabel.text = info.icon
        titleLabel.text = info.name
    }
}
