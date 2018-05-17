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
        super.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 80))
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
        
        let features = [(name: "扫一扫", icon: ""),
                        (name: "付钱", icon: ""),
                        (name: "收钱", icon: ""),
                        (name: "账单", icon: ""),]
        
        let itemWidth = kScreenWidth / 4
        for (index, feature) in features.enumerated() {
            
            let btn = UIButton(type: .system).chain
                .title(feature.icon, for: .normal)
                .titleColor(UIColor.white, for: .normal)
                .font(UIFont.iconFont(ofSize: 32))
                .addTarget(self, action: #selector(btnAction(sender:)), for: .touchUpInside).build
            contentView.addSubview(btn)
            
            let label = UILabel().chain
                .textColor(UIColor.white)
                .systemFont(ofSize: 14)
                .textAlignment(.center).build
            label.text = feature.name
            contentView.addSubview(label)
            
            btn.snp.makeConstraints({ (make) in
                make.top.equalTo(contentView)
                make.left.equalTo(contentView.snp.left).offset(itemWidth * CGFloat(index))
                make.size.equalTo(CGSize(width: itemWidth, height: 50))
            })
            
            label.snp.makeConstraints({ (make) in
                make.centerX.equalTo(btn.snp.centerX)
                make.top.equalTo(btn.snp.bottom)
            })
        }
    }
    
    @objc func btnAction(sender: UIButton) {
        print("click")
    }
}
