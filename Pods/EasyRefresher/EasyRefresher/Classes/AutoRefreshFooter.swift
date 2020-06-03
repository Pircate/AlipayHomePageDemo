// 
//  AutoRefreshFooter.swift
//  EasyRefresher
//
//  Created by Pircate(swifter.dev@gmail.com) on 2019/5/8
//  Copyright © 2019 Pircate. All rights reserved.
//

/// The trigger mode of automatic refresh
public enum TriggerMode {
    case percent(CGFloat)
    case offset(CGFloat)
}

open class AutoRefreshFooter: RefreshFooter {
    
    private let triggerMode: TriggerMode
    
    public init(
        triggerMode: TriggerMode = .percent(0),
        height: CGFloat = 54,
        refreshClosure: @escaping () -> Void
    ) {
        self.triggerMode = triggerMode
        
        super.init(height: height, refreshClosure: refreshClosure)
    }
    
    public init<T>(
        stateView: T,
        triggerMode: TriggerMode = .percent(0),
        height: CGFloat = 54,
        refreshClosure: @escaping () -> Void
    ) where T : UIView, T : RefreshStateful {
        self.triggerMode = triggerMode
        
        super.init(stateView: stateView, height: height, refreshClosure: refreshClosure)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.triggerMode = .percent(0)
        
        super.init(coder: aDecoder)
    }
    
    override func scrollViewPanGestureStateDidChange(_ scrollView: UIScrollView) {}
    
    override func triggerAutoRefresh(by offset: CGFloat) -> Bool {
        switch triggerMode {
        case .percent(let value):
            return offset > 0 && offset / height > (0...1).clamp(value)
        case .offset(let value):
            return value < height ? offset > value : offset > height
        }
    }
}

private extension ClosedRange {
    
    func clamp(_ value : Bound) -> Bound {
        return lowerBound > value ? lowerBound
            : upperBound < value ? upperBound
            : value
    }
}
