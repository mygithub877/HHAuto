//
//  HHAlertView.h
//  HHKit
//
//  Created by liuwenjie on 16/7/24.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHAlertView : NSObject
/*!
 *  弹出一个系统自带alertView
 */
- (void)showAlertTitle:(NSString *)title
               message:(NSString *)msg
                handle:(void (^)(NSInteger index))clickButtonAtIndex
                cancle:(NSString *)cancle
                others:(NSString *)others, ... NS_REQUIRES_NIL_TERMINATION;
@end
