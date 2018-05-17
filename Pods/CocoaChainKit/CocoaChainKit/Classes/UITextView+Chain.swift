//
//  UITextView+Chain.swift
//  CocoaChainKit
//
//  Created by GorXion on 2018/5/8.
//

public extension Chain where Base: UITextView {
    
    @discardableResult
    func delegate(_ delegate: UITextViewDelegate?) -> Chain {
        base.delegate = delegate
        return self
    }
    
    @discardableResult
    func text(_ text: String) -> Chain {
        base.text = text
        return self
    }
    
    @discardableResult
    func attributedText(_ attributedText: NSAttributedString) -> Chain {
        base.attributedText = attributedText
        return self
    }
    
    @discardableResult
    func textColor(_ textColor: UIColor) -> Chain {
        base.textColor = textColor
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
    func textAlignment(_ textAlignment: NSTextAlignment) -> Chain {
        base.textAlignment = textAlignment
        return self
    }
    
    @discardableResult
    func isEditable(_ isEditable: Bool) -> Chain {
        base.isEditable = isEditable
        return self
    }
    
    @discardableResult
    func isSelectable(_ isSelectable: Bool) -> Chain {
        base.isSelectable = isSelectable
        return self
    }
    
    @discardableResult
    func textContainerInset(_ textContainerInset: UIEdgeInsets) -> Chain {
        base.textContainerInset = textContainerInset
        return self
    }
    
    @discardableResult
    func dataDetectorTypes(_ dataDetectorTypes: UIDataDetectorTypes) -> Chain {
        base.dataDetectorTypes = dataDetectorTypes
        return self
    }
    
    @discardableResult
    func allowsEditingTextAttributes(_ allowsEditingTextAttributes: Bool) -> Chain {
        base.allowsEditingTextAttributes = allowsEditingTextAttributes
        return self
    }
    
    @discardableResult
    func keyboardType(_ keyboardType: UIKeyboardType) -> Chain {
        base.keyboardType = keyboardType
        return self
    }
    
    @discardableResult
    func returnKeyType(_ returnKeyType: UIReturnKeyType) -> Chain {
        base.returnKeyType = returnKeyType
        return self
    }
}
