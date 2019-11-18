//
//  UIControl+Chain.swift
//  CocoaChainKit
//
//  Created by GorXion on 2018/5/8.
//

public extension Chain where Base: UIControl {
    
    @discardableResult
    func isEnabled(_ isEnabled: Bool) -> Chain {
        base.isEnabled = isEnabled
        return self
    }
    
    @discardableResult
    func isSelected(_ isSelected: Bool) -> Chain {
        base.isSelected = isSelected
        return self
    }
    
    @discardableResult
    func isHighlighted(_ isHighlighted: Bool) -> Chain {
        base.isHighlighted = isHighlighted
        return self
    }
    
    @discardableResult
    func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) -> Chain {
        base.addTarget(target, action: action, for: controlEvents)
        return self
    }
}
