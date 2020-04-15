// 
//  RefreshComponent.swift
//  EasyRefresher
//
//  Created by Pircate(swifter.dev@gmail.com) on 2019/5/8
//  Copyright © 2019 Pircate. All rights reserved.
//

open class RefreshComponent: UIView {
    
    public var activityIndicatorStyle: UIActivityIndicatorView.Style {
        get { activityIndicator.style }
        set { activityIndicator.style = newValue }
    }
    
    public var automaticallyChangeAlpha: Bool = true
    
    public var stateTitles: [RefreshState : String] = [:]
    
    public var stateAttributedTitles: [RefreshState : NSAttributedString] = [:]
    
    internal(set) public var state: RefreshState = .idle {
        didSet {
            guard state != oldValue else { return }
            
            stateChanged(state)
            
            switch state {
            case .refreshing:
                activityIndicator.startAnimating()
            default:
                activityIndicator.stopAnimating()
            }
            
            rotateArrow(for: state)
            
            changeStateTitle(for: state)
        }
    }
    
    public var refreshClosure: () -> Void
    
    weak var scrollView: UIScrollView? {
        didSet { scrollView?.alwaysBounceVertical = true }
    }
    
    lazy var originalInset: UIEdgeInsets = {
        guard let scrollView = scrollView else { return .zero }
        
        return scrollView.contentInset
    }()
    
    var arrowDirection: ArrowDirection { .down }
    
    let height: CGFloat = 54
    
    private var stateChanged: (RefreshState) -> Void = { _ in }
    
    private var isEnding: Bool = false
    
    private lazy var observation: ScrollViewObservation = { ScrollViewObservation() }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [activityIndicator, arrowImageView, stateLabel])
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let arrowImageView = UIImageView(image: "refresh_arrow_down".bundleImage())
        arrowImageView.isHidden = true
        return arrowImageView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        if #available(iOS 13.0, *) {
            return UIActivityIndicatorView(style: .medium)
        } else {
            return UIActivityIndicatorView(style: .gray)
        }
    }()
    
    private lazy var stateLabel: UILabel = {
        let stateLabel = UILabel()
        stateLabel.font = UIFont.systemFont(ofSize: 14)
        stateLabel.textAlignment = .center
        return stateLabel
    }()
    
    public init(refreshClosure: @escaping () -> Void) {
        self.refreshClosure = refreshClosure
        
        super.init(frame: CGRect.zero)
        
        build()
        prepare()
    }
    
    public init<T>(
        stateView: T,
        refreshClosure: @escaping () -> Void
    ) where T: UIView, T: RefreshStateful {
        self.refreshClosure = refreshClosure
        
        super.init(frame: .zero)
        
        prepare()
        
        addSubview(stateView)
        
        stateView.translatesAutoresizingMaskIntoConstraints = false
        stateView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        stateView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stateView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stateView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        stateChanged = { stateView.refresher(self, didChangeState: $0) }
    }
    
    public override init(frame: CGRect) {
        self.refreshClosure = {}
        
        super.init(frame: frame)
        
        build()
        prepare()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.refreshClosure = {}
        
        super.init(coder: aDecoder)
        
        build()
        prepare()
    }
    
    func add(to scrollView: UIScrollView) {
        guard !scrollView.subviews.contains(self) else { return }
        
        scrollView.addSubview(self)
        
        translatesAutoresizingMaskIntoConstraints = false
        leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func observe(_ scrollView: UIScrollView) {
        observation.invalidate()
        
        observation.observe(scrollView) { [weak self] this, keyPath in
            guard let `self` = self else { return }
            
            switch keyPath {
            case .contentOffset:
                this.bringSubviewToFront(self)
                
                guard !self.isRefreshing else { return }
                
                self.scrollViewContentOffsetDidChange(this)
            case .contentSize:
                self.scrollViewContentSizeDidChange(this)
            case .panGestureState:
                self.scrollViewPanGestureStateDidChange(this)
            }
        }
    }
    
    func prepare() {
        setTitle("loading".localized(), for: .refreshing)
        setTitle("no_more_data".localized(), for: .disabled)
    }
    
    func willBeginRefreshing(completion: @escaping () -> Void) {}
    
    func didEndRefreshing(completion: @escaping () -> Void) {}
    
    func scrollViewContentOffsetDidChange(_ scrollView: UIScrollView) {}
    
    func scrollViewContentSizeDidChange(_ scrollView: UIScrollView) {}
    
    func scrollViewPanGestureStateDidChange(_ scrollView: UIScrollView) {
        guard scrollView.panGestureRecognizer.state == .ended, state == .willRefresh else { return }
        
        beginRefreshing()
    }
}

extension RefreshComponent {
    
    var isDescendantOfScrollView: Bool {
        guard let scrollView = scrollView else { return false }
        
        return isDescendant(of: scrollView)
    }
    
    func changeAlpha(by offset: CGFloat) {
        guard automaticallyChangeAlpha else {
            alpha = 1
            return
        }
        
        switch offset {
        case 0...:
            alpha = 0
        case -height..<0:
            alpha = -offset / height
        default:
            alpha = 1
        }
    }
    
    private func build() {
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func prepareForRefreshing() {
        guard let scrollView = scrollView else { return }
        
        var contentInset = scrollView.contentInset
        contentInset.top -= scrollView.changed_inset.top
        contentInset.bottom -= scrollView.changed_inset.bottom
        
        originalInset = contentInset
    }
    
    private func endRefreshing(to state: RefreshState) {
        assert(isDescendantOfScrollView, "Please add refresher to UIScrollView before end refreshing")
        
        guard isRefreshing, !isEnding else { return }
        
        isEnding = true
        
        didEndRefreshing {
            self.state = state
            self.isEnding = false
        }
    }
    
    private func rotateArrow(for state: RefreshState) {
        arrowImageView.isHidden = state == .idle || isRefreshing || !isEnabled
        
        let transform: CGAffineTransform
        switch arrowDirection {
        case .up:
            transform = state == .willRefresh ? .identity : CGAffineTransform(rotationAngle: .pi)
        case .down:
            transform = state == .willRefresh ? CGAffineTransform(rotationAngle: .pi) : .identity
        }
        
        UIView.animate(withDuration: 0.25) { self.arrowImageView.transform = transform }
    }
    
    private func changeStateTitle(for state: RefreshState) {
        if let attributedTitle = attributedTitle(for: state) {
            stateLabel.isHidden = false
            stateLabel.attributedText = attributedTitle
        } else if let title = title(for: state) {
            stateLabel.isHidden = false
            stateLabel.attributedText = nil
            stateLabel.text = title
        } else {
            stateLabel.isHidden = true
        }
    }
}

extension RefreshComponent: Refresher {
    
    public var isEnabled: Bool {
        get { state != .disabled }
        set {
            if newValue {
                guard state == .disabled else { return }
                
                state = .idle
            } else {
                endRefreshing(to: .disabled)
            }
        }
    }
    
    public func addRefreshClosure(_ refreshClosure: @escaping () -> Void) {
        self.refreshClosure = refreshClosure
        
        guard let scrollView = scrollView else { return }
        
        add(to: scrollView)
        observe(scrollView)
    }
    
    public func beginRefreshing() {
        assert(isDescendantOfScrollView, "Please add refresher to UIScrollView before begin refreshing")
        
        guard !isRefreshing, isEnabled else { return }
        
        prepareForRefreshing()
        state = .refreshing
        willBeginRefreshing { self.refreshClosure() }
    }
    
    public func endRefreshing() {
        endRefreshing(to: .idle)
    }
}

extension RefreshComponent {
    
    enum ArrowDirection {
        case up
        case down
    }
}
