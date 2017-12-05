//
//  AYNavigationBar.m
//
//  Created by 高翔 on 2017/9/20.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import "AYNavigationBar.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

#import <objc/runtime.h>

CGFloat contentViewHeight = 44.f;
const CGFloat AYNavigationBarLargeTitleMinHeight = 49.f;
const CGFloat AYNavigationBarPortraitHeight = 44.f;
const CGFloat AYNavigationBarLandscapeHeight = 32.f;
const CGFloat AYNavigationBarShadowViewHeight = 1.f / 3;
const CGFloat AYNavigationBarBackButtonTitleMaxWidth = 80.f;
const CGFloat AYNavigationBarIPhoneXFixedSpaceWidth = 56.f;
const CGFloat AYNavigationBarShowLargeTitleViewDuration = 0.5;

#define kAYNavigationBarIsIPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define kAYNavigationBarStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height
#define kAYNavigationBarScreenWidth [UIScreen mainScreen].bounds.size.width

#define kAYNavigationBarFrame CGRectMake(0, kAYNavigationBarStatusBarHeight, kAYNavigationBarScreenWidth, contentViewHeight)
#define kAYBarContentViewFrame CGRectMake(0, 0, kAYNavigationBarScreenWidth, contentViewHeight)

#pragma mark - AYNavigationItem
@interface AYNavigationItem ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, assign) CGRect titleViewFrame;
@property (nonatomic, assign) CGFloat leftOffset;
@property (nonatomic, assign) CGFloat rightOffset;

@end

@implementation AYNavigationItem

- (instancetype)init
{
    self = [super initWithFrame:kAYBarContentViewFrame];
    if (self) {
        
        _titleViewStyle = AYNavigationBarTitleViewStyleDefault;
        
        [self ay_addSubviews];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self updateLeftBarButtonFrame];
    [self updateLeftBarItemsFrame];
    [self updateRightBarButtonFrame];
    [self updateRightBarItemsFrame];
    [self updateTitleFrame];
}

#pragma mark - private
- (void)ay_addSubviews
{
    [self ay_addTitleLabel];
}

- (void)ay_addTitleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.hidden = YES;
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _titleLabel.textColor = [UIColor darkTextColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
}

- (void)updateTitleLabelFrame
{
    CGFloat offset = MAX(self.leftOffset, self.rightOffset) * 2;
    _titleLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame) - offset, contentViewHeight);
    _titleLabel.center = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2);
}

- (void)updateTitleViewFrame
{
    if (self.titleViewStyle == AYNavigationBarTitleViewStyleAutomatic) {
        CGFloat titleViewMaxWidth = CGRectGetWidth(self.frame) - self.leftOffset - self.rightOffset;
        CGRect frame = self.titleViewFrame;
        frame.size.height = frame.size.height <= contentViewHeight ? frame.size.height : contentViewHeight;
        frame.size.width = frame.size.width <= titleViewMaxWidth ? frame.size.width : titleViewMaxWidth;
        frame.origin.x = self.leftOffset;
        frame.origin.y = (contentViewHeight - frame.size.height) / 2;
        _titleView.frame = frame;
    }
    else {
        CGFloat offset = MAX(self.leftOffset, self.rightOffset) * 2;
        CGFloat titleViewMaxWidth = CGRectGetWidth(self.frame) - offset;
        CGRect frame = self.titleViewFrame;
        frame.size.height = frame.size.height <= contentViewHeight ? frame.size.height : contentViewHeight;
        frame.size.width = frame.size.width <= titleViewMaxWidth ? frame.size.width : titleViewMaxWidth;
        _titleView.frame = frame;
        _titleView.center = CGPointMake(self.center.x, CGRectGetHeight(self.frame) / 2);
    }
}

- (void)updateTitleFrame
{
    if (_titleView) {
        [self updateTitleViewFrame];
    }
    else {
        [self updateTitleLabelFrame];
    }
}

- (void)removeAllLeftBarItems
{
    if ([self.subviews containsObject:_leftBarButton]) {
        [_leftBarButton removeFromSuperview];
    }
    if (_leftBarButton) {
        _leftBarButton = nil;
    }
    [_leftBarItems enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
}

- (void)removeAllRightBarItems
{
    if ([self.subviews containsObject:_rightBarButton]) {
        [_rightBarButton removeFromSuperview];
    }
    if (_rightBarButton) {
        _rightBarButton = nil;
    }
    [_rightBarItems enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
}

- (void)updateLeftBarButtonFrame
{
    CGRect frame = _leftBarButton.frame;
    frame.origin.x = 0.f;
    frame.size.height = frame.size.height > contentViewHeight ? contentViewHeight : frame.size.height;
    frame.origin.y = (contentViewHeight - frame.size.height) / 2;
    _leftBarButton.frame = frame;
}

- (void)updateLeftBarItemsFrame
{
    if (_leftBarItems.count > 0) {
        __block CGFloat lastItemWidth = 0.f;
        [_leftBarItems enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGRect frame = obj.frame;
            frame.origin.x = lastItemWidth;
            frame.size.height = frame.size.height > contentViewHeight ? contentViewHeight : frame.size.height;
            frame.origin.y = (contentViewHeight - frame.size.height) / 2;
            lastItemWidth += frame.size.width;
            obj.frame = frame;
        }];
    }
}

- (void)updateRightBarButtonFrame
{
    CGRect frame = _rightBarButton.frame;
    frame.origin.x = CGRectGetWidth(self.bounds) - frame.size.width;
    frame.size.height = frame.size.height > contentViewHeight ? contentViewHeight : frame.size.height;
    frame.origin.y = (contentViewHeight - frame.size.height) / 2;
    _rightBarButton.frame = frame;
}

- (void)updateRightBarItemsFrame
{
    if (_rightBarItems.count > 0) {
        __block CGFloat lastItemWidth = 0.f;
        [_rightBarItems enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGRect frame = obj.frame;
            frame.origin.x = CGRectGetWidth(self.frame) - frame.size.width - lastItemWidth;
            frame.size.height = frame.size.height > contentViewHeight ? contentViewHeight : frame.size.height;
            frame.origin.y = (contentViewHeight - frame.size.height) / 2;
            lastItemWidth = lastItemWidth + frame.size.width;
            obj.frame = frame;
        }];
    }
}

#pragma mark - getter & setter
- (void)setTitleViewStyle:(AYNavigationBarTitleViewStyle)titleViewStyle
{
    _titleViewStyle = titleViewStyle;
    
    [self updateTitleViewFrame];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.hidden = NO;
    _titleLabel.attributedText = [[NSAttributedString alloc] initWithString:title ?: @"" attributes:self.titleTextAttributes];
    
    if (title) {
        if ([self.subviews containsObject:_titleView]) {
            [_titleView removeFromSuperview];
        }
        if (_titleView) {
            _titleView = nil;
        }
        [self updateTitleLabelFrame];
    }
}

- (void)setTitleView:(UIView *)titleView
{
    [_titleView removeFromSuperview];
    self.titleViewFrame = titleView.frame;
    _titleView = titleView;
    
    if (titleView) {
        _titleLabel.hidden = YES;
        
        [self updateTitleViewFrame];
        [self addSubview:_titleView];
    }
}

- (void)setTitleTextAttributes:(NSDictionary<NSAttributedStringKey,id> *)titleTextAttributes
{
    _titleTextAttributes = [titleTextAttributes copy];
    
    if (self.title) {
        _titleLabel.attributedText = [[NSAttributedString alloc] initWithString:self.title attributes:titleTextAttributes];
    }
}

- (void)setLeftBarButton:(UIButton *)leftBarButton
{
    [_leftBarButton removeFromSuperview];
    _leftBarButton = leftBarButton;
    
    if (leftBarButton) {
        
        [_leftBarItems enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        _leftBarItems = @[];
        
        CGRect frame = leftBarButton.frame;
        frame.origin.x = 0.f;
        frame.size.height = frame.size.height > contentViewHeight ? contentViewHeight : frame.size.height;
        frame.origin.y = (contentViewHeight - frame.size.height) / 2;
        _leftBarButton.frame = frame;
        
        [self addSubview:_leftBarButton];
    }
    [self updateTitleFrame];
}

- (void)setLeftBarItems:(NSArray<UIView *> *)leftBarItems
{
    [self removeAllLeftBarItems];
    _leftBarItems = [leftBarItems copy];
    
    if (leftBarItems.count > 0) {
        __block CGFloat lastItemWidth = 0.f;
        [leftBarItems enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGRect frame = obj.frame;
            frame.origin.x = lastItemWidth;
            frame.size.height = frame.size.height > contentViewHeight ? contentViewHeight : frame.size.height;
            frame.origin.y = (contentViewHeight - frame.size.height) / 2;
            lastItemWidth += frame.size.width;
            obj.frame = frame;
            [self addSubview:obj];
        }];
    }
    [self updateTitleFrame];
}

- (void)setRightBarButton:(UIButton *)rightBarButton
{
    [_rightBarButton removeFromSuperview];
    _rightBarButton = rightBarButton;
    
    if (rightBarButton) {
        
        [_rightBarItems enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        _rightBarItems = @[];
        
        CGRect frame = rightBarButton.frame;
        frame.origin.x = CGRectGetWidth(self.bounds) - frame.size.width;
        frame.size.height = frame.size.height > contentViewHeight ? contentViewHeight : frame.size.height;
        frame.origin.y = (contentViewHeight - frame.size.height) / 2;
        _rightBarButton.frame = frame;
        [self addSubview:_rightBarButton];
    }
    [self updateTitleFrame];
}

- (void)setRightBarItems:(NSArray<UIView *> *)rightBarItems
{
    [self removeAllRightBarItems];
    _rightBarItems = [rightBarItems copy];
    
    if (rightBarItems.count > 0) {
        __block CGFloat lastItemWidth = 0.f;
        [rightBarItems enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGRect frame = obj.frame;
            frame.origin.x = CGRectGetWidth(self.frame) - frame.size.width - lastItemWidth;
            frame.size.height = frame.size.height > contentViewHeight ? contentViewHeight : frame.size.height;
            frame.origin.y = (contentViewHeight - frame.size.height) / 2;
            lastItemWidth += frame.size.width;
            obj.frame = frame;
            [self addSubview:obj];
        }];
    }
    [self updateTitleFrame];
}

- (CGFloat)leftOffset
{
    _leftOffset = 0.f;
    if (_leftBarButton) {
        _leftOffset = CGRectGetWidth(_leftBarButton.frame);
    }
    if (_leftBarItems.count > 0) {
        [_leftBarItems enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            _leftOffset += CGRectGetWidth(obj.frame);
        }];
    }
    return _leftOffset;
}

- (CGFloat)rightOffset
{
    _rightOffset = 0.f;
    if (_rightBarButton) {
        _rightOffset = CGRectGetWidth(_rightBarButton.frame);
    }
    if (_rightBarItems.count > 0) {
        [_rightBarItems enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            _rightOffset += CGRectGetWidth(obj.frame);
        }];
    }
    return _rightOffset;
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
    self = [super initWithFrame:kAYNavigationBarFrame];
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
- (void)layoutSubviews
{
    [super layoutSubviews];

    [self ay_layoutSubviews];
}

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
                CGRect frame = self.frame;
                frame.origin.y = -self.bounds.size.height;
                self.frame = frame;
            } completion:^(BOOL finished) {
                if (finished) {
                    if (self.frame.origin.y < 0) {
                        [super setHidden:hidden];
                    }
                }
            }];
        }
        else {
            CGRect frame = self.frame;
            frame.origin.y = -self.bounds.size.height;
            self.frame = frame;
            [super setHidden:hidden];
        }
    }
    else {
        [super setHidden:hidden];
        if (animated) {
            [UIView animateWithDuration:UINavigationControllerHideShowBarDuration animations:^{
                self.frame = kAYNavigationBarFrame;
            }];
        }
        else {
            self.frame = kAYNavigationBarFrame;
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
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)ay_layoutSubviews
{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    BOOL isLandscape = UIInterfaceOrientationIsLandscape(orientation);
    CGFloat largeTitleViewHeight = 0.f;
    if (_prefersLargeTitles && !isLandscape) {
        largeTitleViewHeight = [self ay_largeTitleViewHeight];
    }
    contentViewHeight = isLandscape ? AYNavigationBarLandscapeHeight : AYNavigationBarPortraitHeight;
    CGRect barFrame = kAYNavigationBarFrame;
    CGFloat statusBarHeight = isLandscape ? 0.f : (kAYNavigationBarIsIPhoneX ? 44.f : 20.f);
    barFrame.origin.y = statusBarHeight;
    barFrame.size.height += largeTitleViewHeight;
    if (self.willHidden) barFrame.origin.y = -barFrame.size.height;
    self.frame = barFrame;
    
    _backgroundView.frame = [self barBackgroundFrame];
    _backgroundImageView.frame = _backgroundView.bounds;
    _shadowImageView.frame = [self barShadowViewFrame];
    _visualEffectView.frame = _backgroundView.bounds;
    
    _navigationItem.frame = [self barContentFrame];
    
    _largeTitleView.frame = CGRectMake(0, contentViewHeight, CGRectGetWidth(self.frame), largeTitleViewHeight);
    [self ay_showLargeTitle:(!isLandscape && _prefersLargeTitles)];
}

- (CGRect)barBackgroundFrame
{
    return CGRectMake(0, -self.frame.origin.y, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) + self.frame.origin.y);
}

- (CGRect)barShadowViewFrame
{
    return CGRectMake(0, CGRectGetHeight(_backgroundView.frame), CGRectGetWidth(_backgroundView.frame), AYNavigationBarShadowViewHeight);
}

- (CGRect)barContentFrame
{
    CGRect frame = kAYBarContentViewFrame;
    if ([self ay_needsFixedSpace]) {
        frame.origin.x = AYNavigationBarIPhoneXFixedSpaceWidth;
        frame.size.width = kAYNavigationBarScreenWidth - AYNavigationBarIPhoneXFixedSpaceWidth * 2;
    }
    return frame;
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
        CGRect fromFrame = CGRectMake(kAYNavigationBarScreenWidth / 2 - 18.f, -contentViewHeight, 36.f, contentViewHeight);
        _largeTitleLabel.layer.frame = fromFrame;
        _largeTitleLabel.alpha = 0.f;
        _largeTitleLabel.textColor = [UIColor darkTextColor];
        _largeTitleLabel.font = [UIFont boldSystemFontOfSize:32.f];
        [_largeTitleView addSubview:_largeTitleLabel];
    }
}

- (BOOL)ay_needsFixedSpace
{
    UIDeviceOrientation currentOrientation = [[UIDevice currentDevice] orientation];
    BOOL isLandscape = UIDeviceOrientationIsLandscape(currentOrientation);
    return isLandscape && kAYNavigationBarIsIPhoneX;
}

- (CGFloat)ay_largeTitleViewHeight
{
    UIFont *font = (UIFont *)self.largeTitleTextAttributes[NSFontAttributeName];
    CGFloat largeTitleViewHeight = font.pointSize * 1.2 > AYNavigationBarLargeTitleMinHeight ? font.pointSize * 1.2 : AYNavigationBarLargeTitleMinHeight;
    return largeTitleViewHeight;
}

- (void)ay_showLargeTitle:(BOOL)show
{
    if (_largeTitleView.hidden != show) {
        return;
    }
    if (show) {
        _largeTitleView.hidden = NO;
        _largeTitleLabel.attributedText = [[NSAttributedString alloc] initWithString:self.navigationItem.title ?: @"" attributes:self.largeTitleTextAttributes];
        [UIView animateWithDuration:AYNavigationBarShowLargeTitleViewDuration animations:^{
            _navigationItem.titleLabel.alpha = 0.f;
            _largeTitleLabel.alpha = 1.f;
            CGRect toFrame = CGRectMake(16.f, 0.f, kAYNavigationBarScreenWidth - 32.f, CGRectGetHeight(_largeTitleView.frame));
            _largeTitleLabel.frame = toFrame;
            _largeTitleLabel.layer.frame = toFrame;
        }];
    }
    else {
        _navigationItem.titleLabel.alpha = 1.f;
        _largeTitleLabel.alpha = 0.f;
        _largeTitleView.hidden = YES;
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
    
    [_navigationItem removeFromSuperview];
    [self addSubview:_navigationItem];
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
        
        if (self.navigationController.viewControllers.count > 1) {
            if (self.navigationController.ay_backBarButton) {
                [self ay_setCustomBackBarButton];
            }
            else {
                [self ay_updateDefaultBackBarButton];
            }
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
    if (!self.ay_navigationBar) {
        self.ay_navigationBar = [[AYNavigationBar alloc] initWithIdentifier:NSStringFromClass(self.class)];
    }
    if (!self.ay_navigationItem) {
        self.ay_navigationItem = [[AYNavigationItem alloc] init];
    }
    self.ay_navigationBar.navigationItem = self.ay_navigationItem;
    if (self.navigationItem.title) {
        self.ay_navigationItem.title = self.navigationItem.title;
    }
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
- (void)ay_updateDefaultBackBarButton
{
    UIButton *backBarButton = [UIButton buttonWithType:UIButtonTypeSystem];
    NSString *title = self.navigationController.viewControllers[self.navigationController.viewControllers.count - 2].ay_navigationItem.title;
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17.f]}];
    if (!title || titleSize.width > AYNavigationBarBackButtonTitleMaxWidth) {
        NSArray *appLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
        NSString *languageName = appLanguages.firstObject;
        BOOL isChinese = [languageName isEqualToString:@"zh-Hans-US"];
        title = isChinese ? @"く返回" : @"くBack";
        backBarButton.frame = isChinese ? CGRectMake(0, 0, 64, 44) : CGRectMake(0, 0, 70, 44);
    }
    else {
        backBarButton.frame = CGRectMake(0, 0, titleSize.width + 30, 44);
        title = [NSString stringWithFormat:@"く%@", title];
    }
    NSMutableAttributedString *mAttributedText = [[NSMutableAttributedString alloc] initWithString:title];
    [mAttributedText setAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:22]} range:NSMakeRange(0, 1)];
    [mAttributedText setAttributes:@{NSBaselineOffsetAttributeName: @(2.5), NSFontAttributeName: [UIFont systemFontOfSize:17.f]} range:NSMakeRange(1, mAttributedText.length - 1)];
    [backBarButton setAttributedTitle:mAttributedText forState:UIControlStateNormal];
    [backBarButton addTarget:self action:@selector(backBarButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.ay_navigationItem.leftBarButton = backBarButton;
}

- (void)ay_setCustomBackBarButton
{
    UIButton *backBarButton = [UIButton buttonWithType:UIButtonTypeSystem];
    backBarButton.frame = self.navigationController.ay_backBarButton.frame;
    NSString *title = [self.navigationController.ay_backBarButton titleForState:UIControlStateNormal];
    UIImage *image = [self.navigationController.ay_backBarButton imageForState:UIControlStateNormal];
    [backBarButton setTitle:title forState:UIControlStateNormal];
    backBarButton.titleEdgeInsets = self.navigationController.ay_backBarButton.titleEdgeInsets;
    if (image) {
        [backBarButton setImage:image forState:UIControlStateNormal];
        backBarButton.imageEdgeInsets = self.navigationController.ay_backBarButton.imageEdgeInsets;
    }
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
    return objc_getAssociatedObject(self, _cmd);
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

@end

#pragma mark - UINavigationController (AYNavigationBar)
@implementation UINavigationController (AYNavigationBar)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *sels = @[@"setNavigationBarHidden:animated:"];
        [sels enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            Method originalMethod = class_getInstanceMethod(self, NSSelectorFromString(obj));
            NSString *swizzledSel = [@"ay__" stringByAppendingString:obj];
            Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(swizzledSel));
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }];
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

- (UIButton *)ay_backBarButton
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setAy_backBarButton:(UIButton *)ay_backBarButton
{
    objc_setAssociatedObject(self, @selector(ay_backBarButton), ay_backBarButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.viewControllers.count > 1) {
        [self.topViewController ay_setCustomBackBarButton];
    }
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

@end
