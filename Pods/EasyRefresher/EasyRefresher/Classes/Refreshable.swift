// 
//  Refreshable.swift
//  EasyRefresher
//
//  Created by Pircate(swifter.dev@gmail.com) on 2019/4/26
//  Copyright © 2019 Pircate. All rights reserved.
//

public enum RefreshState {
    case idle
    case pulling
    case willRefresh
    case refreshing
    case disabled
}

public protocol Refreshable: class {
    
    var state: RefreshState { get }
    
    var isRefreshing: Bool { get }
    
    var isDisabled: Bool { get }
    
    var refreshClosure: () -> Void { get set }
    
    func addRefreshClosure(_ refreshClosure: @escaping () -> Void)
    
    func beginRefreshing()
    
    func endRefreshing()
    
    func enable()
    
    func disable()
}

public extension Refreshable {
    
    var isRefreshing: Bool {
        return state == .refreshing
    }
    
    var isDisabled: Bool {
        return state == .disabled
    }
}
