//
//  HHShopSession.h
//  HHNetworking
//
//  Created by liuwenjie on 16/7/28.
//  Copyright © 2016年 HHAuto. All rights reserved.
//
//  商铺等有关信息请求管理


@protocol HHShopSession <NSObject>

/*! @method 获取店铺类目
 *  @reponse NSArray <HHShopType *>
 */
- (NSURLSessionDataTask *)asyncFetchShopTypeComplete:(HHSessionCompleteBlock)complete;

/*! @method 获取店铺服务范围
 *  @reponse NSArray <HHShopService *>
 */
- (NSURLSessionDataTask *)asyncFetchShopServiceComplete:(HHSessionCompleteBlock)complete;

/*! @method 创建店铺
 *  @shopParam HHCreateShopParam
 *  @reponse @(YES/NO)
 */
- (NSURLSessionDataTask *)asyncCreateShopWithParam:(HHCreateShopParam *)shopParam complete:(HHSessionCompleteBlock)complete;


@end