//
//  HHClient.h
//  HHNetworking
//
//  Created by LWJ on 16/7/11.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HHUser;

@protocol HHAuthSession;
@protocol HHShopSession;
@protocol HHOrderSession;
@protocol HHProductSession;

@interface HHClient : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, copy) NSString *baseURL;//根域名

@property (nonatomic, copy) NSDictionary *commonParams;//公共参数

@property (nonatomic, strong, readonly) HHUser *user;//当前登录用户
@property (nonatomic, strong, readonly) id<HHAuthSession>authSession;
@property (nonatomic, strong, readonly) id<HHShopSession>shopSession;
@property (nonatomic, strong, readonly) id<HHOrderSession> orderSession;
@property (nonatomic, strong, readonly) id<HHProductSession>productSession;


@end
