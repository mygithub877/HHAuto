//
//  HHUser.h
//  HHNetworking
//
//  Created by LWJ on 16/7/11.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHUser : NSObject <NSCoding>
@property (nonatomic, strong) NSNumber *uid;
@property (nonatomic, strong) NSString *phone;

@end
