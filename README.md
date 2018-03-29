# swift-AlipayHomePageDemo
仿支付宝首页滚动效果

![image](https://github.com/GorXion/AlipayHomePageDemo/blob/master/alipay_home.gif)

##主要思路:

``` objc
  // 禁止中间的collectionView滚动
  collectionView.isScrollEnabled = false
        
  // 移除父scrollView的所有手势
  if let gestures = scrollView.gestureRecognizers {
    for gesture in gestures {
      scrollView.removeGestureRecognizer(gesture)
    }
  }
        
  // 将tableView的手势添加到父scrollView上
  if let gestures = tableView.gestureRecognizers {
    for gesture in gestures {
      scrollView.addGestureRecognizer(gesture)
    }
  }
```
