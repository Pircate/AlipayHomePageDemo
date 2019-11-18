//
//  HasFont+Chain.swift
//  CocoaChainKit
//
//  Created by GorXion on 2018/6/28.
//

public extension Chain where Base: HasFont {
    
    @discardableResult
    func font(_ font: UIFont) -> Chain {
        base.set(font: font)
        return self
    }
    
    @discardableResult
    func systemFont(ofSize fontSize: CGFloat) -> Chain {
        base.set(font: UIFont.systemFont(ofSize: fontSize))
        return self
    }
    
    @discardableResult
    func boldSystemFont(ofSize fontSize: CGFloat) -> Chain {
        base.set(font: UIFont.boldSystemFont(ofSize: fontSize))
        return self
    }
    
    @discardableResult
    func systemFont(ofSize fontSize: CGFloat, weight: UIFont.Weight) -> Chain {
        base.set(font: UIFont.systemFont(ofSize: fontSize, weight: weight))
        return self
    }
}
