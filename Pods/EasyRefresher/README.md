# EasyRefresher

[![CI Status](https://img.shields.io/travis/Pircate/EasyRefresher.svg?style=flat)](https://travis-ci.org/Pircate/EasyRefresher)
[![Version](https://img.shields.io/cocoapods/v/EasyRefresher.svg?style=flat)](https://cocoapods.org/pods/EasyRefresher)
[![License](https://img.shields.io/cocoapods/l/EasyRefresher.svg?style=flat)](https://cocoapods.org/pods/EasyRefresher)
[![Platform](https://img.shields.io/cocoapods/p/EasyRefresher.svg?style=flat)](https://cocoapods.org/pods/EasyRefresher)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* iOS 9.0
* Swift 4.2

## Installation

EasyRefresher is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'EasyRefresher'
```

## Demo

![](https://github.com/Pircate/EasyRefresher/blob/master/image.gif)

## Usage

* Add Refresher

```swift
tableView.refresh.header.addRefreshClosure {
    self.reqeust {
        self.tableView.refresh.header.endRefreshing()
    }
}

tableView.refresh.footer = AutoRefreshFooter(triggerMode: .percent(0.5)) {
    self.reqeust {
        self.tableView.refresh.footer.endRefreshing()
    }
}

```

* Manual Trigger

```swift
tableView.refresh.header.beginRefreshing()
```

* State Title

```swift
tableView.refresh.header.setTitle("loading...", for: .refreshing)

tableView.refresh.footer.setAttributedTitle(
    NSAttributedString(string: "已到最后一页", attributes: [.foregroundColor: UIColor.red]), for: .disabled
)
```

* UIActivityIndicatorView Style

```swift
tableView.refresh.header.activityIndicatorStyle = .white
```

* Disabled

```swift
// End refreshing and set state to disabled
self.tableView.refresh.footer.isEnabled = false
```

* Custom State View

```swift
extension CustomStateView: RefreshStateful {
    
    public func refresher(_ refresher: Refresher, didChangeState state: RefreshState) {
    
    }
    
    public func refresher(_ refresher: Refresher, didChangeOffset offset: CGFloat) {
    
    }
}

tableView.refresh.footer = AppearanceRefreshFooter(stateView: CustomStateView()) {
    self.reqeust {
        self.tableView.refresh.footer.endRefreshing()
    }
}
```

## Author

Pircate, swifter.dev@gmail.com

## License

EasyRefresher is available under the MIT license. See the LICENSE file for more info.
