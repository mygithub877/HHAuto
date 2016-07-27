//
//  HHBaseViewController.m
//  HHKit
//
//  Created by liuwenjie on 16/7/9.
//  Copyright © 2016年 hhauto. All rights reserved.
//

#import "HHBaseViewController.h"
#import "PrivateHeader.h"
@interface HHBaseViewController ()<UIAlertViewDelegate>
{
    NSInteger _navigationStackCount;
    MBProgressHUD *_hud;
    void (^_alertHandleBlock)(NSInteger);
}

@end

@implementation HHBaseViewController
@synthesize tableView=_tableView;
@synthesize dataSource=_dataSource;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:244/255.f green:244/255.f blue:244/255.f alpha:1];
    self.automaticallyAdjustsScrollViewInsets = NO;

    // Do any additional setup after loading the view.
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (_navigationStackCount == self.navigationController.viewControllers.count) {
        [self viewWillPop];
    }
    _navigationStackCount = self.navigationController.viewControllers.count;
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    if (self.navigationController.viewControllers.count < _navigationStackCount) {
        [self viewDidPop];
    }
}
- (void)viewWillPop{
    //父类方法
}
- (void)viewDidPop {
    //父类方法
}
#pragma mark - setter
#pragma mark - getter
- (UITableView *)tableView{
    if (_tableView==nil) {
        _tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    }
    return _tableView;
}
- (NSMutableArray *)dataSource{
    if (_dataSource==nil) {
        _dataSource=[NSMutableArray array];
    }
    return _dataSource;
}
#pragma mark - Override Super method
- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion{
    if ([viewControllerToPresent isMemberOfClass:[HHBaseViewController class]]) {
        ((HHBaseViewController *)viewControllerToPresent).isModalAppear=YES;
    }else if ([viewControllerToPresent isMemberOfClass:[UINavigationController class]]){
        if ([((UINavigationController *)viewControllerToPresent).viewControllers.firstObject isMemberOfClass:[HHBaseViewController class]]) {
            ((HHBaseViewController *)((UINavigationController *)viewControllerToPresent).viewControllers.firstObject).isModalAppear=YES;
        }
    }
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}

#pragma mark - UIAlertView
/*!
 *  弹出一个系统自带alertView
 */
- (void)showAlertTitle:(NSString *)title
               message:(NSString *)msg
                handle:(void (^)(NSInteger index))clickButtonAtIndex
                cancle:(NSString *)cancle
                others:(NSString *)others,...{
    HHAlertView *alert=[HHAlertView alloc];
    [alert initWithTitle:title
                              message:msg
                           showTarget:self
                               handle:clickButtonAtIndex
                               cancle:cancle
                               others:others,nil];
    id eachObject;
    va_list args;
    va_start(args, others);
    while ((eachObject=va_arg(args, id))) {
        if (eachObject) {
            [alert addButtonTitle:eachObject];
        }
    }
    va_end(args);

}
/*!
 *  弹出一个简洁化系统alertView
 *  @title 提示
 *  @buttons 取消,确定
 */
- (void)showAlertMessage:(NSString *)msg
                  handle:(void (^)(NSInteger index))clickButtonAtIndex{
    [self showAlertTitle:@"提示" message:msg handle:clickButtonAtIndex cancle:@"取消" others:@"确定", nil];
}
/*!
 *  弹出一个简洁化系统alertView
 *  @title 提示
 *  @buttons 确定
 */
- (void)showNormalAlertMessage:(NSString *)msg
                        handle:(void (^)(NSInteger index))clickButtonAtIndex{
    [self showAlertTitle:@"提示" message:msg handle:clickButtonAtIndex cancle:nil others:@"确定", nil];
}

#pragma mark - MBProgressHUD
/*!
 *  显示一个带有文字和菊花的HUD,需要手动hide
 */
- (MBProgressHUD *)showHUDText:(NSString *)text{
    if (_hud) {
        _hud = [[MBProgressHUD alloc] initWithView:self.view];
    }
    _hud.label.text=text;
    [_hud show:YES];
    return _hud;
}
/*!
 *  显示一个不带菊花的提示性HUD,自动hide
 *  如果迭代多个则按队列出现和影藏
 */
- (MBProgressHUD *)showToastHUD:(NSString *)text{
    return nil;
}

/*!
 *  影藏HUD,适用于不能自动影藏的HUD
 */
- (void)hideHUD{
    [_hud hideAnimated:YES];
}
#pragma mark - delegate
#pragma mark UIAlertViewDelegate
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - touch
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    if (_hideKeyboardWhenTouch) {
        [self.view endEditing:YES];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
