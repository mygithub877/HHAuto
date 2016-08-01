//
//  HHSQLiteCache.m
//  HHKit
//
//  Created by liuwenjie on 16/7/31.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import "HHSQLiteCache.h"
#import <time.h>
#if __has_include(<sqlite3.h>)
    #import <sqlite3.h>
#else
    #import "sqlite3.h"
#endif
#if  DEBUG
#define DBLOG(id, ...) NSLog((@"%s [Line %d] " id),__PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DBLOG(id, ...)
#endif

#define HH_CACHE_SQL_TABLE_NAME     @"t_hhauto_cache"
#define HH_CACHE_SQL_FIELD_KEY      @"cache_key"
#define HH_CACHE_SQL_FIELD_SIZE     @"cache_size"
#define HH_CACHE_SQL_FIELD_DATA     @"cache_data"
#define HH_CACHE_SQL_FIELD_TIME     @"modification_time"





@interface HHSQLiteCache()
{
    sqlite3 *_db;
    CFMutableDictionaryRef _dbStmtCache;
    dispatch_queue_t _dbQueue;


}
@end

@implementation HHSQLiteCache
/**
 *  初始化方法,需要自定义数据库路径
 */
- (instancetype)initWithPath:(NSString *)path{
    if (self=[super init]) {
        _path=path;
        [self _initilizeDataBase];
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
    NSString *path = [cacheFolder stringByAppendingPathComponent:dbName];
    return [self initWithPath:path];
}

/**
 *  保存或替换二进制数据对象
 */
- (BOOL)saveData:(NSData *)data forKey:(NSString *)key{
    return [self _dbInsertData:data modifyTime:[[NSDate date] timeIntervalSince1970] forKey:key];
}
/**
 *  获取二进制数据对象
 */
- (NSData *)dataForKey:(NSString *)key{
    return [self _queryDataForKey:key];
}
/**
 *  移除二进制数据对象
 */
- (BOOL)removeDataForKey:(NSString *)key{
    return [self _dbDeleteDataForKey:key];
}
/**
 *  移除所有二进制数据对象
 */
- (BOOL)removeAllData{
    return [self _dbDeleteAllData];
}
#pragma mark - SQLite
- (void)_initilizeDataBase{
    
    NSString *sql=[NSString stringWithFormat:@"create table if not exists %@(%@ text,%@ integer,%@ blob, %@ integer,primary key(%@))",HH_CACHE_SQL_TABLE_NAME,HH_CACHE_SQL_FIELD_KEY,HH_CACHE_SQL_FIELD_SIZE,HH_CACHE_SQL_FIELD_DATA,HH_CACHE_SQL_FIELD_TIME,HH_CACHE_SQL_FIELD_KEY];
    [self _dbOpen];

    [self _dbExecute:sql];

}
- (BOOL)_dbOpen {
    if (_db) return YES;
    int result = sqlite3_open(_path.UTF8String, &_db);
    if (result == SQLITE_OK) {
        CFDictionaryKeyCallBacks keyCallbacks = kCFCopyStringDictionaryKeyCallBacks;
        CFDictionaryValueCallBacks valueCallbacks = {0};
        _dbStmtCache = CFDictionaryCreateMutable(CFAllocatorGetDefault(), 0, &keyCallbacks, &valueCallbacks);
        DBLOG(@"SQLite database path:%@",_path);
        return YES;
    }else{
        _db = NULL;
        if (_dbStmtCache) CFRelease(_dbStmtCache);
        _dbStmtCache = NULL;
        return NO;
    }
}
- (BOOL)_dbClose {
    if (!_db) return YES;
    int  result = 0;
    BOOL retry = NO;
    BOOL stmtFinalized = NO;
    if (_dbStmtCache) CFRelease(_dbStmtCache);
    _dbStmtCache = NULL;

    do {
        retry = NO;
        result = sqlite3_close(_db);
        if (result == SQLITE_BUSY || result == SQLITE_LOCKED) {
            if (!stmtFinalized) {
                stmtFinalized = YES;
                sqlite3_stmt *stmt;
                while ((stmt = sqlite3_next_stmt(_db, nil)) != 0) {
                    sqlite3_finalize(stmt);
                    retry = YES;
                }
            }
        } else if (result != SQLITE_OK) {
            DBLOG(@"sqlite exec error (%d): %s", result, sqlite3_errmsg(_db));
        }
    } while (retry);
    _db = NULL;
    return YES;

}
- (BOOL)_dbExecute:(NSString *)sql {
    if (sql.length == 0) return NO;
//    if (![self _dbCheck]) return NO;
    
    char *error = NULL;
    int result = sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &error);
    if (error) {
        DBLOG(@"sqlite exec error (%d): %s", result, error);
        sqlite3_free(error);
    }
    
    return result == SQLITE_OK;
}
- (sqlite3_stmt *)_dbPrepareStmt:(NSString *)sql {
    if (!_db || sql.length == 0 || !_dbStmtCache) return NULL;
    sqlite3_stmt *stmt = (sqlite3_stmt *)CFDictionaryGetValue(_dbStmtCache, (__bridge const void *)(sql));
    if (!stmt) {
        int result = sqlite3_prepare_v2(_db, sql.UTF8String, -1, &stmt, NULL);
        if (result != SQLITE_OK) {
            DBLOG(@"sqlite stmt prepare error (%d): %s", result, sqlite3_errmsg(_db));
            return NULL;
        }
        CFDictionarySetValue(_dbStmtCache, (__bridge const void *)(sql), stmt);
    } else {
        sqlite3_reset(stmt);
    }
    return stmt;
}

- (BOOL)_dbInsertData:(NSData *)data modifyTime:(NSInteger)timestamp forKey:(NSString *)key{
    NSString *sql=[NSString stringWithFormat:@"insert or replace into %@(%@,%@,%@,%@) values(?1,?2,?3,?4)",HH_CACHE_SQL_TABLE_NAME,HH_CACHE_SQL_FIELD_KEY,HH_CACHE_SQL_FIELD_SIZE,HH_CACHE_SQL_FIELD_DATA,HH_CACHE_SQL_FIELD_TIME];
    sqlite3_stmt *stmt=[self _dbPrepareStmt:sql];
    if (!stmt) return NO;
    sqlite3_bind_text(stmt, 1, key.UTF8String, -1, NULL);
    sqlite3_bind_int(stmt, 2, (int)data.length);
    sqlite3_bind_blob(stmt, 3, data.bytes, (int)data.length, 0);
    sqlite3_bind_int64(stmt, 4, timestamp);
    int result = sqlite3_step(stmt);
    if (result != SQLITE_DONE) {
        DBLOG(@"sqlite insert error (%d): %s", result, sqlite3_errmsg(_db));
        return NO;
    }else{
        DBLOG(@"sqlite insert success (%d): %@", result,sql);

    }
    return YES;
}
- (BOOL)_dbDeleteDataForKey:(NSString *)key{
    NSString *sql = [NSString stringWithFormat:@"delete from %@ where %@ = ?1",HH_CACHE_SQL_TABLE_NAME,HH_CACHE_SQL_FIELD_KEY];
    sqlite3_stmt *stmt = [self _dbPrepareStmt:sql];
    if (!stmt) return NO;
    sqlite3_bind_text(stmt, 1, key.UTF8String, -1, NULL);
    
    int result = sqlite3_step(stmt);
    if (result != SQLITE_DONE) {
        DBLOG(@"sqlite delete error (%d): %s", result, sqlite3_errmsg(_db));
        return NO;
    }
    return YES;
}
- (BOOL)_dbDeleteAllData{
    NSString *sql = [NSString stringWithFormat:@"delete from %@ ",HH_CACHE_SQL_TABLE_NAME];
    sqlite3_stmt *stmt = [self _dbPrepareStmt:sql];
    if (!stmt) return NO;    
    int result = sqlite3_step(stmt);
    if (result != SQLITE_DONE) {
        DBLOG(@"sqlite delete error (%d): %s", result, sqlite3_errmsg(_db));
        return NO;
    }
    return YES;

}

- (NSData *)_queryDataForKey:(NSString *)key{
    NSString *sql = [NSString stringWithFormat:@"select %@ from %@ where %@ = ?1",HH_CACHE_SQL_FIELD_DATA,HH_CACHE_SQL_TABLE_NAME,HH_CACHE_SQL_FIELD_KEY];
    sqlite3_stmt *stmt = [self _dbPrepareStmt:sql];
    if (!stmt) return nil;
    sqlite3_bind_text(stmt, 1, key.UTF8String, -1, NULL);
    
    int result = sqlite3_step(stmt);
    if (result == SQLITE_ROW) {
        const void *inline_data = sqlite3_column_blob(stmt, 0);
        int inline_data_bytes = sqlite3_column_bytes(stmt, 0);
        if (!inline_data || inline_data_bytes <= 0) return nil;
        return [NSData dataWithBytes:inline_data length:inline_data_bytes];
    } else {
        if (result != SQLITE_DONE) {
            DBLOG(@"sqlite query error (%d): %s", result, sqlite3_errmsg(_db));

        }
        return nil;
    }

}
-(void)dealloc{
    [self _dbClose];
}
@end
