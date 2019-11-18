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
    func borderStyle(_ borderStyle: UITextField.BorderStyle) -> Chain {
        base.borderStyle = borderStyle
        return self
    }
    
    @discardableResult
    func defaultTextAttributes(_ defaultTextAttributes: [String: Any]) -> Chain {
        #if swift(>=4.2)
        base.defaultTextAttributes = convertToNSAttributedStringKeyDictionary(defaultTextAttributes)
        #else
        base.defaultTextAttributes = defaultTextAttributes
        #endif
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
    func typingAttributes(_ typingAttributes: [String: Any]?) -> Chain {
        #if swift(>=4.2)
        base.typingAttributes = convertToOptionalNSAttributedStringKeyDictionary(typingAttributes)
        #else
        base.typingAttributes = typingAttributes
        #endif
        return self
    }
    
    @discardableResult
    func clearButtonMode(_ clearButtonMode: UITextField.ViewMode) -> Chain {
        base.clearButtonMode = clearButtonMode
        return self
    }
    
    @discardableResult
    func leftView(_ leftView: UIView?) -> Chain {
        base.leftView = leftView
        return self
    }
    
    @discardableResult
    func leftViewMode(_ leftViewMode: UITextField.ViewMode) -> Chain {
        base.leftViewMode = leftViewMode
        return self
    }
    
    @discardableResult
    func rightView(_ rightView: UIView?) -> Chain {
        base.rightView = rightView
        return self
    }
    
    @discardableResult
    func rightViewMode(_ rightViewMode: UITextField.ViewMode) -> Chain {
        base.rightViewMode = rightViewMode
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
    
    @discardableResult
    func isSecureTextEntry(_ isSecureTextEntry: Bool) -> Chain {
        base.isSecureTextEntry = isSecureTextEntry
        return self
    }
    
    @discardableResult
    func textContentType(_ textContentType: UITextContentType) -> Chain {
        if #available(iOS 10.0, *) {
            base.textContentType = textContentType
        }
        return self
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToNSAttributedStringKeyDictionary(_ input: [String: Any])
    -> [NSAttributedString.Key: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in
        (NSAttributedString.Key(rawValue: key), value)
    })
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in
        (NSAttributedString.Key(rawValue: key), value)
    })
}
