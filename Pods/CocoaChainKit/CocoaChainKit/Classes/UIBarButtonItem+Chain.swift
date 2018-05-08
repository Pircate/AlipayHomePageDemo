//
//  UIBarButtonItem+Chain.swift
//  CocoaChainKit
//
//  Created by GorXion on 2018/5/8.
//

public extension Chain where Base: UIBarButtonItem {
    
    @discardableResult
    func width(_ width: CGFloat) -> Chain {
        base.width = width
        return self
    }
    
    @discardableResult
    func tintColor(_ tintColor: UIColor?) -> Chain {
        base.tintColor = tintColor
        return self
    }
}
