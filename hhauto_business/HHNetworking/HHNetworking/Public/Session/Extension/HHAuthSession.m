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
-(NSURLSessionDataTask *)asyncFetchShopTypeComplete:(HHSessionCompleteBlock)complete{
    return nil;
}
-(NSURLSessionDataTask *)asyncFetchShopServiceComplete:(HHSessionCompleteBlock)complete{
    return nil;
}
-(NSURLSessionDataTask *)asyncCreateShopWithParam:(HHCreateShopParam *)shopParam complete:(HHSessionCompleteBlock)complete{
    return nil;
}
@end
