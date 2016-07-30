//
//  HHNavigationController.h
//  HHKit
//
//  Created by liuwenjie on 16/7/30.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHNavigationController : UINavigationController

@end


#pragma mark - HHNavigationBar
@interface HHNavigationBar : UINavigationBar

@property (strong, nonatomic) UIColor *color;//背景色
/*
 *  设置navigationBar的背景色
 */
-(void)setNavigationBarWithColor:(UIColor *)color;
/*
 *  设置navigationBar的渐变背景色
 */
-(void)setNavigationBarWithColors:(NSArray *)colours;

@end
