//
//  HHCPUUsage.h
//  HHKit
//
//  Created by liuwenjie on 16/7/9.
//  Copyright © 2016年 hhauto. All rights reserved.

// * Description  : 获取Cpu使用率

#import <Foundation/Foundation.h>
@interface HHCPUUsage : NSObject
+ (HHCPUUsage *)sharedInstance;

//返回0--1之间的值  获取当前进程的CPU利用率
- (float)currentProccessCPUUsage;

//返回0--1之间的值  获取当前机器的CPU利用率
- (float)totalCPUUsage;

//返回CPU核心数
- (NSUInteger)CPUCores;
@end
