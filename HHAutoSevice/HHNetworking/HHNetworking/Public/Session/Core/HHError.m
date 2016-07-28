//
//  HHError.m
//  LoginAPI
//
//  Created by LWJ on 16/7/18.
//  Copyright © 2016年 gejianmin. All rights reserved.
//

#import "HHError.h"

@implementation HHError
+(instancetype)errorWithCode:(HHErrorCode)code description:(NSString *)description{
    HHError *error=[[HHError alloc] initWithDomain:@"HHError" code:code userInfo:nil];
    error.errorDescription=description;
    return error;
}
-(NSString *)errorDescription{
    if (_errorDescription.length>0) {
        return _errorDescription;
    }
    if (self.code == HHErrorCodeNotConnectedToInternet) {
        return @"请检查网络";
    }else if (self.code == HHErrorCodeTimeout){
        return @"请求超时,请稍后再试";
    }else if (self.code == HHErrorCodeNetworkConnectionLost){
        return @"连接服务器失败";
    }else if (self.code == HHErrorCodeCannotConnectToHost){
        return @"服务器无响应";
    }else if (self.code == HHErrorCodeSessionExpired){
        return @"登录身份已过期，请重新登录";
    }
    else{
        return [NSString stringWithFormat:@"服务器异常(状态码:%ld)",(long)self.code];
    }

}
@end
