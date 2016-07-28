//
//  HHAPIConst.h
//  HHNetworking
//
//  Created by LWJ on 16/7/11.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#ifndef HHAPIConst_h
#define HHAPIConst_h

#if DEBUG

#   define FMWLog(id, ...) NSLog((@"%s [Line %d] " id),__PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else

#   define FMWLog(id, ...)

#endif

#define HH_RESPONSE_CODE [response[@""] integerValue]

#define HH_RESPONSE_DATA response[@""]

#define HH_RESPONSE_ERROR response[@""][@""]

#define HH_AUTH_TOKEN @"token"

#define RESPONSE_SUCCESS_CODE 200



NSTimeInterval const kRequestTimeOut=30.f;

////////////////////////////////////////////////////////////

//MARK:上传图片
static NSString *const kBusinessUploadImagePath=@"";

static NSString *const kBusinessPath=@"";

//MARK:登陆,注册,忘记密码修改等
static NSString *const kBusinessLoginPath=@"";//登陆
static NSString *const kBusinessRegisterPath=@"";//注册
static NSString *const kBusinessLostPwdPath=@"";//忘记密码
static NSString *const kBusinessUpdatePwdPath=@"";//修改密码


//MARK:店铺
static NSString *const kBusinessSubmitShopInfoPath=@"";//提交商铺信息
static NSString *const kBusinessShopTypePath=@"";//获取商铺类型
static NSString *const kBusinessShopServicePath=@"";//商铺的服务范围


//MARK:消息
static NSString *const kBusinessMsgListPath=@"";//消息列表
static NSString *const kBusinessUpdateMsgStatePath=@"";//更新消息状态
static NSString *const kBusinessDeleteMsgPath=@"";//删除消息

//MARK:订单,预约
static NSString *const kBusinessOrderListPath=@"";//订单列表
static NSString *const kBusinessOrderDetailPath=@"";//订单详情



//MARK:商品
static NSString *const kBusinessProductListPath=@"";//商品列表
static NSString *const kBusinessProductDetailPath=@"";//商品详情

#endif /* HHAPIConst_h */
