# AYNavigationBar

## Installation

Use CocoaPods  

``` ruby
pod 'AYNavigationBar', '1.0.5'
```

## Usage

### To enable AYNavigationBar of a navigation controller

``` objc
UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
nav.ay_navigationBarEnabled = YES;
```

### Comparison of system methods
``` objc
self.navigationItem.title = @"首页";
self.ay_navigationItem.title = @"首页";

self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blueColor]};
self.navigationController.ay_titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blueColor]};
self.ay_navigationItem.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor orangeColor]};

UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1000, 30)];
titleView.layer.cornerRadius = 5;
titleView.layer.masksToBounds = YES;
titleView.backgroundColor = [UIColor yellowColor];

self.navigationItem.titleView = titleView;
self.ay_navigationItem.titleView = titleView;
self.ay_navigationItem.titleViewStyle = AYNavigationBarTitleViewStyleAutomatic;

self.navigationController.navigationBar.barTintColor = [UIColor cyanColor];
self.navigationController.ay_barTintColor = [UIColor cyanColor];
self.ay_navigationBar.backgroundColor = [UIColor cyanColor];

UIImage *image = [[UIImage imageNamed:@"shadow"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
self.navigationController.navigationBar.shadowImage = image;
self.navigationController.ay_barShadowImage = image;
self.ay_navigationBar.shadowImage = image;

[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav"] forBarMetrics:UIBarMetricsDefault];
self.ay_navigationBar.backgroundImage = [UIImage imageNamed:@"nav"];

UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
rightBtn.frame = CGRectMake(0, 0, 44, 44);
[rightBtn setTitle:@"push" forState:UIControlStateNormal];
[rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];

self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
self.ay_navigationItem.rightBarButton = rightBtn;


UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
rightButton.frame = CGRectMake(0, 0, 44, 44);

UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
self.navigationItem.rightBarButtonItems = @[rightItem, rightBarItem];
self.ay_navigationItem.rightBarItems = @[rightBtn, rightButton];


UIButton *backBarButton = [UIButton buttonWithType:UIButtonTypeSystem];
backBarButton.frame = CGRectMake(0, 0, 38, 44);
[backBarButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];

self.navigationController.ay_backBarButton = backBarButton;
```
