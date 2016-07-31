//
//  HHAlertView.h
//  HHKit
//
//  Created by liuwenjie on 16/7/24.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HHAlertView : NSObject
/*!
 *  弹出一个系统自带alertView
 */
- (void)initWithTitle:(NSString *)title
               message:(NSString *)msg
           showTarget:(UIViewController *)controller/* ios8以上需要传入,如果是nil则使用iOS7以下的方式弹出*/
                handle:(void (^)(NSInteger index))clickButtonAtIndex
                cancle:(NSString *)cancle
                others:(NSString *)others, ... NS_REQUIRES_NIL_TERMINATION;

- (void)addButtonTitle:(NSString *)title;
@end
