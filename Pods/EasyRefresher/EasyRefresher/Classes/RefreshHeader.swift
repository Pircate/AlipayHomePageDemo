// 
//  RefreshHeader.swift
//  EasyRefresher
//
//  Created by Pircate(swifter.dev@gmail.com) on 2019/4/26
//  Copyright © 2019 Pircate. All rights reserved.
//

open class RefreshHeader: RefreshComponent {
    
    override func add(to scrollView: UIScrollView) {
        super.add(to: scrollView)
        
        bottomAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
    }
    
    override func prepare() {
        super.prepare()
        
        alpha = 0
        setTitle("pull_down_to_refresh".localized(), for: .pulling)
        setTitle("release_to_refresh".localized(), for: .willRefresh)
    }
    
    override func willBeginRefreshing(completion: @escaping () -> Void) {
        guard let scrollView = scrollView else { return }
        
        alpha = 1
        
        UIView.animate(withDuration: 0.25, animations: {
            scrollView.contentInset.top = self.originalInset.top + self.height
            scrollView.changed_inset.top = self.height
        }, completion: { _ in completion() })
    }
    
    override func didEndRefreshing(completion: @escaping () -> Void) {
        guard let scrollView = scrollView else { return }
        
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 0
            scrollView.contentInset.top -= scrollView.changed_inset.top
            scrollView.changed_inset.top = 0
        }, completion: { _ in completion() })
    }
    
    override func scrollViewContentOffsetDidChange(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y + scrollView.refreshInset.top
        
        changeAlpha(by: offset)
        
        if isDisabled { return }
        
        switch offset {
        case 0...:
            state = .idle
        case -height..<0:
            state = .pulling
        default:
            state = .willRefresh
        }
    }
}
