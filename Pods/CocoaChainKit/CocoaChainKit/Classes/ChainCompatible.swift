//
//  ChainCompatible.swift
//  CocoaChainKit
//
//  Created by GorXion on 2018/5/8.
//

public protocol ChainCompatible {
    
    associatedtype CompatibleType
    
    var chain: CompatibleType { get }
}

public extension ChainCompatible {
    
    var chain: Chain<Self> {
        return Chain(self)
    }
}

extension NSObject: ChainCompatible {}
