//
//  HHAuthSession.m
//  HHNetworking
//
//  Created by liuwenjie on 16/7/28.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import "HHInterface.h"
NSString *const kLoginFinishNotification=@"kLoginFinishNotification";

@implementation HHAuthSession
-(NSURLSessionDataTask *)asyncLoginWithPhone:(NSString *)phone password:(NSString *)pwd complete:(HHSessionCompleteBlock)complete{
    NSString *url=[self urlWithPath:kBusinessLoginPath];
    NSURLSessionDataTask *task=[self POST:url params:@{@"phone":phone,@"pwd":pwd} complete:^(id response, HHError *error) {
        if (response && HH_RESPONSE_CODE == RESPONSE_SUCCESS_CODE) {
            id result=HH_RESPONSE_DATA;
            HHUser *user=[HHUser mj_objectWithKeyValues:result];
            if (complete) {
                complete(user,nil);
            }
            
        }else{
            if (error==nil) {
                error=[HHError errorWithCode:HHErrorCodeOther description:HH_RESPONSE_ERROR];
            }
            if (complete) {
                complete(nil,error);
            }
        }
    }];
    return nil;
}
-(NSURLSessionDataTask *)asyncLogOffWithComplete:(HHSessionCompleteBlock)complete{
    return nil;
}
-(NSURLSessionDataTask *)asyncRegisterWithPhone:(NSString *)phone verifyCode:(NSString *)code password:(NSString *)pwd complete:(HHSessionCompleteBlock)complete{
    return nil;
}
-(NSURLSessionDataTask *)asyncFetchVerifyCodeWithPhone:(NSString *)phone type:(HHVerifyCodeType)type complete:(HHSessionCompleteBlock)complete{
    return nil;
}
-(NSURLSessionDataTask *)asyncVerifyHasPhone:(NSString *)phone complete:(HHSessionCompleteBlock)complete{
    return nil;
}
@end
