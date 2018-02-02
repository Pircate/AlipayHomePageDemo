//
//  AYNavigationBar.m
//
//  Created by gaoX on 2017/9/20.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import "AYNavigationBar.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

#import <objc/runtime.h>

const CGFloat AYNavigationBarDefaultHeight = 44.f;
const CGFloat AYNavigationBarLargeTitleMinHeight = 49.f;
const CGFloat AYNavigationBarPortraitHeight = 44.f;
const CGFloat AYNavigationBarLandscapeHeight = 32.f;
const CGFloat AYNavigationBarShadowViewHeight = 1.f / 3;
const CGFloat AYNavigationBarIPhoneXFixedSpaceWidth = 56.f;

#define kAYNavigationBarIsIPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define kAYNavigationBarStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height
#define kAYNavigationBarScreenWidth [UIScreen mainScreen].bounds.size.width

#define kAYNavigationBarDefaultFrame CGRectMake(0, kAYNavigationBarStatusBarHeight, kAYNavigationBarScreenWidth, AYNavigationBarDefaultHeight)

#pragma mark - AYNavigationItem
@interface AYNavigationItem ()

@property (nonatomic, strong) AYNavigationBarContentView *contentView;

@end

@implementation AYNavigationItem

#pragma mark - getter & setter
- (AYNavigationBarContentView *)contentView
{
    if (!_contentView) {
        _contentView = [[AYNavigationBarContentView alloc] init];
    }
    return _contentView;
}

- (void)setTitleViewStyle:(AYNavigationBarTitleViewStyle)titleViewStyle
{
    _titleViewStyle = titleViewStyle;
    self.contentView.titleViewStyle = titleViewStyle;
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    self.contentView.title = title;
}

- (void)setTitleView:(UIView *)titleView
{
    _titleView = titleView;
    self.contentView.titleView = titleView;
}

- (void)setTitleTextAttributes:(NSDictionary<NSAttributedStringKey,id> *)titleTextAttributes
{
    _titleTextAttributes = [titleTextAttributes copy];
    self.contentView.titleTextAttributes = titleTextAttributes;
}

- (void)setLeftBarButton:(UIButton *)leftBarButton
{
    _leftBarButton = leftBarButton;
    self.contentView.leftBarButton = leftBarButton;
}

- (void)setLeftBarItems:(NSArray<UIView *> *)leftBarItems
{
    _leftBarItems = [leftBarItems copy];
    self.contentView.leftBarItems = leftBarItems;
}

- (void)setRightBarButton:(UIButton *)rightBarButton
{
    _rightBarButton = rightBarButton;
    self.contentView.rightBarButton = rightBarButton;
}

- (void)setRightBarItems:(NSArray<UIView *> *)rightBarItems
{
    _rightBarItems = [rightBarItems copy];
    self.contentView.rightBarItems = rightBarItems;
}

- (void)setAlpha:(CGFloat)alpha
{
    _alpha = alpha;
    self.contentView.alpha = alpha;
}

@end

#pragma mark - AYNavigationBar
@interface AYNavigationBar ()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) AYNavigationItem *navigationItem;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *shadowImageView;
@property (nonatomic, strong) UIVisualEffectView *visualEffectView;
@property (nonatomic, strong) UIView *largeTitleView;
@property (nonatomic, strong) UILabel *largeTitleLabel;

@property (nonatomic, assign) BOOL willHidden;
@property (nonatomic, copy) NSString *identifier;

@end

@implementation AYNavigationBar

- (instancetype)initWithIdentifier:(NSString *)identifier
{
    self = [super initWithFrame:kAYNavigationBarDefaultFrame];
    if (self) {

        _identifier = identifier;
        
        [self ay_addObserver];
        [self ay_addSubviews];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (_identifier) {
        [self removeObserver:self forKeyPath:@"navigationItem.title"];
    }
}

#pragma mark - over write
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 0.f;
    frame.size.width = kAYNavigationBarScreenWidth;
    [super setFrame:frame];
}

- (void)setAlpha:(CGFloat)alpha
{
    _backgroundView.alpha = alpha;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    _visualEffectView.backgroundColor = backgroundColor;
    _visualEffectView.effect = backgroundColor ? nil : [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
}

- (void)setHidden:(BOOL)hidden
{
    [self setHidden:hidden animated:NO];
}

#pragma mark - public
- (void)setHidden:(BOOL)hidden animated:(BOOL)animated
{
    self.willHidden = hidden;
    if (hidden) {
        if (animated) {
            [UIView animateWithDuration:UINavigationControllerHideShowBarDuration animations:^{
                [self ay_layoutIfNeeded];
            } completion:^(BOOL finished) {
                if (finished) {
                    if (self.frame.origin.y < 0) {
                        [super setHidden:hidden];
                    }
                }
            }];
        }
        else {
            [self ay_layoutIfNeeded];
            [super setHidden:hidden];
        }
    }
    else {
        [super setHidden:hidden];
        if (animated) {
            [UIView animateWithDuration:UINavigationControllerHideShowBarDuration animations:^{
                [self ay_layoutIfNeeded];
            }];
        }
        else {
            [self ay_layoutIfNeeded];
        }
    }
}

#pragma mark - private
- (void)ay_addObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarFrameDidChange:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
    [self addObserver:self forKeyPath:@"navigationItem.title" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)ay_addSubviews
{
    [self ay_addBackgroundView];
    [self ay_addBackgroundImageView];
    [self ay_addShadowImageView];
    [self ay_addVisualEffectView];
    [self ay_addLargeTitleView];
}

- (void)ay_layoutIfNeeded
{
    [self ay_layoutSubviews];
}

- (void)ay_layoutSubviews
{
    BOOL isLandscape = [self ay_isLandscape];
    CGFloat largeTitleViewHeight = (self.prefersLargeTitles && !isLandscape) ? [self ay_largeTitleViewHeight] : 0.f;
    
    CGFloat statusBarHeight = isLandscape ? 0.f : (kAYNavigationBarIsIPhoneX ? 44.f : 20.f);
    CGFloat contentHeight = isLandscape ? AYNavigationBarLandscapeHeight : AYNavigationBarPortraitHeight;
    if (!isLandscape) contentHeight += self.contentOffset;
    
    CGRect barFrame = CGRectMake(0, statusBarHeight + self.verticalOffset, kAYNavigationBarScreenWidth, contentHeight + largeTitleViewHeight);
    if (self.willHidden) barFrame.origin.y = -barFrame.size.height;
    self.frame = barFrame;
    
    self.backgroundView.frame = [self barBackgroundFrame];
    self.backgroundImageView.frame = self.backgroundView.bounds;
    self.shadowImageView.frame = [self barShadowViewFrame];
    self.visualEffectView.frame = self.backgroundView.bounds;
    
    CGRect contentFrame = CGRectMake(0, 0, kAYNavigationBarScreenWidth, contentHeight);
    if ([self ay_needsFixedSpace]) {
        contentFrame.origin.x = AYNavigationBarIPhoneXFixedSpaceWidth;
        contentFrame.size.width = kAYNavigationBarScreenWidth - AYNavigationBarIPhoneXFixedSpaceWidth * 2;
    }
    self.navigationItem.contentView.frame = contentFrame;
    
    self.largeTitleView.frame = CGRectMake(0, CGRectGetMaxY(contentFrame), CGRectGetWidth(self.frame), largeTitleViewHeight);
    [self ay_showLargeTitle:(!isLandscape && self.prefersLargeTitles)];
}

- (CGRect)barBackgroundFrame
{
    return CGRectMake(0, -self.frame.origin.y, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) + self.frame.origin.y);
}

- (CGRect)barShadowViewFrame
{
    return CGRectMake(0, CGRectGetHeight(_backgroundView.frame), CGRectGetWidth(_backgroundView.frame), AYNavigationBarShadowViewHeight);
}

- (void)ay_addBackgroundView
{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:[self barBackgroundFrame]];
        [self addSubview:_backgroundView];
    }
}

- (void)ay_addBackgroundImageView
{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:_backgroundView.bounds];
        [_backgroundView addSubview:_backgroundImageView];
    }
}

- (void)ay_addShadowImageView
{
    if (!_shadowImageView) {
        _shadowImageView = [[UIImageView alloc] initWithFrame:[self barShadowViewFrame]];
        [_backgroundView addSubview:_shadowImageView];
    }
}

- (void)ay_addVisualEffectView
{
    if (!_visualEffectView) {
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        _visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        _visualEffectView.frame = _backgroundView.bounds;
        [_backgroundView addSubview:_visualEffectView];
    }
}

- (void)ay_addLargeTitleView
{
    if (!_largeTitleView) {
        _largeTitleView = [[UIView alloc] init];
        _largeTitleView.hidden = YES;
        [self addSubview:_largeTitleView];
        
        [self ay_addLargeTitleLable];
    }
}

- (void)ay_addLargeTitleLable
{
    if (!_largeTitleLabel) {
        _largeTitleLabel = [[UILabel alloc] init];
        _largeTitleLabel.alpha = 0.f;
        _largeTitleLabel.textColor = [UIColor darkTextColor];
        _largeTitleLabel.font = [UIFont boldSystemFontOfSize:32.f];
        [_largeTitleView addSubview:_largeTitleLabel];
    }
}

- (BOOL)ay_isLandscape
{
    UIInterfaceOrientation orientation = UIApplication.sharedApplication.statusBarOrientation;
    return UIInterfaceOrientationIsLandscape(orientation);
}

- (BOOL)ay_needsFixedSpace
{
    return [self ay_isLandscape] && kAYNavigationBarIsIPhoneX;
}

- (CGFloat)ay_largeTitleViewHeight
{
    UIFont *font = (UIFont *)self.largeTitleTextAttributes[NSFontAttributeName];
    CGFloat largeTitleViewHeight = font.pointSize * 1.2 > AYNavigationBarLargeTitleMinHeight ? font.pointSize * 1.2 : AYNavigationBarLargeTitleMinHeight;
    return largeTitleViewHeight;
}

- (void)ay_showLargeTitle:(BOOL)show
{
    if (show) {
        _largeTitleView.hidden = NO;
        _largeTitleLabel.attributedText = [[NSAttributedString alloc] initWithString:self.navigationItem.title ?: @"" attributes:self.largeTitleTextAttributes];
        
        _largeTitleLabel.frame = CGRectMake(16.f, 0.f, kAYNavigationBarScreenWidth - 32.f, CGRectGetHeight(_largeTitleView.frame));
        _navigationItem.contentView.titleLabel.alpha = 0.f;
        _largeTitleLabel.alpha = 1.f;
    }
    else {
        _largeTitleView.hidden = YES;
        _navigationItem.contentView.titleLabel.alpha = 1.f;
        _largeTitleLabel.alpha = 0.f;
    }
}

#pragma mark - notification
- (void)statusBarFrameDidChange:(NSNotification *)sender
{
    [self ay_layoutIfNeeded];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"navigationItem.title"]) {
        _largeTitleLabel.attributedText = [[NSAttributedString alloc] initWithString:self.navigationItem.title ?: @"" attributes:self.largeTitleTextAttributes];
    }
}

#pragma mark - getter & setter
- (void)setNavigationItem:(AYNavigationItem *)navigationItem
{
    _navigationItem = navigationItem;
    
    [_navigationItem.contentView removeFromSuperview];
    [self addSubview:_navigationItem.contentView];
}

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    _backgroundImage = backgroundImage;
    _backgroundImageView.image = backgroundImage;
    
    _visualEffectView.hidden = backgroundImage != nil;
}

- (void)setShadowImage:(UIImage *)shadowImage
{
    _shadowImage = shadowImage;
    _shadowImageView.image = shadowImage;
}

- (void)setPrefersLargeTitles:(BOOL)prefersLargeTitles
{
    _prefersLargeTitles = prefersLargeTitles;
    
    if ([self ay_isLandscape]) return;
    [self ay_layoutIfNeeded];
}

- (void)setLargeTitleTextAttributes:(NSDictionary<NSAttributedStringKey,id> *)largeTitleTextAttributes
{
    _largeTitleTextAttributes = [largeTitleTextAttributes copy];
    
    if (!self.prefersLargeTitles) {
        return;
    }
    if (self.navigationItem.title) {
        _largeTitleLabel.attributedText = [[NSAttributedString alloc] initWithString:self.navigationItem.title attributes:largeTitleTextAttributes];
        
        [self ay_layoutIfNeeded];
    }
}

- (void)setContentOffset:(CGFloat)contentOffset
{
    _contentOffset = contentOffset > -14.f ? contentOffset : -14.f;
    
    if ([self ay_isLandscape]) return;
    [self ay_layoutIfNeeded];
}

- (void)setVerticalOffset:(CGFloat)verticalOffset
{
    _verticalOffset = verticalOffset < 0.f ? verticalOffset : 0.f;
    
    [self ay_layoutIfNeeded];
}

@end

#pragma mark - UIViewController (AYNavigationBar)
@implementation UIViewController (AYNavigationBar)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *sels = @[@"viewDidLoad", @"viewWillAppear:"];
        [sels enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            Method originalMethod = class_getInstanceMethod(self, NSSelectorFromString(obj));
            NSString *swizzledSel = [@"ay__" stringByAppendingString:obj];
            Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(swizzledSel));
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }];
    });
}

- (void)ay__viewDidLoad
{
    [self ay__viewDidLoad];
    
    if (self.navigationController) {
        
        if (!self.navigationController.ay_navigationBarEnabled) {
            return;
        }
        
        [self registerNavigationBar];

        self.fd_prefersNavigationBarHidden = !self.ay_navigationBarDisabled;
        
        if (self.navigationController.viewControllers.count > 1) {
            [self ay_setupBackBarButton];
        }
    }
}

- (void)ay__viewWillAppear:(BOOL)animated
{
    [self ay__viewWillAppear:animated];
    
    if (self.navigationController) {
        
        if (!self.navigationController.ay_navigationBarEnabled) {
            return;
        }
        
        if (self.view.subviews.lastObject != self.ay_navigationBar) {
            [self.view bringSubviewToFront:self.ay_navigationBar];
        }
    }
}

#pragma mark - public
- (void)registerNavigationBar
{
    if (self.navigationController.ay_titleTextAttributes) {
        self.ay_navigationItem.titleTextAttributes = self.navigationController.ay_titleTextAttributes;
    }
    if (self.navigationController.ay_barBackgroundImage) {
        self.ay_navigationBar.backgroundImage = self.navigationController.ay_barBackgroundImage;
    }
    if (self.navigationController.ay_barTintColor) {
        self.ay_navigationBar.backgroundColor = self.navigationController.ay_barTintColor;
    }
    if (self.navigationController.ay_barShadowImage) {
        self.ay_navigationBar.shadowImage = self.navigationController.ay_barShadowImage;
    }
    self.ay_navigationBar.hidden = self.navigationController.ay_navigationBarHidden;
    self.fd_prefersNavigationBarHidden = !self.navigationController.ay_navigationBarHidden;
    [self.view addSubview:self.ay_navigationBar];
}

#pragma mark - private
- (void)ay_setupBackBarButton
{
    UIButton *backBarButton = [UIButton buttonWithType:UIButtonTypeSystem];
    backBarButton.clipsToBounds = YES;
    [backBarButton sizeToFit];
    [backBarButton setTitle:@"‹" forState:UIControlStateNormal];
    backBarButton.titleLabel.font = [UIFont fontWithName:@"Menlo-Regular" size:49.f];
    [backBarButton addTarget:self action:@selector(backBarButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.ay_navigationItem.leftBarButton = backBarButton;
}

#pragma mark - action
- (void)backBarButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - getter & setter
- (AYNavigationBar *)ay_navigationBar
{
    AYNavigationBar *navigationBar = objc_getAssociatedObject(self, _cmd);
    if (!navigationBar) {
        navigationBar = [[AYNavigationBar alloc] initWithIdentifier:NSStringFromClass(self.class)];
        objc_setAssociatedObject(self, @selector(ay_navigationBar), navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    navigationBar.navigationItem = self.ay_navigationItem;
    return navigationBar;
}

- (void)setAy_navigationBar:(AYNavigationBar *)ay_navigationBar
{
    objc_setAssociatedObject(self, @selector(ay_navigationBar), ay_navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (AYNavigationItem *)ay_navigationItem
{
    AYNavigationItem *navigationItem = objc_getAssociatedObject(self, _cmd);
    if (!navigationItem) {
        navigationItem = [[AYNavigationItem alloc] init];
        objc_setAssociatedObject(self, @selector(ay_navigationItem), navigationItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return navigationItem;
}

- (void)setAy_navigationItem:(AYNavigationItem *)ay_navigationItem
{
    objc_setAssociatedObject(self, @selector(ay_navigationItem), ay_navigationItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)ay_navigationBarDisabled
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setAy_navigationBarDisabled:(BOOL)ay_navigationBarDisabled
{
    objc_setAssociatedObject(self, @selector(ay_navigationBarDisabled), @(ay_navigationBarDisabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.fd_prefersNavigationBarHidden = !ay_navigationBarDisabled;
}

@end

#pragma mark - UINavigationController (AYNavigationBar)
@implementation UINavigationController (AYNavigationBar)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalMethod = class_getInstanceMethod(self, @selector(setNavigationBarHidden:animated:));
        Method swizzledMethod = class_getInstanceMethod(self, @selector(ay__setNavigationBarHidden:animated:));
        method_exchangeImplementations(originalMethod, swizzledMethod);
    });
}

- (void)ay__setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated
{
    [self ay__setNavigationBarHidden:hidden animated:animated];
    
    if (!self.ay_navigationBarEnabled) {
        return;
    }
    
    if (!hidden) {
        self.topViewController.ay_navigationBar.hidden = YES;
    }
}

#pragma mark - getter & setter
- (BOOL)ay_navigationBarEnabled
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setAy_navigationBarEnabled:(BOOL)ay_navigationBarEnabled
{
    objc_setAssociatedObject(self, @selector(ay_navigationBarEnabled), @(ay_navigationBarEnabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.ay_navigationBarHidden = !ay_navigationBarEnabled;
}

- (UIColor *)ay_barTintColor
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setAy_barTintColor:(UIColor *)ay_barTintColor
{
    objc_setAssociatedObject(self, @selector(ay_barTintColor), ay_barTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.topViewController.ay_navigationBar.backgroundColor = ay_barTintColor;
}

- (UIImage *)ay_barBackgroundImage
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setAy_barBackgroundImage:(UIImage *)ay_barBackgroundImage
{
    objc_setAssociatedObject(self, @selector(ay_barBackgroundImage), ay_barBackgroundImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.topViewController.ay_navigationBar.backgroundImage = ay_barBackgroundImage;
}

- (UIImage *)ay_barShadowImage
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setAy_barShadowImage:(UIImage *)ay_barShadowImage
{
    objc_setAssociatedObject(self, @selector(ay_barShadowImage), ay_barShadowImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.topViewController.ay_navigationBar.shadowImage = ay_barShadowImage;
}

- (BOOL)ay_navigationBarHidden
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setAy_navigationBarHidden:(BOOL)ay_navigationBarHidden
{
    objc_setAssociatedObject(self, @selector(ay_navigationBarHidden), @(ay_navigationBarHidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.topViewController.ay_navigationBar setHidden:ay_navigationBarHidden];
    self.topViewController.fd_prefersNavigationBarHidden = !ay_navigationBarHidden;
}

- (NSDictionary<NSAttributedStringKey,id> *)ay_titleTextAttributes
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setAy_titleTextAttributes:(NSDictionary<NSAttributedStringKey,id> *)ay_titleTextAttributes
{
    objc_setAssociatedObject(self, @selector(ay_titleTextAttributes), ay_titleTextAttributes, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.topViewController.ay_navigationItem.titleTextAttributes = ay_titleTextAttributes;
}

- (AYNavigationBar *)ay_navigationBar
{
    return self.topViewController.ay_navigationBar;
}

- (AYNavigationItem *)ay_navigationItem
{
    return self.topViewController.ay_navigationItem;
}

@end
