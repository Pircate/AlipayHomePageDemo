// 
//  AutoRefreshFooter.swift
//  EasyRefresher
//
//  Created by Pircate(swifter.dev@gmail.com) on 2019/5/8
//  Copyright © 2019 Pircate. All rights reserved.
//

open class AutoRefreshFooter: RefreshFooter {

    override var isAutoRefresh: Bool { true }
}

open class AppearanceAutoRefreshFooter: AppearanceRefreshFooter {
    
    override var isAutoRefresh: Bool { true }
}
