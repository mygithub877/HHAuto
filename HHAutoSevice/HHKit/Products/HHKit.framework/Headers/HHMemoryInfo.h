//
//  HHMemoryInfo.h
//  HHKit
//
//  Created by liuwenjie on 16/7/9.
//  Copyright © 2016年 hhauto. All rights reserved.



//  Description	: 系统内存信息：物理内存大小、剩余内存大小等


#import <Foundation/Foundation.h>

@interface HHMemoryInfo : NSObject
+ (unsigned long long)totalMemorySize;      ///< 物理内存大小
+ (unsigned long long)availableMemorySize;  ///< 当前可用内存

+ (NSString *)fileSizeToString:(unsigned long long)fileSize; ///< Size格式化, 例如：3.5M，512K

@end
