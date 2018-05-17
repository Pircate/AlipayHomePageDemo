//
//  UIPickerView+Chain.swift
//  CocoaChainKit
//
//  Created by GorXion on 2018/5/11.
//

public extension Chain where Base: UIPickerView {
    
    @discardableResult
    func dataSource(_ dataSource: UIPickerViewDataSource?) -> Chain {
        base.dataSource = dataSource
        return self
    }
    
    @discardableResult
    func delegate(_ delegate: UIPickerViewDelegate?) -> Chain {
        base.delegate = delegate
        return self
    }
    
    @discardableResult
    func showsSelectionIndicator(_ showsSelectionIndicator: Bool) -> Chain {
        base.showsSelectionIndicator = showsSelectionIndicator
        return self
    }
}
