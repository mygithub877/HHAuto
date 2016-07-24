//
//  DetailViewController.h
//  HHAutoSevice
//
//  Created by LWJ on 16/7/11.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HHKit/HHKit.h>

@interface DetailViewController : HHBaseViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

