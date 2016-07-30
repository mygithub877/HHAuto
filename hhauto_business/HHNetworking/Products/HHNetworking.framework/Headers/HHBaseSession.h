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

@interface HHBaseSession : NSObject

@property (nonatomic, assign) NSTimeInterval  timeoutInterval;
- (NSString *)urlWithPath:(NSString *)path;//通过此方法来转换最终URL

- (void)testEncriypt;
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
/*!
 *  @method JSON
 *  @params
 *      url:请求全路径
 *      params:参数字典
 *      complete:回调
 *
 *  @return NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)FILE:(NSString *)url params:(NSDictionary *)dict files:(NSArray <HHFile *> *)files  complete:(HHSessionCompleteBlock)complt;

/*!
 *  @method 文件下载
 *  @params
        url:请求全路径
        complete:回调
        progress:进度
 *  @return NSURLSessionDataTask
 */

- (NSURLSessionDownloadTask *)download:(NSString *)url complete:(HHSessionCompleteBlock)complt progress:(void(^)(float progress,long long totalBytes))progress;

/*!
 取消所有请求
 */
-(void)cancleAllRequest;

@end
