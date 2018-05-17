//
//  UILabel+Chain.swift
//  CocoaChainKit
//
//  Created by GorXion on 2018/5/8.
//

public extension Chain where Base: UILabel {
    
    @discardableResult
    func text(_ text: String?) -> Chain {
        base.text = text
        return self
    }
    
    @discardableResult
    func attributedText(_ attributedText: NSAttributedString?) -> Chain {
        base.attributedText = attributedText
        return self
    }
    
    @discardableResult
    func textColor(_ textColor: UIColor) -> Chain {
        base.textColor = textColor
        return self
    }
    
    @discardableResult
    func shadowColor(_ shadowColor: UIColor?) -> Chain {
        base.shadowColor = shadowColor
        return self
    }
    
    @discardableResult
    func shadowOffset(_ shadowOffset: CGSize) -> Chain {
        base.shadowOffset = shadowOffset
        return self
    }
    
    @discardableResult
    func shadowOffset(width: CGFloat, height: CGFloat) -> Chain {
        base.shadowOffset = CGSize(width: width, height: height)
        return self
    }
    
    @discardableResult
    func font(_ font: UIFont) -> Chain {
        base.font = font
        return self
    }
    
    @discardableResult
    func systemFont(ofSize fontSize: CGFloat) -> Chain {
        base.font = UIFont.systemFont(ofSize: fontSize)
        return self
    }
    
    @discardableResult
    func boldSystemFont(ofSize fontSize: CGFloat) -> Chain {
        base.font = UIFont.boldSystemFont(ofSize: fontSize)
        return self
    }
    
    @discardableResult
    func numberOfLines(_ numberOfLines: Int) -> Chain {
        base.numberOfLines = numberOfLines
        return self
    }
    
    @discardableResult
    func textAlignment(_ textAlignment: NSTextAlignment) -> Chain {
        base.textAlignment = textAlignment
        return self
    }
}
