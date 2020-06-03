// 
//  AppearanceRefreshFooter.swift
//  EasyRefresher
//
//  Created by Pircate(swifter.dev@gmail.com) on 2019/5/11
//  Copyright © 2019 Pircate. All rights reserved.
//

open class AppearanceRefreshFooter: RefreshFooter {
    
    public override var automaticallyChangeAlpha: Bool {
        get { false }
        set { fatalError("AppearanceRefreshFooter is always displayed, unsupport set this property.") }
    }
    
    internal(set) public override var state: RefreshState {
        get { super.state }
        set {
            guard newValue == .idle else {
                super.state = newValue
                return
            }
            
            super.state = .pulling
        }
    }
    
    override func prepare() {
        super.prepare()
        
        alpha = 1
        addTapGestureRecognizer()
        setTitle("tap_or_pull_up_to_load_more".localized(), for: .pulling)
    }
    
    override func add(to scrollView: UIScrollView) {
        super.add(to: scrollView)
        
        willBeginRefreshing {}
    }
    
    override func didEndRefreshing(completion: @escaping () -> Void) { completion() }
    
    override func changeState(by offset: CGFloat) {
        switch offset {
        case ..<(-height):
            state = .willRefresh
        default:
            state = .pulling
        }
    }
}

private extension AppearanceRefreshFooter {
    
    func addTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(tapGestureAction(sender:))
        )
        addGestureRecognizer(tapGesture)
    }
    
    @objc func tapGestureAction(sender: UITapGestureRecognizer) {
        beginRefreshing()
    }
}
