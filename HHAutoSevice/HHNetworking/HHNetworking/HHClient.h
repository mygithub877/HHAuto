//
//  HHClient.h
//  HHNetworking
//
//  Created by LWJ on 16/7/11.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HHUser;

@interface HHClient : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, copy) NSString *baseURL;//根域名

@property (nonatomic, copy) NSDictionary *commonParams;//公共参数

@property (nonatomic, strong, readonly) HHUser *currentUser;//当前登录用户

- (NSString *)urlWithPath:(NSString *)path;//通过此方法来转换最终URL


@end
