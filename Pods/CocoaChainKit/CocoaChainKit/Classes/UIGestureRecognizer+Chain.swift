//
//  UIGestureRecognizer+Chain.swift
//  CocoaChainKit
//
//  Created by GorXion on 2018/5/9.
//

public extension Chain where Base: UIGestureRecognizer {
    
    @discardableResult
    func addTarget(_ target: Any, action: Selector) -> Chain {
        base.addTarget(target, action: action)
        return self
    }
    
    @discardableResult
    func delegate(_ delegate: UIGestureRecognizerDelegate?) -> Chain {
        base.delegate = delegate
        return self
    }
    
    @discardableResult
    func isEnabled(_ isEnabled: Bool) -> Chain {
        base.isEnabled = isEnabled
        return self
    }
}

public extension Chain where Base: UITapGestureRecognizer {
    
    @discardableResult
    func numberOfTapsRequired(_ numberOfTapsRequired: Int) -> Chain {
        base.numberOfTapsRequired = numberOfTapsRequired
        return self
    }
    
    @discardableResult
    func numberOfTouchesRequired(_ numberOfTouchesRequired: Int) -> Chain {
        base.numberOfTouchesRequired = numberOfTouchesRequired
        return self
    }
}

public extension Chain where Base: UIPanGestureRecognizer {
    
    @discardableResult
    func minimumNumberOfTouches(_ minimumNumberOfTouches: Int) -> Chain {
        base.minimumNumberOfTouches = minimumNumberOfTouches
        return self
    }
    
    @discardableResult
    func maximumNumberOfTouches(_ maximumNumberOfTouches: Int) -> Chain {
        base.maximumNumberOfTouches = maximumNumberOfTouches
        return self
    }
}

public extension Chain where Base: UISwipeGestureRecognizer {
    
    @discardableResult
    func numberOfTouchesRequired(_ numberOfTouchesRequired: Int) -> Chain {
        base.numberOfTouchesRequired = numberOfTouchesRequired
        return self
    }
    
    @discardableResult
    func direction(_ direction: UISwipeGestureRecognizer.Direction) -> Chain {
        base.direction = direction
        return self
    }
}

public extension Chain where Base: UIPinchGestureRecognizer {
    
    @discardableResult
    func scale(_ scale: CGFloat) -> Chain {
        base.scale = scale
        return self
    }
}

public extension Chain where Base: UILongPressGestureRecognizer {
    
    @discardableResult
    func numberOfTapsRequired(_ numberOfTapsRequired: Int) -> Chain {
        base.numberOfTapsRequired = numberOfTapsRequired
        return self
    }
    
    @discardableResult
    func numberOfTouchesRequired(_ numberOfTouchesRequired: Int) -> Chain {
        base.numberOfTouchesRequired = numberOfTouchesRequired
        return self
    }
    
    @discardableResult
    func minimumPressDuration(_ minimumPressDuration: CFTimeInterval) -> Chain {
        base.minimumPressDuration = minimumPressDuration
        return self
    }
    
    @discardableResult
    func allowableMovement(_ allowableMovement: CGFloat) -> Chain {
        base.allowableMovement = allowableMovement
        return self
    }
}

public extension Chain where Base: UIRotationGestureRecognizer {
    
    @discardableResult
    func rotation(_ rotation: CGFloat) -> Chain {
        base.rotation = rotation
        return self
    }
}
