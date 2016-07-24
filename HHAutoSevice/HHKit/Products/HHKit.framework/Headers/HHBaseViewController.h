//
//  HHBaseViewController.h
//  HHKit
//
//  Created by liuwenjie on 16/7/9.
//  Copyright © 2016年 hhauto. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MBProgressHUD;
@interface HHBaseViewController : UIViewController

/**
 *  是否被模态弹出
 */
@property (nonatomic, assign) BOOL isModalAppear;
/**
 *  是否导航栈底控制器
 */
@property (nonatomic, assign, readonly) BOOL isRootController;

#pragma mark - keyboard
/*!
 *  当触摸点击控制器view时影藏键盘
 *  如果view上被其他空间覆盖则此属性设置无效
 */
@property (nonatomic, assign) BOOL hideKeyboardWhenTouch;
/*!
 *  当触摸点击控制器view时影藏键盘
 *  如果view上被其他空间覆盖则此属性设置有效
 */
@property (nonatomic, assign) BOOL hideKeyboardWhenTouchView;

#pragma mark - UITableView
/*!
 *  获取一个默认初始化的UITableView,懒加载
 *  @frame self.view.bounds
 *  @style UITableViewStylePlain
 */
@property (nonatomic, strong, readonly) UITableView *tableView;
/*!
 *  获取一个默认初始化的空数据的可变数组,懒加载
 */
@property (nonatomic, strong, readonly) NSMutableArray *dataSource;


#pragma mark - Pop
/*!
 *  当控制器将要pop出当前导航栈的时候调用
 *  如果想在将要pop完成的时候做一些操作则重写此方法,最好先调用super
 *  此方法只会在pop是调用一次,不像viewWillDisappear会被调用多次
 */
- (void)viewWillPop;
/*!
 *  当控制器pop完成出当前导航栈的时候调用
 *  如果想在pop完成的时候做一些操作则重写此方法,最好先调用super
 *  此方法只会在pop时调用一次,不像viewDidDisappear会被调用多次
 */
- (void)viewDidPop;



- (void)popORDismissViewController;
- (void)popToViewControllerAtIndex:(NSInteger)index;
- (void)popToViewControllerAtClass:(Class)aClass;

#pragma mark - UIAlertView
/*!
 *  弹出一个系统自带alertView
 */
- (void)showAlertTitle:(NSString *)title
                   message:(NSString *)msg
                    handle:(void (^)(NSInteger index))clickButtonAtIndex
                    cancle:(NSString *)cancle
                    others:(NSString *)others, ... NS_REQUIRES_NIL_TERMINATION;
/*!
 *  弹出一个简洁化系统alertView
 *  @title 提示
 *  @buttons 取消,确定
 */
- (void)showAlertMessage:(NSString *)msg
                      handle:(void (^)(NSInteger index))clickButtonAtIndex;
/*!
 *  弹出一个简洁化系统alertView
 *  @title 提示
 *  @buttons 确定
 */
- (void)showNormalAlertMessage:(NSString *)msg
                      handle:(void (^)(NSInteger index))clickButtonAtIndex;

#pragma mark - MBProgressHUD
/*!
 *  显示一个带有文字和菊花的HUD,需要手动hide
 */
- (MBProgressHUD *)showHUDText:(NSString *)text;
/*!
 *  显示一个不带菊花的提示性HUD,自动hide
 *  如果迭代多个则按队列出现和影藏
 */
- (MBProgressHUD *)showToastHUD:(NSString *)text;

/*!
 *  影藏HUD,适用于不能自动影藏的HUD
 */
- (void)hideHUD;
@end
