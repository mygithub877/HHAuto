//
//  HHBaseViewController.h
//  HHKit
//
//  Created by liuwenjie on 16/7/9.
//  Copyright © 2016年 hhauto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHBaseViewController : UIViewController

/*!
 *  当控制器将要pop出当前导航栈的时候调用
 *  如果想在将要pop完成的时候做一些操作则重写此方法,最好先调用super
 */
- (void)viewWillPop;
/*!
 *  当控制器pop完成出当前导航栈的时候调用
 *  如果想在pop完成的时候做一些操作则重写此方法,最好先调用super
 */
- (void)viewDidPop;
@end
