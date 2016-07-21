//
//  HHMemoryInfo.m
//  HHKit
//
//  Created by liuwenjie on 16/7/9.
//  Copyright © 2016年 hhauto. All rights reserved.
//

#import "HHMemoryInfo.h"
#import <mach/vm_page_size.h>
#import <mach/mach_init.h>
#import <mach/mach_host.h>
@implementation HHMemoryInfo
+ (unsigned long long)totalMemorySize; ///< 物理内存大小
{
    return [NSProcessInfo processInfo].physicalMemory;
}

+ (unsigned long long)availableMemorySize;  ///< 当前可用内存
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if (kernReturn != KERN_SUCCESS)
    {
        return NSNotFound;
    }
    
    return (unsigned long long)vm_page_size * vmStats.free_count + (unsigned long long)vm_page_size * vmStats.inactive_count;
}

+ (NSString *)fileSizeToString:(unsigned long long)fileSize; ///< Size格式化, 例如：3.5M，512K
{
    NSInteger KB = 1024;
    NSInteger MB = KB*KB;
    NSInteger GB = MB*KB;
    
    NSString * text = @"";
    if (fileSize < 10)
    {
        text = @"0 B";
        
    }
    else if (fileSize < KB)
    {
        text = @"< 1 KB";
        
    }
    else if (fileSize < MB)
    {
        text = [NSString stringWithFormat:@"%.1f KB",((float)fileSize)/KB];
        
    }
    else if (fileSize < GB)
    {
        text = [NSString stringWithFormat:@"%.1f MB",((float)fileSize)/MB];
        
    }
    else
    {
        text = [NSString stringWithFormat:@"%.1f GB",((float)fileSize)/GB];
    }
    
    return text;
}

@end
