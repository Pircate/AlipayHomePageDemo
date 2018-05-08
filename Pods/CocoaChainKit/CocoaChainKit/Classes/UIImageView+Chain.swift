//
//  UIImageView+Chain.swift
//  CocoaChainKit
//
//  Created by GorXion on 2018/5/8.
//

public extension Chain where Base: UIImageView {
    
    @discardableResult
    func isHighlighted(_ isHighlighted: Bool) -> Chain {
        base.isHighlighted = isHighlighted
        return self
    }
}
