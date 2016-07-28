//
//  HHFile.h
//  HHNetworking
//
//  Created by LWJ on 16/7/11.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHFile : NSObject
@property (nonatomic, strong) NSData *data;
@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, strong) NSString *mimeType;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *key;
@end
