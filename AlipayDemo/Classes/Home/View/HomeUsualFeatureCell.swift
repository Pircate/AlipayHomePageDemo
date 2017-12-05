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
        let iconLabel = UILabel()
        iconLabel.font = UIFont(name: "IconFont", size: 24)
        iconLabel.textAlignment = .center
        return iconLabel
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        return titleLabel
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
    
    func setupUsualFeatureInfo(info: [String: Any]) {
        iconLabel.text = info["featureIcon"] as? String
        titleLabel.text = info["featureName"] as? String
    }
}
