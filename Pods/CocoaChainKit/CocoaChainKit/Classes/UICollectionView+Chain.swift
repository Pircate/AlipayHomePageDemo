//
//  UICollectionView+Chain.swift
//  CocoaChainKit
//
//  Created by GorXion on 2018/5/8.
//

public extension Chain where Base: UICollectionView {
    
    @discardableResult
    func backgroundView(_ backgroundView: UIView?) -> Chain {
        base.backgroundView = backgroundView
        return self
    }
    
    @discardableResult
    func dataSource(_ dataSource: UICollectionViewDataSource?) -> Chain {
        base.dataSource = dataSource
        return self
    }
    
    @discardableResult
    func delegate(_ delegate: UICollectionViewDelegate?) -> Chain {
        base.delegate = delegate
        return self
    }
    
    @discardableResult
    func register(_ cellClass: Swift.AnyClass?, forCellWithReuseIdentifier identifier: String) -> Chain {
        base.register(cellClass, forCellWithReuseIdentifier: identifier)
        return self
    }
    
    @discardableResult
    func register(_ nib: UINib?, forCellWithReuseIdentifier identifier: String) -> Chain {
        base.register(nib, forCellWithReuseIdentifier: identifier)
        return self
    }
    
    @discardableResult
    func register(_ viewClass: Swift.AnyClass?,
                  forSupplementaryViewOfKind elementKind: String,
                  withReuseIdentifier identifier: String) -> Chain {
        base.register(viewClass,
                      forSupplementaryViewOfKind: elementKind,
                      withReuseIdentifier: identifier)
        return self
    }
    
    @discardableResult
    func register(_ viewClass: Swift.AnyClass?,
                  forSectionHeaderWithReuseIdentifier identifier: String) -> Chain {
        base.register(viewClass,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                      withReuseIdentifier: identifier)
        return self
    }
    
    @discardableResult
    func register(_ viewClass: Swift.AnyClass?,
                  forSectionFooterWithReuseIdentifier identifier: String) -> Chain {
        base.register(viewClass,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                      withReuseIdentifier: identifier)
        return self
    }
    
    @discardableResult
    func register(_ nib: UINib?,
                  forSupplementaryViewOfKind kind: String,
                  withReuseIdentifier identifier: String) -> Chain {
        base.register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
        return self
    }
    
    @discardableResult
    func register(_ nib: UINib?,
                  forSectionHeaderWithReuseIdentifier identifier: String) -> Chain {
        base.register(nib,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                      withReuseIdentifier: identifier)
        return self
    }
    
    @discardableResult
    func register(_ nib: UINib?,
                  forSectionFooterWithReuseIdentifier identifier: String) -> Chain {
        base.register(nib,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                      withReuseIdentifier: identifier)
        return self
    }
}
