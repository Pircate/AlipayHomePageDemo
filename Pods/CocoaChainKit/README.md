# CocoaChainKit

[![CI Status](https://img.shields.io/travis/G-Xi0N/CocoaChainKit.svg?style=flat)](https://travis-ci.org/G-Xi0N/CocoaChainKit)
[![Version](https://img.shields.io/cocoapods/v/CocoaChainKit.svg?style=flat)](https://cocoapods.org/pods/CocoaChainKit)
[![License](https://img.shields.io/cocoapods/l/CocoaChainKit.svg?style=flat)](https://cocoapods.org/pods/CocoaChainKit)
[![Platform](https://img.shields.io/cocoapods/p/CocoaChainKit.svg?style=flat)](https://cocoapods.org/pods/CocoaChainKit)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

CocoaChainKit is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CocoaChainKit'
```

## Usage

```swift
UIButton().chain
    .frame(x: 0, y: 0, width: 120, height: 30)
    .center(view.center)
    .backgroundColor(UIColor.red)
    .systemFont(ofSize: 14)
    .title("Hello World", for: .normal)
    .titleColor(UIColor.blue, for: .normal)
    .cornerRadius(15)
    .masksToBounds(true)
    .addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    .installed
    
    
lazy var collectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout().chain
        .itemSize(width: 80, height: 80)
        .minimumLineSpacing(20)
        .minimumInteritemSpacing(10)
        .installed
    return UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout).chain
        .backgroundColor(UIColor.white)
        .register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellID")
        .register(UICollectionReusableView.self, forSectionHeaderWithReuseIdentifier: "header")
        .installed
}()
```

## Author

gaoX, gao497868860@163.com

## License

CocoaChainKit is available under the MIT license. See the LICENSE file for more info.
