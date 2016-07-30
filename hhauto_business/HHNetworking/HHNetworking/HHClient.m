//
//  HHClient.m
//  HHNetworking
//
//  Created by LWJ on 16/7/11.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import "HHClient.h"
#import "HHInterface.h"

static NSString *const HHUserCacheKey = @"HHUserCacheKey";

@implementation HHClient

@synthesize authSession=_authSession;
@synthesize orderSession=_orderSession;
@synthesize shopSession=_shopSession;
@synthesize productSession=_productSession;
@synthesize messageSession=_messageSession;
@synthesize settlementSession=_settlementSession;


@synthesize commonParams=_commonParams;
@synthesize token=_token;
@synthesize user=_user;

+ (instancetype)sharedInstance{
    static HHClient *instance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance=[[HHClient alloc] init];
        
    });
    return instance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginFinish:) name:kLoginFinishNotification object:nil];
        _baseURL=kDefaultBaseURLString;
    }
    return self;
}
- (void)setToken:(NSString *)token{
    _token=token;
    NSMutableDictionary *params=[self mutalbaleCommonParams];
    params[@"token"]=token;
    _commonParams=[params copy];
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:HH_AUTH_TOKEN];
}
- (void)loginFinish:(NSNotification *)notification{
    HHUser *user=notification.object;
    _user=user;
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:user];
    [[NSUserDefaults standardUserDefaults]setObject:data forKey:HHUserCacheKey];
}
- (NSString *)token{
    if (_token==nil) {
        _token=[[NSUserDefaults standardUserDefaults]objectForKey:HH_AUTH_TOKEN];
    }
    return _token;
}
- (HHUser *)user{
    if (_user==nil) {
        NSData *data=[[NSUserDefaults standardUserDefaults]objectForKey:HHUserCacheKey];
        _user=[NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return _user;
}

- (NSMutableDictionary *)mutalbaleCommonParams{
    NSMutableDictionary *tempParams=[NSMutableDictionary dictionary];
    tempParams[@"clientSource"]=@"iOS";
    tempParams[@"clientVersion"]=[NSString appVersion];
    tempParams[@"token"]=self.token;
    tempParams[@"digest"]=[self signMD5];
    return tempParams;
}

- (NSDictionary *)commonParams{
    if (_commonParams==nil) {
        
        _commonParams=[[self mutalbaleCommonParams] copy];
    }
    return _commonParams;
}
-(NSString *)signMD5{
    
    NSString *str=[NSString stringWithFormat:@"%@%@",@"iOS",@"2.3"];
    if (self.token) {
        return [[str stringByAppendingString:self.token] md5String];
    }
    return [str md5String];
}
/////////////////////////////////////
-(id<HHAuthSession>)authSession{
    if (_authSession==nil) {
        _authSession=[[HHAuthSession alloc] init];
    }
    return _authSession;
}
-(id<HHOrderSession>)orderSession{
    if (_orderSession==nil) {
        _orderSession=[[HHOrderSession alloc] init];
    }
    return _orderSession;
}
-(id<HHShopSession>)shopSession{
    if (_shopSession==nil) {
        _shopSession=[[HHShopSession alloc] init];
    }
    return _shopSession;
}
-(id<HHProductSession>)productSession{
    if (_productSession==nil) {
        _productSession=[[HHProductSession alloc] init];
    }
    return _productSession;
}
- (id<HHMessageSession>)messageSession{
    if (_messageSession==nil) {
        _messageSession=[[HHMessageSession alloc] init];
    }
    return _messageSession;
}
- (id<HHSettlementSession>)settlementSession{
    if (_settlementSession==nil){
        _settlementSession=[[HHSettlementSession alloc] init];
    }
    return _settlementSession;
}
@end
