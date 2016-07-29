//
//  HHError.h
//  LoginAPI
//
//  Created by LWJ on 16/7/18.
//  Copyright © 2016年 gejianmin. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 请求错误code
 */
typedef NS_ENUM(NSInteger, HHErrorCode) {
    
    HHErrorCodeNotConnectedToInternet   = NSURLErrorNotConnectedToInternet,/*网络连接失败*/
    HHErrorCodeTimeout                  = NSURLErrorTimedOut,/*请求超时*/
    HHErrorCodeNetworkConnectionLost    = NSURLErrorNetworkConnectionLost,/*网络连接丢失*/
    HHErrorCodeCannotConnectToHost      = NSURLErrorCannotConnectToHost,/*不能连接到服务器*/
    
    
    HHErrorCodeSessionExpired = 0x003E9,/*token失效 会话过期*/
    HHErrorCodeOther          = 0x007D1/*其他参数错误/数据异常/操作不当等等 服务器提供的错误*/
};

@interface HHError : NSError
@property (nonatomic, strong) NSString *errorDescription;
+(instancetype)errorWithCode:(HHErrorCode)code description:(NSString *)description;
@end
