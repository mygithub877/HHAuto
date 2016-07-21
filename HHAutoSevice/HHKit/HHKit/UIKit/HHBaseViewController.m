//
//  HHBaseViewController.m
//  HHKit
//
//  Created by liuwenjie on 16/7/9.
//  Copyright © 2016年 hhauto. All rights reserved.
//

#import "HHBaseViewController.h"

@interface HHBaseViewController ()
{
    NSInteger _navigationStackCount;
}
@end

@implementation HHBaseViewController

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
