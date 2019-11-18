// 
//  RefreshStateView.swift
//  EasyRefresher
//
//  Created by Pircate(swifter.dev@gmail.com) on 2019/5/12
//  Copyright © 2019 Pircate. All rights reserved.
//

public protocol RefreshStateful: class {
    
    func refresher(_ refresher: Refresher, didChangeState state: RefreshState)
}
