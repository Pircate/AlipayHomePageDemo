//
//  UICollectionViewFlowLayout+Chain.swift
//  CocoaChainKit
//
//  Created by GorXion on 2018/5/8.
//

extension UICollectionViewFlowLayout: ChainCompatible {}

public extension Chain where Base: UICollectionViewFlowLayout {
    
    @discardableResult
    func minimumLineSpacing(_ minimumLineSpacing: CGFloat) -> Chain {
        base.minimumLineSpacing = minimumLineSpacing
        return self
    }
    
    @discardableResult
    func minimumInteritemSpacing(_ minimumInteritemSpacing: CGFloat) -> Chain {
        base.minimumInteritemSpacing = minimumInteritemSpacing
        return self
    }
    
    @discardableResult
    func itemSize(_ itemSize: CGSize) -> Chain {
        base.itemSize = itemSize
        return self
    }
    
    @discardableResult
    func itemSize(width: CGFloat, height: CGFloat) -> Chain {
        base.itemSize = CGSize(width: width, height: height)
        return self
    }
    
    @discardableResult
    func estimatedItemSize(_ estimatedItemSize: CGSize) -> Chain {
        base.estimatedItemSize = estimatedItemSize
        return self
    }
    
    @discardableResult
    func estimatedItemSize(width: CGFloat, height: CGFloat) -> Chain {
        base.estimatedItemSize = CGSize(width: width, height: height)
        return self
    }
    
    @discardableResult
    func scrollDirection(_ scrollDirection: UICollectionViewScrollDirection) -> Chain {
        base.scrollDirection = scrollDirection
        return self
    }
    
    @discardableResult
    func headerReferenceSize(_ headerReferenceSize: CGSize) -> Chain {
        base.headerReferenceSize = headerReferenceSize
        return self
    }
    
    @discardableResult
    func headerReferenceSize(width: CGFloat, height: CGFloat) -> Chain {
        base.headerReferenceSize = CGSize(width: width, height: height)
        return self
    }
    
    @discardableResult
    func footerReferenceSize(_ footerReferenceSize: CGSize) -> Chain {
        base.footerReferenceSize = footerReferenceSize
        return self
    }
    
    @discardableResult
    func footerReferenceSize(width: CGFloat, height: CGFloat) -> Chain {
        base.footerReferenceSize = CGSize(width: width, height: height)
        return self
    }
    
    @discardableResult
    func sectionInset(_ sectionInset: UIEdgeInsets) -> Chain {
        base.sectionInset = sectionInset
        return self
    }
    
    @discardableResult
    func sectionInset(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> Chain {
        base.sectionInset = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
}
