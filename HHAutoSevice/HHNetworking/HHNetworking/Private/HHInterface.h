//
//  HHInterface.h
//  HHNetworking
//
//  Created by LWJ on 16/7/11.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#ifndef HHInterface_h
#define HHInterface_h
#import "HHNetworking.h"
#import "HHAPIConst.h"
#import "HHServerConfig.h"

@interface HHAuthSession : HHBaseSession <HHAuthSession>

@end
@interface HHShopSession : HHBaseSession <HHShopSession>

@end
@interface HHOrderSession : HHBaseSession <HHOrderSession>

@end
@interface HHProductSession : HHBaseSession <HHProductSession>

@end
@interface HHMessageSession : HHBaseSession <HHMessageSession>

@end

#endif /* HHInterface_h */
