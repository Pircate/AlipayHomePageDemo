//
//  UIViewControllerExtension.swift
//  iWeeB
//
//  Created by gaoX on 2017/12/4.
//  Copyright © 2017年 GaoX. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func disableAdjustsScrollViewInsets(_ scrollView: UIScrollView) {
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
}
