//
//  UINavigationBar+Chain.swift
//  CocoaChainKit
//
//  Created by GorXion on 2018/5/8.
//

public extension Chain where Base: UINavigationBar {
    
    @discardableResult
    func barStyle(_ barStyle: UIBarStyle) -> Chain {
        base.barStyle = barStyle
        return self
    }
    
    @discardableResult
    func isTranslucent(_ isTranslucent: Bool) -> Chain {
        base.isTranslucent = isTranslucent
        return self
    }
    
    @discardableResult
    func barTintColor(_ barTintColor: UIColor?) -> Chain {
        base.barTintColor = barTintColor
        return self
    }
    
    @discardableResult
    func backgroundImage(_ backgroundImage: UIImage?, for barPosition: UIBarPosition = .any, barMetrics: UIBarMetrics = .default) -> Chain {
        base.setBackgroundImage(backgroundImage, for: barPosition, barMetrics: barMetrics)
        return self
    }
    
    @discardableResult
    func shadowImage(_ shadowImage: UIImage?) -> Chain {
        base.shadowImage = shadowImage
        return self
    }
    
    @discardableResult
    func titleTextAttributes(_ titleTextAttributes: [NSAttributedString.Key : Any]?) -> Chain {
        base.titleTextAttributes = titleTextAttributes
        return self
    }
    
    @discardableResult
    func prefersLargeTitles(_ prefersLargeTitles: Bool) -> Chain {
        if #available(iOS 11.0, *) {
            base.prefersLargeTitles = prefersLargeTitles
        }
        return self
    }
    
    @discardableResult
    func largeTitleTextAttributes(_ largeTitleTextAttributes: [NSAttributedString.Key : Any]?) -> Chain {
        if #available(iOS 11.0, *) {
            base.largeTitleTextAttributes = largeTitleTextAttributes
        }
        return self
    }
}
