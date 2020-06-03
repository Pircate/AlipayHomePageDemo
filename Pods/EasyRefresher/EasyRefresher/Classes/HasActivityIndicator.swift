// 
//  HasActivityIndicator.swift
//  EasyRefresher
//
//  Created by Pircate(swifter.dev@gmail.com) on 2019/5/9
//  Copyright © 2019 Pircate. All rights reserved.
//

public protocol HasActivityIndicator {
    
    /// The basic appearance of the refresher's activity indicator.
    var activityIndicatorStyle: UIActivityIndicatorView.Style { get set }
}
