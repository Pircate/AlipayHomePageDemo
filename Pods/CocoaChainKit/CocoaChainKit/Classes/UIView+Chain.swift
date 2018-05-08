//
//  UIView+Chain.swift
//  CocoaChainKit
//
//  Created by GorXion on 2018/5/8.
//

extension UIView: ChainCompatible {}

public extension Chain where Base: UIView {
    
    @discardableResult
    func tag(_ tag: Int) -> Chain {
        base.tag = tag
        return self
    }
    
    @discardableResult
    func frame(_ frame: CGRect) -> Chain {
        base.frame = frame
        return self
    }
    
    @discardableResult
    func frame(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> Chain {
        base.frame = CGRect(x: x, y: y, width: width, height: height)
        return self
    }
    
    @discardableResult
    func bounds(_ bounds: CGRect) -> Chain {
        base.bounds = bounds
        return self
    }
    
    @discardableResult
    func center(_ center: CGPoint) -> Chain {
        base.center = center
        return self
    }
    
    @discardableResult
    func center(x: CGFloat, y: CGFloat) -> Chain {
        base.center = CGPoint(x: x, y: y)
        return self
    }
    
    @discardableResult
    func backgroundColor(_ backgroundColor: UIColor) -> Chain {
        base.backgroundColor = backgroundColor
        return self
    }
    
    @discardableResult
    func contentMode(_ contentMode: UIViewContentMode) -> Chain {
        base.contentMode = contentMode
        return self
    }
    
    @discardableResult
    func clipsToBounds(_ clipsToBounds: Bool) -> Chain {
        base.clipsToBounds = clipsToBounds
        return self
    }
    
    @discardableResult
    func alpha(_ alpha: CGFloat) -> Chain {
        base.alpha = alpha
        return self
    }
    
    @discardableResult
    func isHidden(_ isHidden: Bool) -> Chain {
        base.isHidden = isHidden
        return self
    }
    
    @discardableResult
    func isOpaque(_ isOpaque: Bool) -> Chain {
        base.isOpaque = isOpaque
        return self
    }
    
    @discardableResult
    func isUserInteractionEnabled(_ isUserInteractionEnabled: Bool) -> Chain {
        base.isUserInteractionEnabled = isUserInteractionEnabled
        return self
    }
    
    @discardableResult
    func tintColor(_ tintColor: UIColor) -> Chain {
        base.tintColor = tintColor
        return self
    }
    
    @discardableResult
    func cornerRadius(_ cornerRadius: CGFloat) -> Chain {
        base.layer.cornerRadius = cornerRadius
        return self
    }
    
    @discardableResult
    func masksToBounds(_ masksToBounds: Bool) -> Chain {
        base.layer.masksToBounds = masksToBounds
        return self
    }
    
    @discardableResult
    func borderWidth(_ borderWidth: CGFloat) -> Chain {
        base.layer.borderWidth = borderWidth
        return self
    }
    
    @discardableResult
    func borderColor(_ borderColor: UIColor) -> Chain {
        base.layer.borderColor = borderColor.cgColor
        return self
    }
    
    @discardableResult
    func shadowColor(_ shadowColor: UIColor?) -> Chain {
        base.layer.shadowColor = shadowColor?.cgColor
        return self
    }
    
    @discardableResult
    func shadowOpacity(_ shadowOpacity: Float) -> Chain {
        base.layer.shadowOpacity = shadowOpacity
        return self
    }
    
    @discardableResult
    func shadowOffset(_ shadowOffset: CGSize) -> Chain {
        base.layer.shadowOffset = shadowOffset
        return self
    }
    
    @discardableResult
    func shadowRadius(_ shadowRadius: CGFloat) -> Chain {
        base.layer.shadowRadius = shadowRadius
        return self
    }
    
    @discardableResult
    func shadowPath(_ shadowPath: CGPath?) -> Chain {
        base.layer.shadowPath = shadowPath
        return self
    }
}
