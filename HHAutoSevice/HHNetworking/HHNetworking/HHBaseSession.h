//
//  HHBaseSession.h
//  HHNetworking
//
//  Created by LWJ on 16/7/11.
//  Copyright © 2016年 HHAuto. All rights reserved.

//  基础会话请求

#import <Foundation/Foundation.h>
@class HHFile;
@class HHError;

/**
 完成请求回调block
 */
typedef void (^HHSessionCompleteBlock)(id response,HHError *error);

/**
 请求错误code
 */
typedef NS_ENUM(NSInteger, HHErrorCode) {
    
    HHErrorCodeNotConnectedToInternet   = NSURLErrorNotConnectedToInternet,
    HHErrorCodeTimeout                  = NSURLErrorTimedOut,
    HHErrorCodeNetworkConnectionLost    = NSURLErrorNetworkConnectionLost,
    HHErrorCodeCannotConnectToHost      = NSURLErrorCannotConnectToHost,
    
    
    HHErrorCodeSessionExpired = 0x003E9,
    HHErrorCodeOther          = 0x007D1
};

@interface HHBaseSession : NSObject
/*!
 *  @method GET
 *  @params 
            url:请求全路径
            params:参数字典 
            complete:回调
 
 *  @return NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)GET:(NSString *)url params:(NSDictionary *)dict complete:(HHSessionCompleteBlock)complt;
/*!
 *  @method POST
 *  @params
            url:请求全路径
            params:参数字典
            complete:回调
 
 *  @return NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)POST:(NSString *)url params:(NSDictionary *)dict complete:(HHSessionCompleteBlock)complt;

/*!
 *  @method JSON
 *  @params
            url:请求全路径
            params:参数字典
            complete:回调
 
 *  @return NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)JSON:(NSString *)url params:(NSDictionary *)dict complete:(HHSessionCompleteBlock)complt;

@end
