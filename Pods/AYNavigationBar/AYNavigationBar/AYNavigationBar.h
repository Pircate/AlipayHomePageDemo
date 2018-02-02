//
//  AYNavigationBar.h
//
//  Created by gaoX on 2017/9/20.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AYNavigationBarContentView.h"

@interface AYNavigationItem : NSObject

@property (nonatomic, assign) AYNavigationBarTitleViewStyle titleViewStyle; // 标题视图风格

@property (nonatomic, copy) NSString *title; // 导航栏标题

@property (nonatomic, strong) UIView *titleView; // 导航栏标题视图

@property (nonatomic, copy) NSDictionary<NSAttributedStringKey, id> *titleTextAttributes; // 导航栏标题文本属性

@property (nonatomic, strong) UIButton *leftBarButton; // 导航栏左边按钮

@property (nonatomic, copy) NSArray<UIView *> *leftBarItems; // 导航栏左边视图数组

@property (nonatomic, strong) UIButton *rightBarButton; // 导航栏右边按钮

@property (nonatomic, copy) NSArray<UIView *> *rightBarItems; // 导航栏右边视图数组

@property (nonatomic, assign) CGFloat alpha; // 内容视图透明度

@end

@interface AYNavigationBar : UIView

@property (nonatomic, strong) UIImage *backgroundImage; // 导航栏背景图片

@property (nonatomic, strong) UIImage *shadowImage; // 导航栏底部阴影图片

@property (nonatomic, assign) BOOL prefersLargeTitles; // 开启或关闭导航栏大标题

@property (nonatomic, copy) NSDictionary<NSAttributedStringKey, id> *largeTitleTextAttributes; // 导航栏大标题文本属性

@property (nonatomic, assign) CGFloat contentOffset; // 导航栏内容高度偏移量

@property (nonatomic, assign) CGFloat verticalOffset; // 导航栏垂直位置偏移量

- (void)setHidden:(BOOL)hidden animated:(BOOL)animated; // 隐藏或显示导航栏，如果animated=YES，将开启动画效果

@end

@interface UIViewController (AYNavigationBar)

@property (nonatomic, strong, readonly) AYNavigationBar *ay_navigationBar;

@property (nonatomic, strong, readonly) AYNavigationItem *ay_navigationItem;

@property (nonatomic, assign) BOOL ay_navigationBarDisabled; // 是否禁用AYNavigationBar，使用系统导航栏

- (void)registerNavigationBar; // 注册AYNavigationBar

@end

@interface UINavigationController (AYNavigationBar)

@property (nonatomic, assign) BOOL ay_navigationBarEnabled; // 是否开启AYNavigationBar

@property (nonatomic, strong) UIColor *ay_barTintColor; // 导航栏背景颜色

@property (nonatomic, strong) UIImage *ay_barBackgroundImage; // 导航栏背景图片

@property (nonatomic, strong) UIImage *ay_barShadowImage; // 导航栏底部阴影图片

@property (nonatomic, assign) BOOL ay_navigationBarHidden; // 隐藏或显示导航栏

@property (nonatomic, copy) NSDictionary<NSAttributedStringKey, id> *ay_titleTextAttributes; // 导航栏标题文本属性

@end
