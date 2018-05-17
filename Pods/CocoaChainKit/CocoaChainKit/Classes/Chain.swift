//
//  Chain.swift
//  CocoaChainKit
//
//  Created by GorXion on 2018/5/8.
//

public struct Chain<Base> {
    
    public let base: Base
    
    public var build: Base {
        return base
    }
    
    public init(_ base: Base) {
        self.base = base
    }
}
