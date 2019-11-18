//
//  UIStepper+Chain.swift
//  CocoaChainKit
//
//  Created by GorXion on 2018/5/15.
//

public extension Chain where Base: UIStepper {
    
    @discardableResult
    func isContinuous(_ isContinuous: Bool) -> Chain {
        base.isContinuous = isContinuous
        return self
    }
    
    @discardableResult
    func autorepeat(_ autorepeat: Bool) -> Chain {
        base.autorepeat = autorepeat
        return self
    }
    
    @discardableResult
    func wraps(_ wraps: Bool) -> Chain {
        base.wraps = wraps
        return self
    }
    
    @discardableResult
    func value(_ value: Double) -> Chain {
        base.value = value
        return self
    }
    
    @discardableResult
    func minimumValue(_ minimumValue: Double) -> Chain {
        base.minimumValue = minimumValue
        return self
    }
    
    @discardableResult
    func maximumValue(_ maximumValue: Double) -> Chain {
        base.maximumValue = maximumValue
        return self
    }
    
    @discardableResult
    func stepValue(_ stepValue: Double) -> Chain {
        base.stepValue = stepValue
        return self
    }
    
    @discardableResult
    func backgroundImage(_ image: UIImage?, for state: UIControl.State...) -> Chain {
        state.forEach { base.setBackgroundImage(image, for: $0) }
        return self
    }
    
    @discardableResult
    func dividerImage(_ image: UIImage?,
                      forLeftSegmentState leftState: UIControl.State,
                      rightSegmentState rightState: UIControl.State) -> Chain {
        base.setDividerImage(image, forLeftSegmentState: leftState, rightSegmentState: rightState)
        return self
    }
    
    @discardableResult
    func incrementImage(_ image: UIImage?, for state: UIControl.State) -> Chain {
        base.setIncrementImage(image, for: state)
        return self
    }
    
    @discardableResult
    func decrementImage(_ image: UIImage?, for state: UIControl.State) -> Chain {
        base.setDecrementImage(image, for: state)
        return self
    }
}
