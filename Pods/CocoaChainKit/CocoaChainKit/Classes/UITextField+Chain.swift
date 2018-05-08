//
//  UITextField+Chain.swift
//  CocoaChainKit
//
//  Created by GorXion on 2018/5/8.
//

public extension Chain where Base: UITextField {
    
    @discardableResult
    func delegate(_ delegate: UITextFieldDelegate?) -> Chain {
        base.delegate = delegate
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
    func placeholder(_ placeholder: String?) -> Chain {
        base.placeholder = placeholder
        return self
    }
    
    @discardableResult
    func attributedPlaceholder(_ attributedPlaceholder: NSAttributedString?) -> Chain {
        base.attributedPlaceholder = attributedPlaceholder
        return self
    }
    
    @discardableResult
    func borderStyle(_ borderStyle: UITextBorderStyle) -> Chain {
        base.borderStyle = borderStyle
        return self
    }
    
    @discardableResult
    func defaultTextAttributes(_ defaultTextAttributes: [String: Any]) -> Chain {
        base.defaultTextAttributes = defaultTextAttributes
        return self
    }
    
    @discardableResult
    func clearsOnBeginEditing(_ clearsOnBeginEditing: Bool) -> Chain {
        base.clearsOnBeginEditing = clearsOnBeginEditing
        return self
    }
    
    @discardableResult
    func adjustsFontSizeToFitWidth(_ adjustsFontSizeToFitWidth: Bool) -> Chain {
        base.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        return self
    }
    
    @discardableResult
    func minimumFontSize(_ minimumFontSize: CGFloat) -> Chain {
        base.minimumFontSize = minimumFontSize
        return self
    }
    
    @discardableResult
    func allowsEditingTextAttributes(_ allowsEditingTextAttributes: Bool) -> Chain {
        base.allowsEditingTextAttributes = allowsEditingTextAttributes
        return self
    }
    
    @discardableResult
    func clearButtonMode(_ clearButtonMode: UITextFieldViewMode) -> Chain {
        base.clearButtonMode = clearButtonMode
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
