//
//  UIImageView+Chain.swift
//  CocoaChainKit
//
//  Created by GorXion on 2018/5/8.
//

public extension Chain where Base: UIImageView {
    
    @discardableResult
    func image(_ image: UIImage?) -> Chain {
        base.image = image
        return self
    }
    
    @discardableResult
    func isHighlighted(_ isHighlighted: Bool) -> Chain {
        base.isHighlighted = isHighlighted
        return self
    }
}
