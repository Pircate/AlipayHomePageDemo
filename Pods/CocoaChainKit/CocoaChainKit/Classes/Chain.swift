//
//  Chain.swift
//  CocoaChainKit
//
//  Created by GorXion on 2018/5/8.
//

public struct Chain<Base> {
    
    let base: Base
    
    public var installed: Base {
        return base
    }
    
    public init(_ base: Base) {
        self.base = base
    }
}
