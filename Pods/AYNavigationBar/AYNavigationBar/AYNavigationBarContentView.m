//
//  AYNavigationBarContentView.m
//  AYNavigationBarDemo
//
//  Created by GorXion on 2018/2/1.
//  Copyright © 2018年 adinnet. All rights reserved.
//

#import "AYNavigationBarContentView.h"

#define kAYBarContentViewDefaultFrame CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 44.0)

@interface AYNavigationBarContentView()

@property (nonatomic, assign) CGFloat leftOffset;
@property (nonatomic, assign) CGFloat rightOffset;

@end

@implementation AYNavigationBarContentView

- (instancetype)init
{
    self = [super initWithFrame:kAYBarContentViewDefaultFrame];
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

- (void)updateConstraints
{
    [super updateConstraints];
    
    if (![self.subviews containsObject:self.titleView]) {
        return;
    }
    
    CGRect frame = self.titleView.frame;
    CGFloat height = frame.size.height <= CGRectGetHeight(self.frame) ? frame.size.height : CGRectGetHeight(self.frame);
    CGFloat left = self.leftOffset;
    CGFloat right = self.rightOffset;
    if (self.titleViewStyle == AYNavigationBarTitleViewStyleDefault) {
        CGFloat offset = MAX(self.leftOffset, self.rightOffset);
        left = right = offset;
    }
    [self removeConstraints:self.constraints];
    self.titleView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:left]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-right]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height]];
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
    _titleLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame) - offset, CGRectGetHeight(self.frame));
    _titleLabel.center = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2);
}

- (void)updateTitleFrame
{
    if (_titleView) {
        [self updateConstraintsIfNeeded];
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
    frame.size.height = frame.size.height > CGRectGetHeight(self.frame) ? CGRectGetHeight(self.frame) : frame.size.height;
    frame.origin.y = (CGRectGetHeight(self.frame) - frame.size.height) / 2;
    _leftBarButton.frame = frame;
}

- (void)updateLeftBarItemsFrame
{
    if (_leftBarItems.count > 0) {
        __block CGFloat lastItemWidth = 0.f;
        [_leftBarItems enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGRect frame = obj.frame;
            frame.origin.x = lastItemWidth;
            frame.size.height = frame.size.height > CGRectGetHeight(self.frame) ? CGRectGetHeight(self.frame) : frame.size.height;
            frame.origin.y = (CGRectGetHeight(self.frame) - frame.size.height) / 2;
            lastItemWidth += frame.size.width;
            obj.frame = frame;
        }];
    }
}

- (void)updateRightBarButtonFrame
{
    CGRect frame = _rightBarButton.frame;
    frame.origin.x = CGRectGetWidth(self.bounds) - frame.size.width;
    frame.size.height = frame.size.height > CGRectGetHeight(self.frame) ? CGRectGetHeight(self.frame) : frame.size.height;
    frame.origin.y = (CGRectGetHeight(self.frame) - frame.size.height) / 2;
    _rightBarButton.frame = frame;
}

- (void)updateRightBarItemsFrame
{
    if (_rightBarItems.count > 0) {
        __block CGFloat lastItemWidth = 0.f;
        [_rightBarItems enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGRect frame = obj.frame;
            frame.origin.x = CGRectGetWidth(self.frame) - frame.size.width - lastItemWidth;
            frame.size.height = frame.size.height > CGRectGetHeight(self.frame) ? CGRectGetHeight(self.frame) : frame.size.height;
            frame.origin.y = (CGRectGetHeight(self.frame) - frame.size.height) / 2;
            lastItemWidth = lastItemWidth + frame.size.width;
            obj.frame = frame;
        }];
    }
}

#pragma mark - getter & setter
- (void)setTitleViewStyle:(AYNavigationBarTitleViewStyle)titleViewStyle
{
    _titleViewStyle = titleViewStyle;
    
    [self updateConstraintsIfNeeded];
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
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
    _titleView = titleView;
    
    if (titleView) {
        _titleLabel.hidden = YES;
        
        [self addSubview:_titleView];
        [self updateConstraintsIfNeeded];
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
        frame.size.height = frame.size.height > CGRectGetHeight(self.frame) ? CGRectGetHeight(self.frame) : frame.size.height;
        frame.origin.y = (CGRectGetHeight(self.frame) - frame.size.height) / 2;
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
            frame.size.height = frame.size.height > CGRectGetHeight(self.frame) ? CGRectGetHeight(self.frame) : frame.size.height;
            frame.origin.y = (CGRectGetHeight(self.frame) - frame.size.height) / 2;
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
        frame.size.height = frame.size.height > CGRectGetHeight(self.frame) ? CGRectGetHeight(self.frame) : frame.size.height;
        frame.origin.y = (CGRectGetHeight(self.frame) - frame.size.height) / 2;
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
            frame.size.height = frame.size.height > CGRectGetHeight(self.frame) ? CGRectGetHeight(self.frame) : frame.size.height;
            frame.origin.y = (CGRectGetHeight(self.frame) - frame.size.height) / 2;
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
