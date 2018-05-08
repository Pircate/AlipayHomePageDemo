//
//  UIActivityIndicatorView+Chain.swift
//  CocoaChainKit
//
//  Created by GorXion on 2018/5/8.
//

public extension Chain where Base: UIActivityIndicatorView {
    
    @discardableResult
    func activityIndicatorViewStyle(_ activityIndicatorViewStyle: UIActivityIndicatorViewStyle) -> Chain {
        base.activityIndicatorViewStyle = activityIndicatorViewStyle
        return self
    }
    
    @discardableResult
    func hidesWhenStopped(_ hidesWhenStopped: Bool) -> Chain {
        base.hidesWhenStopped = hidesWhenStopped
        return self
    }
    
    @discardableResult
    func color(_ color: UIColor?) -> Chain {
        base.color = color
        return self
    }
}
