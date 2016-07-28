//
//  HHClient.m
//  HHNetworking
//
//  Created by LWJ on 16/7/11.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import "HHClient.h"
#import "HHInterface.h"

@implementation HHClient
@synthesize authSession=_authSession;
@synthesize orderSession=_orderSession;
@synthesize shopSession=_shopSession;
@synthesize productSession=_productSession;
@synthesize messageSession=_messageSession;

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
        _commonParams=@{@"clientVersion":@"1.0.0",
                        @"digest":@"72d2da7c6888dc9503257d92a2d1275d",
                        @"t":@"1468909318.643185",
                        @"schemeId":@"2",
                        @"apiVersion":@"1.0.0",
                        @"token":@"357b5b64e16bb7e1a6dba10f721def2b",
                        @"clientSource":@"iPhone"};
    }
    return self;
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
@end
