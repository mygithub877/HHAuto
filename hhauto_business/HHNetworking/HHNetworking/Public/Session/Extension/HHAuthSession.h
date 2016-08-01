//
//  HHAuthSession.h
//  HHNetworking
//
//  Created by liuwenjie on 16/7/28.
//  Copyright © 2016年 HHAuto. All rights reserved.
//
//  登陆,注册,找回密码,修改密码
//  个人资料修改等等有关身份认证信息之类的请求管理

typedef NS_ENUM(NSInteger,HHVerifyCodeType){
    HHVerifyCodeTypeRegister,
    HHVerifyCodeTypeLostPwd,
};

extern  NSString *const   kLoginFinishNotification;

@class HHCreateShopParam;

@protocol HHAuthSession <NSObject>
/*! @method 用户登录
 *  @phone  手机号
 *  @pwd    密码
 *  @reponse HHUser
 */
- (NSURLSessionDataTask *)asyncLoginWithPhone:(NSString *)phone
                                    password:(NSString *)pwd
                                    complete:(HHSessionCompleteBlock)complete;
/*! @method 用户退出登录
 *  @reponse @(YES/NO) 
 */
- (NSURLSessionDataTask *)asyncLogOffWithComplete:(HHSessionCompleteBlock)complete;

/*! @method 用户注册
 *  @phone  手机号
 *  @pwd    密码
 *  @code   验证码
 *  @reponse HHUser
 */
- (NSURLSessionDataTask *)asyncRegisterWithPhone:(NSString *)phone
                                      verifyCode:(NSString *)code
                                        password:(NSString *)pwd
                                        complete:(HHSessionCompleteBlock)complete;
/*! @method 获取验证码
 *  @phone  手机号
 *  @type   验证码类型
 *  @reponse @(YES/NO) HHError
 */
- (NSURLSessionDataTask *)asyncFetchVerifyCodeWithPhone:(NSString *)phone
                                                   type:(HHVerifyCodeType)type
                                               complete:(HHSessionCompleteBlock)complete;
/*! @method 验证手机是否已经注册
 *  @phone  手机号
 *  @reponse @(YES/NO) HHError
 */
- (NSURLSessionDataTask *)asyncVerifyHasPhone:(NSString *)phone complete:(HHSessionCompleteBlock)complete;


@end
#pragma mark - 请求参数
#pragma mark 创建店铺参数
@interface HHCreateShopParam : NSObject
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, strong) HHShopType *shopType;
@property (nonatomic, strong) HHShopService *shopService;
@property (nonatomic, strong) NSString *startBusinessTime;
@property (nonatomic, strong) NSString *endBusinessTime;
@property (nonatomic, strong) NSString *shopAddress;
@property (nonatomic, strong) NSString *shopDescription;
@property (nonatomic, strong) NSArray <NSString *> *shopImagePaths;
@property (nonatomic, assign) double shopLon;
@property (nonatomic, assign) double shopLat;

@end
