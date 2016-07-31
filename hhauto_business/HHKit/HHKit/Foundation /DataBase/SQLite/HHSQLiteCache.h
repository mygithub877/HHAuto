//
//  HHSQLiteCache.h
//  HHKit
//
//  Created by liuwenjie on 16/7/31.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHSQLiteCache : NSObject
@property (nonatomic, readonly) NSString *path;        ///< 数据库路径.

/**
 *  初始化方法,无效
 */
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;
/**
 *  初始化方法,需要自定义数据库路径
 */
- (instancetype)initWithPath:(NSString *)path;
/**
 *  初始化方法,只需传入数据库文件名
 *  默认在沙盒路径下cache文件夹目录下
 *  该目录在设备内存紧张情况下会被操作系统自动清空,如果需要随应用程序长久保存则不建议使用
 */
- (instancetype)initWithDBName:(NSString *)dbName;
/**
 *  保存或替换二进制数据对象
 */
- (BOOL)saveData:(NSData *) forKey:(NSString *)key;
/**
 *  获取二进制数据对象
 */
- (NSData)dataForKey:(NSString *)key;
/**
 *  移除二进制数据对象
 */
- (BOOL)removeDataForKey:(NSString *)key;
/**
 *  移除所有二进制数据对象
 */
- (BOOL)removeAllData;
@end
