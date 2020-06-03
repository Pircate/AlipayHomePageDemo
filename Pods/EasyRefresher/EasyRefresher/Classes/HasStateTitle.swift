// 
//  HasStateTitle.swift
//  EasyRefresher
//
//  Created by Pircate(swifter.dev@gmail.com) on 2019/5/8
//  Copyright © 2019 Pircate. All rights reserved.
//

public protocol HasStateTitle: class {
    
    var stateTitles: [RefreshState: String] { get set }
    
    var stateAttributedTitles: [RefreshState: NSAttributedString] { get set }
    
    /// Sets the title to use for the specified state.
    /// - Parameters:
    ///   - title: The title to use for the specified state.
    ///   - state: The state that uses the specified title. The possible values are described in RefreshState.
    func setTitle(_ title: String?, for state: RefreshState)
    
    /// Sets the styled title to use for the specified state.
    /// - Parameters:
    ///   - title: The styled text string to use for the title.
    ///   - state: The state that uses the specified title. The possible values are described in RefreshState.
    func setAttributedTitle(_ title: NSAttributedString?, for state: RefreshState)
    
    /// Returns the title associated with the specified state.
    /// - Parameter state: The state that uses the title. The possible values are described in RefreshState.
    func title(for state: RefreshState) -> String?
    
    /// Returns the styled title associated with the specified state.
    /// - Parameter state: The state that uses the styled title. The possible values are described in RefreshState.
    func attributedTitle(for state: RefreshState) -> NSAttributedString?
}

public extension HasStateTitle {
    
    func setTitle(_ title: String?, for state: RefreshState) {
        stateTitles[state] = title
    }
    
    func setAttributedTitle(_ title: NSAttributedString?, for state: RefreshState) {
        stateAttributedTitles[state] = title
    }
    
    func title(for state: RefreshState) -> String? {
        return stateTitles[state]
    }
    
    func attributedTitle(for state: RefreshState) -> NSAttributedString? {
        return stateAttributedTitles[state]
    }
}
