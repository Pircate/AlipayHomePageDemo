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
    
    /// The state of refresher.
    var state: RefreshState { get }
    
    /// A Boolean value indicating whether the refresher's state is refreshing.
    var isRefreshing: Bool { get }
    
    /// Default is true. If false, end refreshing and set state to disabled.
    var isEnabled: Bool { get set }
    
    /// The callback in refresh.
    var refreshClosure: () -> Void { get set }
    
    /// Add a refresh callback to refresher.
    /// - Parameter refreshClosure: The callback in refresh.
    func addRefreshClosure(_ refreshClosure: @escaping () -> Void)
    
    /// Begin refreshing and set state to refreshing.
    func beginRefreshing()
    
    /// End Refreshing and set state to idle.
    func endRefreshing()
}

public extension Refreshable {
    
    var isRefreshing: Bool {
        return state == .refreshing
    }
}
