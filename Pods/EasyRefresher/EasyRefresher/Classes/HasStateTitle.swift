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
    
    func setTitle(_ title: String?, for state: RefreshState)
    
    func setAttributedTitle(_ title: NSAttributedString?, for state: RefreshState)
    
    func title(for state: RefreshState) -> String?
    
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
