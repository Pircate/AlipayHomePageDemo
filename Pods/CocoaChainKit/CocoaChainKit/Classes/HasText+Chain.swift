//
//  HasText.swift
//  CocoaChainKit
//
//  Created by GorXion on 2018/8/7.
//

public extension Chain where Base: HasText {
    
    @discardableResult
    func text(_ text: String?) -> Chain {
        base.set(text: text)
        return self
    }
    
    @discardableResult
    func attributedText(_ attributedText: NSAttributedString?) -> Chain {
        base.set(attributedText: attributedText)
        return self
    }
    
    @discardableResult
    func textColor(_ textColor: UIColor) -> Chain {
        base.set(color: textColor)
        return self
    }
    
    @discardableResult
    func textAlignment(_ textAlignment: NSTextAlignment) -> Chain {
        base.set(alignment: textAlignment)
        return self
    }
}
