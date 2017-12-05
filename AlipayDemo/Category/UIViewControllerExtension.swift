//
//  UIViewControllerExtension.swift
//  iWeeB
//
//  Created by gaoX on 2017/12/4.
//  Copyright © 2017年 GaoX. All rights reserved.
//

import Foundation

extension UIViewController {
    
    func disableAdjustsScrollViewInsets(_ scrollView: UIScrollView) {
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    func alert(title: String?,
             message: String?,
      preferredStyle: UIAlertControllerStyle = .alert,
         cancelTitle: String?,
         otherTitles: [String],
   completionHandler: @escaping (_ buttonIndex: Int) -> ()) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        if let title = cancelTitle {
            alert.addAction(UIAlertAction(title: title, style: .cancel, handler: { (action) in
                completionHandler(0)
            }))
        }
        
        if !otherTitles.isEmpty {
            for (index, title) in otherTitles.enumerated() {
                alert.addAction(UIAlertAction(title: title, style: .default, handler: { (action) in
                    completionHandler(index + 1)
                }))
            }
        }
        
        present(alert, animated: true, completion: nil)
    }
}
