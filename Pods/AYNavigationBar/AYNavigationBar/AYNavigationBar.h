//
//  AYNavigationBar.h
//
//  Created by gaoX on 2017/9/20.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AYNavigationBarTitleViewStyle) {
    AYNavigationBarTitleViewStyleDefault,  // horizontal center
    AYNavigationBarTitleViewStyleAutomatic // autoadaptation
};

@interface AYNavigationItem : UIView

@property (nonatomic, assign) AYNavigationBarTitleViewStyle titleViewStyle;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UIView *titleView;

@property (nonatomic, copy) NSDictionary<NSAttributedStringKey, id> *titleTextAttributes;

@property (nonatomic, strong) UIButton *leftBarButton;

@property (nonatomic, copy) NSArray<UIView *> *leftBarItems;

@property (nonatomic, strong) UIButton *rightBarButton;

@property (nonatomic, copy) NSArray<UIView *> *rightBarItems;

@end

@interface AYNavigationBar : UIView

@property (nonatomic, strong) UIImage *backgroundImage;

@property (nonatomic, strong) UIImage *shadowImage;

@property (nonatomic, assign) BOOL prefersLargeTitles;

@property (nonatomic, copy) NSDictionary<NSAttributedStringKey, id> *largeTitleTextAttributes;

- (void)setHidden:(BOOL)hidden animated:(BOOL)animated;

@end

@interface UIViewController (AYNavigationBar)

@property (nonatomic, strong, readonly) AYNavigationBar *ay_navigationBar;

@property (nonatomic, strong, readonly) AYNavigationItem *ay_navigationItem;

- (void)registerNavigationBar;

@end

@interface UINavigationController (AYNavigationBar)

@property (nonatomic, assign) BOOL ay_navigationBarEnabled;

@property (nonatomic, strong) UIColor *ay_barTintColor;

@property (nonatomic, strong) UIImage *ay_barBackgroundImage;

@property (nonatomic, strong) UIImage *ay_barShadowImage;

@property (nonatomic, strong) UIButton *ay_backBarButton;

@property (nonatomic, assign) BOOL ay_navigationBarHidden;

@property (nonatomic, copy) NSDictionary<NSAttributedStringKey, id> *ay_titleTextAttributes;

@end
