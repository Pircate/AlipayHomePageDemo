//
//  UIViewController+NavigationBar.swift
//  UIViewController+NavigationBar
//
//  Created by GorXion on 2018/3/26.
//  Copyright © 2018年 gaoX. All rights reserved.
//

import UIKit
import ObjectiveC

private var kUIViewControllerNavigationKey     = "UI_VIEW_CONTROLLER_NAVIGATION_KEY"
private var kUIViewControllerNavigationBarKey  = "UI_VIEW_CONTROLLER_NAVIGATION_BAR_KEY"
private var kUIViewControllerNavigationItemKey = "UI_VIEW_CONTROLLER_NAVIGATION_ITEM_KEY"

extension UIViewController {
    
    public static let setupNavigationBar: Void = {
        if let viewDidLoad = class_getInstanceMethod(UIViewController.self, #selector(viewDidLoad)),
            let fk_viewDidLoad = class_getInstanceMethod(UIViewController.self, #selector(fk_viewDidLoad)),
            let viewWillAppear = class_getInstanceMethod(UIViewController.self, #selector(viewWillAppear(_:))),
            let fk_viewWillAppear = class_getInstanceMethod(UIViewController.self, #selector(fk_viewWillAppear(_:))) {
            method_exchangeImplementations(viewDidLoad, fk_viewDidLoad)
            method_exchangeImplementations(viewWillAppear, fk_viewWillAppear)
        }
    }()
    
    public struct Navigation {
        
        public class Configuration {
            public var enabled = false
            public var barTintColor: UIColor?
            public var backgroundImage: UIImage?
            public var metrics: UIBarMetrics = .default
            public var position: UIBarPosition = .any
            public var shadowImage: UIImage?
            public var titleTextAttributes: [NSAttributedStringKey : Any]?
        }
        
        public let bar: FKNavigationBar
        public let item: UINavigationItem
        public let configuration = Configuration()
    }
    
    public var navigation: Navigation {
        if let navigation = objc_getAssociatedObject(self, &kUIViewControllerNavigationKey) as? Navigation {
            return navigation
        }
        let navigation = Navigation(bar: _navigationBar, item: _navigationItem)
        objc_setAssociatedObject(self, &kUIViewControllerNavigationKey, navigation, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return navigation
    }
    
    private var _navigationBar: FKNavigationBar {
        if let bar = objc_getAssociatedObject(self, &kUIViewControllerNavigationBarKey) as? FKNavigationBar {
            return bar
        }
        let bar = FKNavigationBar(navigationItem: _navigationItem)
        objc_setAssociatedObject(self, &kUIViewControllerNavigationBarKey, bar, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return bar
    }
    
    private var _navigationItem: UINavigationItem {
        if let item = objc_getAssociatedObject(self, &kUIViewControllerNavigationItemKey) as? UINavigationItem {
            return item
        }
        let item = UINavigationItem()
        objc_setAssociatedObject(self, &kUIViewControllerNavigationItemKey, item, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return item
    }
    
    private func bindNavigationBar() {
        guard let configuration = navigationController?.navigation.configuration, configuration.enabled else { return }
        navigationController?.navigationBar.isHidden = true
        configureNavigationBarStyle(configuration)
        view.addSubview(_navigationBar)
    }
    
    private func bringNavigationBarToFront() {
        guard let navigationController = navigationController,
            navigationController.navigation.configuration.enabled else { return }
        view.bringSubview(toFront: _navigationBar)
    }
    
    private func configureNavigationBarStyle(_ configuration: Navigation.Configuration) {
        _navigationBar.barTintColor = configuration.barTintColor
        _navigationBar.shadowImage = configuration.shadowImage
        _navigationBar.titleTextAttributes = configuration.titleTextAttributes
        _navigationBar.setBackgroundImage(configuration.backgroundImage, for: configuration.position, barMetrics: configuration.metrics)
    }
    
    @objc private func fk_viewDidLoad() {
        fk_viewDidLoad()
        bindNavigationBar()
    }
    
    @objc private func fk_viewWillAppear(_ animated: Bool) {
        fk_viewWillAppear(animated)
        bringNavigationBarToFront()
    }
}

extension UINavigationController {
    
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        guard let bar = topViewController?.navigation.bar else { return }
        bar.isUnrestoredWhenViewWillLayoutSubviews
            ? (bar.frame.size = navigationBar.frame.size)
            : (bar.frame = navigationBar.frame)
    }
}
