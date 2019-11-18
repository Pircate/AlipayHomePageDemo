//
//  UIActivityIndicatorView+Chain.swift
//  CocoaChainKit
//
//  Created by GorXion on 2018/5/8.
//

public extension Chain where Base: UIActivityIndicatorView {
    
    @discardableResult
    func activityIndicatorViewStyle(_ activityIndicatorViewStyle: UIActivityIndicatorView.Style) -> Chain {
        #if swift(>=4.2)
        base.style = activityIndicatorViewStyle
        #else
        base.activityIndicatorViewStyle = activityIndicatorViewStyle
        #endif
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
