//
//  HHBlurView.m
//  HHKit
//
//  Created by liuwenjie on 16/7/9.
//  Copyright © 2016年 hhauto. All rights reserved.
//

#import "HHBlurView.h"


#define kBlurViewMarginToBorder 10  // 距离边距

@interface HHBlurView ()

#ifdef __IPHONE_8_0
////ios8使用visual effect 实现高斯模糊
@property (retain, nonatomic) UIVisualEffectView * visualBlurView;
#endif

//ios7通过uitoolbar 实现高斯模糊
@property (retain, nonatomic) UIToolbar * blurView;

@property (nonatomic) HHBlurStyle blurStyle;

@end

@implementation HHBlurView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        if ([self visualEffectSupported])
        {
#ifdef __IPHONE_8_0
            self.visualBlurView = [self visualBlurViewWithEffect:HHBlurStyleExtraLight];
            [self addSubview:self.visualBlurView];
#endif
        }
        else
        {
            [self addSubview:self.blurView];
        }
        
        self.backgroundColor = [UIColor clearColor];
        self.blurStyle = HHBlurStyleExtraLight;
        self.clipsToBounds = YES;
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (UIToolbar *)blurView
{
    if (!_blurView)
    {
        CGRect rect = CGRectMake(-kBlurViewMarginToBorder,
                                 -kBlurViewMarginToBorder,
                                 CGRectGetWidth(self.bounds) + 2 * kBlurViewMarginToBorder,
                                 CGRectGetHeight(self.bounds) + 2 * kBlurViewMarginToBorder);
        _blurView = [[UIToolbar alloc] initWithFrame:rect];
        _blurView.translucent = YES;
        _blurView.barStyle = UIBarStyleDefault;
        _blurView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    }
    
    return _blurView;
}

#ifdef __IPHONE_8_0
- (UIVisualEffectView *)visualBlurViewWithEffect:(HHBlurStyle)blurStye
{
    UIBlurEffectStyle effectStyle = UIBlurEffectStyleLight;
    switch (blurStye) {
        case HHBlurStyleExtraLight:
            effectStyle = UIBlurEffectStyleExtraLight;
            break;
        case HHBlurStyleLight:
            effectStyle = UIBlurEffectStyleLight;
            break;
        case HHBlurStyleDark:
            effectStyle = UIBlurEffectStyleDark;
            break;
        default:
            break;
    }
    @try
    {
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:effectStyle]];
        effectView.frame = CGRectMake(-kBlurViewMarginToBorder,
                                      -kBlurViewMarginToBorder,
                                      CGRectGetWidth(self.bounds) + 2 * kBlurViewMarginToBorder,
                                      CGRectGetHeight(self.bounds) + 2 * kBlurViewMarginToBorder);
        effectView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        return effectView;
    }
    @catch (NSException *exception)
    {
        return nil;
    }
}
#endif

- (void)setAlpha:(CGFloat)alpha
{
    //UIToolbar必须父view的alpha为1才会显示
    if(_blurView)
    {
        for(UIView *subview in [self subviews])
        {
            if (_blurView != subview)
            {
                subview.alpha = alpha;
            }
        }
    }
    else
    {
        [super setAlpha:alpha];
    }
}

- (void)setBlurStyle:(HHBlurStyle)blurStyle
{
#ifdef __IPHONE_8_0
    if(_visualBlurView)
    {
        [self.visualBlurView removeFromSuperview];
        self.visualBlurView = nil;
        self.visualBlurView = [self visualBlurViewWithEffect:blurStyle];
        [self addSubview:self.visualBlurView];
    }
#endif
    
    if (_blurView)
    {
        if(blurStyle == HHBlurStyleDark)
        {
            [_blurView setBarStyle:UIBarStyleBlack];
        }
        else
        {
            [_blurView setBarStyle:UIBarStyleDefault];
        }
        
    }
}

- (void)setBlurViewCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
}

- (BOOL)supportedBackdropEffect
{
    return ([[HHSystemInfo sharedInstance] iosVersion] > (6.9 + 0.0001)) && (NO == [[HHSystemInfo sharedInstance] isLowEndEquipment]);
}

- (BOOL)visualEffectSupported
{
#ifdef __IPHONE_8_0
    return (([[HHSystemInfo sharedInstance] iosVersion] >= (8.0 - 0.0001)) && [self supportedBackdropEffect]);
#else
    return NO;
#endif
}

@end
