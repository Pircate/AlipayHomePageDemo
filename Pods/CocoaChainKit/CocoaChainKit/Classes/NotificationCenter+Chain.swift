//
//  NotificationCenter+Chain.swift
//  CocoaChainKit
//
//  Created by GorXion on 2018/5/9.
//

public extension Chain where Base: NotificationCenter {
    
    @discardableResult
    func addObserver(_ observer: Any,
                     selector aSelector: Selector,
                     name aName: NSNotification.Name?,
                     object anObject: Any? = nil) -> Chain {
        base.addObserver(observer, selector: aSelector, name: aName, object: anObject)
        return self
    }
    
    @discardableResult
    func post(_ notification: Notification) -> Chain {
        base.post(notification)
        return self
    }
    
    @discardableResult
    func post(name aName: NSNotification.Name,
              object anObject: Any? = nil,
              userInfo aUserInfo: [AnyHashable : Any]? = nil) -> Chain {
        base.post(name: aName, object: anObject, userInfo: aUserInfo)
        return self
    }
    
    @discardableResult
    func removeObserver(_ observer: Any,
                        name aName: NSNotification.Name?,
                        object anObject: Any?) -> Chain {
        base.removeObserver(observer, name: aName, object: anObject)
        return self
    }
}
