//
//  Header.h
//  HHKit
//
//  Created by liuwenjie on 16/7/19.
//  Copyright © 2016年 hhauto. All rights reserved.
//

#ifndef PrivateHeader_h
#define PrivateHeader_h

#if  DEBUG
#define FMKLOG(id, ...) NSLog((@"%s [Line %d] " id),__PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define FMKLOG(id, ...)
#endif

#define kFastEncode(aCoder)  u_int count=0;\
    objc_property_t *properties=class_copyPropertyList([self class], &count);\
    for (int i=0; i<count; i++) {\
        const char* pname=property_getName(properties[i]);\
        NSString *key=[NSString stringWithUTF8String:pname];\
        id value=[self valueForKey:key];\
        [aCoder encodeObject:value forKey:key];\
    }\
    free(properties);

#define kFastDecoder(aDecoder)  u_int count=0;\
    objc_property_t *properties=class_copyPropertyList([self class], &count);\
    for (int i=0; i<count; i++) {\
        const char* pname=property_getName(properties[i]);\
        NSString *key=[NSString stringWithUTF8String:pname];\
        id value=[aDecoder decodeObjectForKey:key];\
        if (value) {\
            [self setValue:value forKey:key];\
        }\
    }\
    free(properties);




#import <objc/runtime.h>


#import "MBProgressHUD.h"

#pragma mark - foundation
#import "HHSystemInfo.h"
#import "HHCPUUsage.h"
#import "HHMemoryInfo.h"

#pragma mark - UIKit
#import "HHBlurView.h"
#import "HHAlertView.h"
#endif /* Header_h */
