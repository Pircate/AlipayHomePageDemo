//
//  AYNavigationBarContentView.h
//  AYNavigationBarDemo
//
//  Created by GorXion on 2018/2/1.
//  Copyright © 2018年 adinnet. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AYNavigationBarTitleViewStyle) {
    AYNavigationBarTitleViewStyleDefault,  // 水平居中
    AYNavigationBarTitleViewStyleAutomatic // 自动适应
};

@interface AYNavigationBarContentView : UIView

@property (nonatomic, assign) AYNavigationBarTitleViewStyle titleViewStyle;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *titleView;

@property (nonatomic, copy) NSDictionary<NSAttributedStringKey, id> *titleTextAttributes;

@property (nonatomic, strong) UIButton *leftBarButton;

@property (nonatomic, copy) NSArray<UIView *> *leftBarItems;

@property (nonatomic, strong) UIButton *rightBarButton;

@property (nonatomic, copy) NSArray<UIView *> *rightBarItems;

@end
