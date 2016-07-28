//
//  DetailViewController.m
//  HHAutoSevice
//
//  Created by LWJ on 16/7/11.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
<<<<<<< HEAD
//    [self showAlertTitle:@"title" message:@"message" handle:^(NSInteger index) {
//        NSLog(@"%ld",index);
//    } cancle:@"aaa" others:@"eeeee",@"aaaa",@"vvvvvv", nil];
    HHLocation *location=[HHLocationManager sharedInstance].locationCache;
    [[HHLocationManager sharedInstance] startLocationReverseGeocode:YES complete:^(HHLocation *location, HHLocationStatus resultState) {
        [self showAlertMessage:location.address handle:^(NSInteger index) {
            NSLog(@"%ld",index);
        }];
    }];

=======
    [[HHLocationManager sharedInstance] startLocationReverseGeocode:YES complete:^(HHLocation *location, HHLocationStatus resultState) {
//        [self showAlertMessage:location.address handle:^(NSInteger index) {
//            NSLog(@"%ld",index);
//        }];
    }];
>>>>>>> origin/master
    
//    [[HHLocationManager sharedInstance] geocodeAddressString:@"天安门" completionHandler:^(HHLocation *location, HHLocationStatus resultState) {
//        
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
