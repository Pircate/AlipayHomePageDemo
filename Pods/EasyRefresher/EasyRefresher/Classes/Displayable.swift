// 
//  Displayable.swift
//  EasyRefresher
//
//  Created by Pircate(swifter.dev@gmail.com) on 2019/5/9
//  Copyright © 2019 Pircate. All rights reserved.
//

public protocol Displayable {
    
    /// The alpha value of refresher's view.
    var alpha: CGFloat { get set }
    
    /// The background color of refresher's view.
    var backgroundColor: UIColor? { get set }
    
    /// A Boolean value indicating whether the refresher automatically change view's alpha value when pulling.
    var automaticallyChangeAlpha: Bool { get set }
    
    // The height of refresher's view.
    var height: CGFloat { get }
}
