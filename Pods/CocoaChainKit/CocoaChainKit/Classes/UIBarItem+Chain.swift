//
//  UIBarItem+Chain.swift
//  CocoaChainKit
//
//  Created by GorXion on 2018/5/8.
//

public extension Chain where Base: UIBarItem {
    
    @discardableResult
    func isEnabled(_ isEnabled: Bool) -> Chain {
        base.isEnabled = isEnabled
        return self
    }
    
    @discardableResult
    func titleTextAttributes(_ titleTextAttributes: [NSAttributedStringKey: Any]?, for state: UIControlState) -> Chain {
        base.setTitleTextAttributes(titleTextAttributes, for: state)
        return self
    }
}
