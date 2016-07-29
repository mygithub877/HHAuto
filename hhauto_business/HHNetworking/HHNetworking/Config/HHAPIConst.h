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

#define HH_AUTH_TOKEN @"HHAutoBusinessToken"

#define kAESKey @"8F7396637BC9327B854344675DAEEC60"

#define RESPONSE_SUCCESS_CODE 200



static NSTimeInterval const kRequestTimeOut=30.f;

////////////////////////////////////////////////////////////

//MARK:上传图片
static NSString *const kBusinessUploadImagePath=@"";


//MARK:登陆,注册,忘记密码修改等
static NSString *const kBusinessLoginPath=@"";//登陆
static NSString *const kBusinessLogOffPath=@"";//退出登录
static NSString *const kBusinessRegisterPath=@"";//注册
static NSString *const kBusinessLostPwdPath=@"";//忘记密码
static NSString *const kBusinessUpdatePwdPath=@"";//修改密码
static NSString *const kBusinessVerifyCodePath=@"";//获取验证码
static NSString *const kBusinessVerifyHasPhonePath=@"";//验证手机号是否已经注册


//MARK:店铺
static NSString *const kBusinessSubmitShopInfoPath=@"";//提交商铺信息
static NSString *const kBusinessShopTypePath=@"";//获取商铺类型
static NSString *const kBusinessShopServicePath=@"";//商铺的服务范围


//MARK:消息
static NSString *const kBusinessMsgListPath=@"";//消息列表
static NSString *const kBusinessUpdateMsgStatePath=@"";//更新消息状态
static NSString *const kBusinessDeleteMsgPath=@"";//删除消息
static NSString *const kBusinessOnlineMsgboardPath=@"";//在线留言

//MARK:订单,预约
static NSString *const kBusinessOrderListPath=@"";//订单、预约列表
static NSString *const kBusinessOrderDetailPath=@"";//订单、预约详情



//MARK:商品
static NSString *const kBusinessProductListPath=@"";//商品列表
static NSString *const kBusinessProductDetailPath=@"";//商品详情

//MARK:结算
static NSString *const kBusinessSettlementAmountPath=@"";//结算、未结算金额
static NSString *const kBusinessBankCardListPath=@"";//绑定银行卡列表
static NSString *const kBusinessBankListPath=@"";//合作银行列表
static NSString *const kBusinessBindBankCardPath=@"";//绑定银行卡

#endif /* HHAPIConst_h */
