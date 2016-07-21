//
//  HHClient.m
//  HHNetworking
//
//  Created by LWJ on 16/7/11.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import "HHClient.h"
#import "HHAPIConst.h"
@implementation HHClient
+ (instancetype)sharedInstance{
    static HHClient *instance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance=[[HHClient alloc] init];
    });
    return instance;
}
-(NSString *)urlWithPath:(NSString *)path{
    if (self.baseURL==nil || path==nil) {
        FMWLog(@"主机域名或路径不能为空");
        return nil;
    }
    return [NSString stringWithFormat:@"%@/%@",self.baseURL,path];
}
@end
