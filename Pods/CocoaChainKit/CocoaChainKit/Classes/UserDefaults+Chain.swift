//
//  UserDefaults+Chain.swift
//  CocoaChainKit
//
//  Created by GorXion on 2018/5/9.
//

public extension Chain where Base: UserDefaults {
    
    @discardableResult
    func removeObject(forKey defaultName: String) -> Chain {
        base.removeObject(forKey: defaultName)
        return self
    }
    
    @discardableResult
    func set(_ value: Any?, forKey defaultName: String) -> Chain {
        base.set(value, forKey: defaultName)
        return self
    }
    
    @discardableResult
    func set(_ value: Bool, forKey defaultName: String) -> Chain {
        base.set(value, forKey: defaultName)
        return self
    }
    
    @discardableResult
    func set(_ value: Int, forKey defaultName: String) -> Chain {
        base.set(value, forKey: defaultName)
        return self
    }
    
    @discardableResult
    func set(_ value: Double, forKey defaultName: String) -> Chain {
        base.set(value, forKey: defaultName)
        return self
    }
    
    @discardableResult
    func set(_ value: Float, forKey defaultName: String) -> Chain {
        base.set(value, forKey: defaultName)
        return self
    }
    
    @discardableResult
    func set(_ url: URL?, forKey defaultName: String) -> Chain {
        base.set(url, forKey: defaultName)
        return self
    }
    
    @discardableResult
    func synchronize() -> Bool {
        return base.synchronize()
    }
}
