//
//  UITableView+Chain.swift
//  CocoaChainKit
//
//  Created by GorXion on 2018/5/8.
//

public extension Chain where Base: UITableView {

    @discardableResult
    func dataSource(_ dataSource: UITableViewDataSource?) -> Chain {
        base.dataSource = dataSource
        return self
    }
    
    @discardableResult
    func delegate(_ delegate: UITableViewDelegate?) -> Chain {
        base.delegate = delegate
        return self
    }
    
    @discardableResult
    func rowHeight(_ rowHeight: CGFloat) -> Chain {
        base.rowHeight = rowHeight
        return self
    }
    
    @discardableResult
    func sectionHeaderHeight(_ sectionHeaderHeight: CGFloat) -> Chain {
        base.sectionHeaderHeight = sectionHeaderHeight
        return self
    }
    
    @discardableResult
    func sectionFooterHeight(_ sectionFooterHeight: CGFloat) -> Chain {
        base.sectionFooterHeight = sectionFooterHeight
        return self
    }
    
    @discardableResult
    func estimatedRowHeight(_ estimatedRowHeight: CGFloat) -> Chain {
        base.estimatedRowHeight = estimatedRowHeight
        return self
    }
    
    @discardableResult
    func estimatedSectionHeaderHeight(_ estimatedSectionHeaderHeight: CGFloat) -> Chain {
        base.estimatedSectionHeaderHeight = estimatedSectionHeaderHeight
        return self
    }
    
    @discardableResult
    func estimatedSectionFooterHeight(_ estimatedSectionFooterHeight: CGFloat) -> Chain {
        base.estimatedSectionFooterHeight = estimatedSectionFooterHeight
        return self
    }
    
    @discardableResult
    func separatorStyle(_ separatorStyle: UITableViewCellSeparatorStyle) -> Chain {
        base.separatorStyle = separatorStyle
        return self
    }

    @discardableResult
    func separatorColor(_ separatorColor: UIColor?) -> Chain {
        base.separatorColor = separatorColor
        return self
    }
    
    @discardableResult
    func register(_ nib: UINib?, forCellReuseIdentifier identifier: String) -> Chain {
        base.register(nib, forCellReuseIdentifier: identifier)
        return self
    }
    
    @discardableResult
    func register(_ cellClass: Swift.AnyClass?, forCellReuseIdentifier identifier: String) -> Chain {
        base.register(cellClass, forCellReuseIdentifier: identifier)
        return self
    }
}
