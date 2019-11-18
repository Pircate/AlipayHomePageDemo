// 
//  ScrollViewObservation.swift
//  EasyRefresher
//
//  Created by Pircate(swifter.dev@gmail.com) on 2019/5/16
//  Copyright © 2019 Pircate. All rights reserved.
//

final class ScrollViewObservation {
    
    enum KeyPath {
        case contentOffset
        case contentSize
        case panGestureState
    }
    
    private var contentOffsetObservation: NSKeyValueObservation?
    
    private var contentSizeObservation: NSKeyValueObservation?
    
    private var panGestureStateObservation: NSKeyValueObservation?
    
    func observe(_ scrollView: UIScrollView, changeHandler: @escaping (UIScrollView, KeyPath) -> Void) {
        contentOffsetObservation = scrollView.observe(\.contentOffset) { this, _ in
            changeHandler(this, .contentOffset)
        }
        
        contentSizeObservation = scrollView.observe(\.contentSize) { this, _ in
            changeHandler(this, .contentSize)
        }
        
        panGestureStateObservation = scrollView.observe(\.panGestureRecognizer.state) { this, _ in
            changeHandler(this, .panGestureState)
        }
    }
    
    func invalidate() {
        contentOffsetObservation?.invalidate()
        contentSizeObservation?.invalidate()
        panGestureStateObservation?.invalidate()
    }
}
