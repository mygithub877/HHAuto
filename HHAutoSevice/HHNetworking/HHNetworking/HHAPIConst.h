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

#endif /* HHAPIConst_h */
