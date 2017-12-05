//
//  HomeCommonFeatureView.swift
//  AlipayDemo
//
//  Created by gaoX on 2017/12/5.
//  Copyright © 2017年 adinnet. All rights reserved.
//

import UIKit

class HomeCommonFeatureView: UIView {
    
    var contentView = UIView()

    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 100))
        self.backgroundColor = .global
        addSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addSubviews() {
        
        self.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(self)
        }
        
        let features = [["featureName": "扫一扫",
                         "featureIcon": ""],
                        ["featureName": "付钱",
                         "featureIcon": ""],
                        ["featureName": "收钱",
                         "featureIcon": ""],
                        ["featureName": "账单",
                         "featureIcon": ""],]
        
        let itemWidth = kScreenWidth / 4
        for (index, feature) in features.enumerated() {
            
            let btn = UIButton(type: .system)
            btn.setTitle(feature["featureIcon"], for: .normal)
            btn.setTitleColor(.white, for: .normal)
            btn.titleLabel?.font = UIFont(name: "IconFont", size: 32)
            btn.addTarget(self, action: #selector(btnAction(sender:)), for: .touchUpInside)
            contentView.addSubview(btn)
            
            let label = UILabel()
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 14)
            label.text = feature["featureName"]
            label.textAlignment = .center
            contentView.addSubview(label)
            
            btn.snp.makeConstraints({ (make) in
                make.top.equalTo(contentView)
                make.left.equalTo(contentView.snp.left).offset(itemWidth * CGFloat(index))
                make.size.equalTo(CGSize(width: itemWidth, height: 70))
            })
            
            label.snp.makeConstraints({ (make) in
                make.centerX.equalTo(btn.snp.centerX)
                make.top.equalTo(btn.snp.bottom)
            })
        }
    }
    
    func btnAction(sender: UIButton) {
        print("click")
    }
}
