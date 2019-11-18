// 
//  Displayable.swift
//  EasyRefresher
//
//  Created by Pircate(swifter.dev@gmail.com) on 2019/5/9
//  Copyright © 2019 Pircate. All rights reserved.
//

public protocol Displayable {
    
    var alpha: CGFloat { get set }
    
    var backgroundColor: UIColor? { get set }
    
    var automaticallyChangeAlpha: Bool { get set }
}
