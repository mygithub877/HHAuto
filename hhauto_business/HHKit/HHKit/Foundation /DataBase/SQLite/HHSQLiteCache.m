//
//  HHSQLiteCache.m
//  HHKit
//
//  Created by liuwenjie on 16/7/31.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import "HHSQLiteCache.h"

#if __has_include(<sqlite3.h>)
    #import <sqlite3.h>
#else
    #import "sqlite3.h"
#endif

@interface HHSQLiteCache()
{
    sqlite3 *_db;

}
@end

@implementation HHSQLiteCache
/**
 *  初始化方法,需要自定义数据库路径
 */
- (instancetype)initWithPath:(NSString *)path{
    if (self=[super init]) {
        _path=path;
    }
    return self;
}
/**
 *  初始化方法,只需传入数据库文件名
 *  默认在沙盒路径下cache文件夹目录下
 *  该目录在设备内存紧张情况下会被操作系统自动清空,如果需要随应用程序长久保存则不建议使用
 */
- (instancetype)initWithDBName:(NSString *)dbName{
    NSString *cacheFolder = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *path = [cacheFolder stringByAppendingPathComponent:name];
    return [self initWithPath:path];
}

/**
 *  保存或替换二进制数据对象
 */
- (BOOL)saveData:(NSData *) forKey:(NSString *)key{
    return NO;
}
/**
 *  获取二进制数据对象
 */
- (NSData)dataForKey:(NSString *)key{
    return nil;
}
/**
 *  移除二进制数据对象
 */
- (BOOL)removeDataForKey:(NSString *)key{
    return NO;
}
/**
 *  移除所有二进制数据对象
 */
- (BOOL)removeAllData{
    return NO;
}
#pragma mark - SQLite
- (void)_initilizeDataBase{
    
}
- (BOOL)_dbOpen {

}
- (BOOL)_dbClose {

}
- (BOOL)_dbExecute:(NSString *)sql {
}
@end
