//
//  UIImage+Util.h
//  BSports
//
//  Created by 柳文杰 on 15/1/31.
//  Copyright (c) 2015年 ist. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Util)
/*
 *  根据颜色和大小创建一个图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
/*
 *  修改图片元素颜色,e.g 一个带有红色对勾的图片,可以把它修改成指定颜色对勾的图片
 */
- (UIImage *)imageWithTintColor:(UIColor *)color;
/*
 *  以图片中心点为拉伸起始点来拉伸一个图片
 */
- (UIImage *)stretchableImage;
/*
 *  根据指定范围裁剪图片
 */
- (UIImage *)cutImageWithRect:(CGRect)rect;
/*
 *  纠正图片方向
 */
- (UIImage *)rotateImage;


// 以下方法是创建一个高斯模糊状图片
- (UIImage *)applyLightEffect;
- (UIImage *)applyExtraLightEffect;
- (UIImage *)applyDarkEffect;
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;
//  自定义高斯模糊属性创建
- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;



@end
