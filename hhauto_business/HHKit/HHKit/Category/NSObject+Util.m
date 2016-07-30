//
//  NSObject+Util.m
//  HuanYouWang
//
//  Created by liuwenjie on 15/5/15.
//  Copyright (c) 2015年 cc.huanyouwang. All rights reserved.
//

#import "NSObject+Util.h"
#import <objc/runtime.h>
@implementation NSObject (Util)

-(void)delay:(NSTimeInterval)timer task:(dispatch_block_t)task{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timer * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        task();                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
    });
}
- (void)fastEncode:(NSCoder *)aCoder{
    
    u_int count=0;
    objc_property_t *properties=class_copyPropertyList([self class], &count);
    for (int i=0; i<count; i++) {
        const char* pname=property_getName(properties[i]);
        NSString *key=[NSString stringWithUTF8String:pname];
        id value=[self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    free(properties);

}
-(void)fastDecode:(NSCoder *)aDecoder{
    u_int count=0;
    objc_property_t *properties=class_copyPropertyList([self class], &count);
    for (int i=0; i<count; i++) {
        const char* pname=property_getName(properties[i]);
        NSString *key=[NSString stringWithUTF8String:pname];
        id value=[aDecoder decodeObjectForKey:key];
        if (value) {
            [self setValue:value forKey:key];
        }
    }
    free(properties);
}
@end
