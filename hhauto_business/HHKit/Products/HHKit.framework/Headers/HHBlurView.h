//
//  HHBlurView.h
//  HHKit
//
//  Created by liuwenjie on 16/7/9.
//  Copyright © 2016年 hhauto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHSystemInfo.h"
typedef  NS_ENUM(NSInteger,HHBlurStyle){
    HHBlurStyleExtraLight,  // 默认白色
    HHBlurStyleLight,       // 白色
    HHBlurStyleDark,        // 黑色

};
@interface HHBlurView : UIView
/**
 *  设置高斯模糊效果style
 *
 *  @param blurStyle
 */

- (void)setBlurStyle:(HHBlurStyle)blurStyle; // default is UIBarStyleDefault
/**
 *  设置圆角半径
 *
 *  @param cornerRadius 圆角半径
 */
- (void)setBlurViewCornerRadius:(CGFloat)cornerRadius; //default is 0


@end
