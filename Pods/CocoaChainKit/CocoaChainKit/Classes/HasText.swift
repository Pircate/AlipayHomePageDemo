//
//  HasText.swift
//  CocoaChainKit
//
//  Created by GorXion on 2018/8/7.
//

public protocol HasText {
    
    func set(text: String?)
    
    func set(attributedText: NSAttributedString?)
    
    func set(color: UIColor)
    
    func set(alignment: NSTextAlignment)
}

extension UILabel: HasText {
    
    public func set(text: String?) {
        self.text = text
    }
    
    public func set(attributedText: NSAttributedString?) {
        self.attributedText = attributedText
    }
    
    public func set(color: UIColor) {
        self.textColor = color
    }
    
    public func set(alignment: NSTextAlignment) {
        self.textAlignment = alignment
    }
}

extension UITextField: HasText {
    
    public func set(text: String?) {
        self.text = text
    }
    
    public func set(attributedText: NSAttributedString?) {
        self.attributedText = attributedText
    }
    
    public func set(color: UIColor) {
        self.textColor = color
    }
    
    public func set(alignment: NSTextAlignment) {
        self.textAlignment = alignment
    }
}

extension UITextView: HasText {
    
    public func set(text: String?) {
        self.text = text
    }
    
    public func set(attributedText: NSAttributedString?) {
        self.attributedText = attributedText
    }
    
    public func set(color: UIColor) {
        self.textColor = color
    }
    
    public func set(alignment: NSTextAlignment) {
        self.textAlignment = alignment
    }
}
