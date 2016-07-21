//
//  HHBaseViewController.m
//  HHKit
//
//  Created by liuwenjie on 16/7/9.
//  Copyright © 2016年 hhauto. All rights reserved.
//

#import "HHBaseViewController.h"

@interface HHBaseViewController ()<UIAlertViewDelegate>
{
    NSInteger _navigationStackCount;
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

}
- (void)viewDidPop {
    
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
                handle:(void (^)(UIAlertView *alertView,NSInteger index))clickButtonAtIndex
                cancle:(NSString *)cancle
                others:(NSString *)others,...{
    
}
/*!
 *  弹出一个简洁化系统alertView
 *  @title 提示
 *  @buttons 取消,确定
 */
- (void)showAlertMessage:(NSString *)msg
                  handle:(void (^)(UIAlertView *alertView,NSInteger index))clickButtonAtIndex{
    
}
/*!
 *  弹出一个简洁化系统alertView
 *  @title 提示
 *  @buttons 确定
 */
- (void)showNormalAlertMessage:(NSString *)msg
                        handle:(void (^)(UIAlertView *alertView,NSInteger index))clickButtonAtIndex{
    
}

#pragma mark - MBProgressHUD
/*!
 *  显示一个没有文字只有菊花的HUD,需要手动hide
 */
- (MBProgressHUD *)showHUD{
    return nil;
}
/*!
 *  显示一个带有文字和菊花的HUD,需要手动hide
 */
- (MBProgressHUD *)showHUDText:(NSString *)text{
    return nil;
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
    
}
#pragma mark - delegate
#pragma mark UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
}
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
