//
//  UISegmentedControl+Chain.swift
//  CocoaChainKit
//
//  Created by GorXion on 2018/7/12.
//

public extension Chain where Base: UISegmentedControl {
    
    @discardableResult
    func title(_ title: String?, forSegmentAt segment: Int) -> Chain {
        base.setTitle(title, forSegmentAt: segment)
        return self
    }
    
    @discardableResult
    func image(_ image: UIImage?, forSegmentAt segment: Int) -> Chain {
        base.setImage(image, forSegmentAt: segment)
        return self
    }
    
    @discardableResult
    func width(_ width: CGFloat, forSegmentAt segment: Int) -> Chain {
        base.setWidth(width, forSegmentAt: segment)
        return self
    }
    
    @discardableResult
    func contentOffset(_ offset: CGSize, forSegmentAt segment: Int) -> Chain {
        base.setContentOffset(offset, forSegmentAt: segment)
        return self
    }
    
    @discardableResult
    func enabled(_ enabled: Bool, forSegmentAt segment: Int) -> Chain {
        base.setEnabled(enabled, forSegmentAt: segment)
        return self
    }
    
    @discardableResult
    func selectedSegmentIndex(_ selectedSegmentIndex: Int) -> Chain {
        base.selectedSegmentIndex = selectedSegmentIndex
        return self
    }
    
    @discardableResult
    func backgroundImage(_ backgroundImage: UIImage?, for state: UIControl.State..., barMetrics: UIBarMetrics) -> Chain {
        state.forEach { base.setBackgroundImage(backgroundImage, for: $0, barMetrics: barMetrics) }
        return self
    }
    
    @discardableResult
    func dividerImage(_ dividerImage: UIImage?,
                      forLeftSegmentState leftState: UIControl.State,
                      rightSegmentState rightState: UIControl.State,
                      barMetrics: UIBarMetrics) -> Chain {
        base.setDividerImage(dividerImage, forLeftSegmentState: leftState, rightSegmentState: rightState, barMetrics: barMetrics)
        return self
    }
    
    @discardableResult
    func titleTextAttributes(_ attributes: [NSAttributedString.Key : Any]?, for state: UIControl.State...) -> Chain {
        state.forEach { base.setTitleTextAttributes(attributes, for: $0) }
        return self
    }
    
    @discardableResult
    func contentPositionAdjustment(_ adjustment: UIOffset,
                                   forSegmentType leftCenterRightOrAlone: UISegmentedControl.Segment,
                                   barMetrics: UIBarMetrics) -> Chain {
        base.setContentPositionAdjustment(adjustment, forSegmentType: leftCenterRightOrAlone, barMetrics: barMetrics)
        return self
    }
}
