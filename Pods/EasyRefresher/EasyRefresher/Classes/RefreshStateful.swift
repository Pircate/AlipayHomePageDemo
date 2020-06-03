// 
//  RefreshStateView.swift
//  EasyRefresher
//
//  Created by Pircate(swifter.dev@gmail.com) on 2019/5/12
//  Copyright © 2019 Pircate. All rights reserved.
//

public protocol RefreshStateful: class {
    
    /// refresher state did change
    /// - Parameters:
    ///   - refresher: refresher
    ///   - state: state of refresh.
    func refresher(_ refresher: Refresher, didChangeState state: RefreshState)
    
    /// refresher offset did change
    /// - Parameters:
    ///   - refresher: refresher
    ///   - offset: offset of refresher when pulling.
    func refresher(_ refresher: Refresher, didChangeOffset offset: CGFloat)
}
