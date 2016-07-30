//
//  HHUser.m
//  HHNetworking
//
//  Created by LWJ on 16/7/11.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import "HHUser.h"
#import <objc/runtime.h>
@implementation HHUser
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
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
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
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
@end
