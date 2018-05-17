//
//  UIButton+Chain.swift
//  CocoaChainKit
//
//  Created by GorXion on 2018/5/8.
//

public extension Chain where Base: UIButton {
    
    @discardableResult
    func title(_ title: String?, for state: UIControlState...) -> Chain {
        state.forEach({ base.setTitle(title, for: $0) })
        return self
    }
    
    @discardableResult
    func titleColor(_ color: UIColor?, for state: UIControlState...) -> Chain {
        state.forEach({ base.setTitleColor(color, for: $0) })
        return self
    }
    
    @discardableResult
    func image(_ image: UIImage?, for state: UIControlState...) -> Chain {
        state.forEach({ base.setImage(image, for: $0) })
        return self
    }
    
    @discardableResult
    func backgroundImage(_ image: UIImage?, for state: UIControlState...) -> Chain {
        state.forEach({ base.setBackgroundImage(image, for: $0) })
        
        return self
    }
    
    @discardableResult
    func attributedTitle(_ attributedTitle: NSAttributedString?, for state: UIControlState...) -> Chain {
        state.forEach({ base.setAttributedTitle(attributedTitle, for: $0) })
        return self
    }
    
    @discardableResult
    func titleEdgeInsets(_ edgeInsets: UIEdgeInsets) -> Chain {
        base.titleEdgeInsets = edgeInsets
        return self
    }
    
    @discardableResult
    func titleEdgeInsets(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> Chain {
        base.titleEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
    
    @discardableResult
    func imageEdgeInsets(_ edgeInsets: UIEdgeInsets) -> Chain {
        base.imageEdgeInsets = edgeInsets
        return self
    }
    
    @discardableResult
    func imageEdgeInsets(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> Chain {
        base.imageEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
    
    @discardableResult
    func font(_ font: UIFont) -> Chain {
        base.titleLabel?.font = font
        return self
    }
    
    @discardableResult
    func systemFont(ofSize fontSize: CGFloat) -> Chain {
        base.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        return self
    }
    
    @discardableResult
    func boldSystemFont(ofSize fontSize: CGFloat) -> Chain {
        base.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
        return self
    }
}
