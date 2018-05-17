//
//  UISwitch+Chain.swift
//  CocoaChainKit
//
//  Created by GorXion on 2018/5/15.
//

public extension Chain where Base: UISwitch {
    
    @discardableResult
    func onTintColor(_ onTintColor: UIColor?) -> Chain {
        base.onTintColor = onTintColor
        return self
    }
    
    @discardableResult
    func thumbTintColor(_ thumbTintColor: UIColor?) -> Chain {
        base.thumbTintColor = thumbTintColor
        return self
    }
    
    @discardableResult
    func onImage(_ onImage: UIImage?) -> Chain {
        base.onImage = onImage
        return self
    }
    
    @discardableResult
    func offImage(_ offImage: UIImage?) -> Chain {
        base.offImage = offImage
        return self
    }
    
    @discardableResult
    func isOn(_ isOn: Bool) -> Chain {
        base.isOn = isOn
        return self
    }
}
