//
//  NSObject+Util.h
//  HuanYouWang
//
//  Created by liuwenjie on 15/5/15.
//  Copyright (c) 2015年 cc.huanyouwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Util)

-(void)delay:(NSTimeInterval)timer task:(dispatch_block_t) task;

- (void)fastEncode:(NSCoder *)aCoder;
- (void)fastDecode:(NSCoder *)aDecoder;

@end