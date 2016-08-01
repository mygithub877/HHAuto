//
//  HHCache.m
//  HHKit
//
//  Created by liuwenjie on 16/7/31.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import "HHCache.h"


#define HH_CACHE_DB_FILE_NAME @"com.hhauto.cache.sqlite"

@interface HHCache()
@property (nonatomic, strong) NSMutableDictionary *memoryCache;
@end
@implementation HHCache

+ (instancetype)sharedInstance{
    static HHCache *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance=[[HHCache alloc] init];
    });
    return instance;
}
#pragma mark - getter
- (NSString *)path{
    if (_path==nil) {
        NSString *cacheFolder = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        NSString *path = [cacheFolder stringByAppendingPathComponent:HH_CACHE_DB_FILE_NAME];
    }
  
    return _path;
}
-(NSMutableDictionary *)memoryCache{
    if (_memoryCache==nil) {
        _memoryCache=[NSMutableDictionary dictionary];
    }
    return _memoryCache;
}
#pragma mark - public method
/**
 *  保存归档对象到磁盘并且内存缓存此对象,对象必须实现归档协议
 */
- (void)setObject:(nullable id<NSCoding>)object forKey:(NSString *)key{
    if (key==nil) {return;}
    self.memoryCache[key]=object;
    if ([(NSObject *)object conformsToProtocol:@protocol(NSCoding)]) {
        if (object) {
            NSData *data=[NSKeyedArchiver archivedDataWithRootObject:object];
            [self saveObjectData:data forKey:key];
        }else{
            [self saveObjectData:nil forKey:key];
        }
    }
}
/**
 *  根据指定缓存协议来缓存对象,对象必须实现归档协议
 */
- (void)setObject:(nullable id<NSCoding>)object forKey:(NSString *)key option:(HHCacheOption)option{
    if (key==nil) {return;}
    if (option==HHCacheOptionMemoryAndDisk) {
        self.memoryCache[key]=object;
        if ([(NSObject *)object conformsToProtocol:@protocol(NSCoding)]) {
            if (object) {
                NSData *data=[NSKeyedArchiver archivedDataWithRootObject:object];
                [self saveObjectData:data forKey:key];
            }else{
                [self saveObjectData:nil forKey:key];
            }
        }

    }else if (option==HHCacheOptionMemoryOnly){
        self.memoryCache[key]=object;
        
    }else if (option==HHCacheOptionDiskOnly){
        if ([(NSObject *)object conformsToProtocol:@protocol(NSCoding)]) {
            if (object) {
                NSData *data=[NSKeyedArchiver archivedDataWithRootObject:object];
                [self saveObjectData:data forKey:key];
            }else{
                [self saveObjectData:nil forKey:key];
            }
        }

    }
}

/**
 *  获取归档对象,先取内存缓存,如果没有则取磁盘缓存
 */
- (nullable id<NSCoding>)objectForKey:(NSString *)key{
    if (key==nil) {return nil;}
    id object=self.memoryCache[key];
    if (!object) {
        NSData *data=[self objectDataForKey:key];
        object=[NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return object;
}
/**
 *  根据指定缓存协议来获取对象
 */
- (nullable id<NSCoding>)objectForKey:(NSString *)key option:(HHCacheOption)option{
    if (key==nil) {return nil;}
    if (option==HHCacheOptionMemoryAndDisk) {
        id object=self.memoryCache[key];
        if (!object) {
            NSData *data=[self objectDataForKey:key];
            object=[NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
        return object;

    }else if (option==HHCacheOptionMemoryOnly){
        return self.memoryCache[key];
        
    }else if (option==HHCacheOptionDiskOnly){
        NSData *data=[self objectDataForKey:key];
        id object=[NSKeyedUnarchiver unarchiveObjectWithData:data];
        return object;
    }
    return nil;
}

/**
 *  移除指定缓存(磁盘和内存)
 */
- (void)removeObjectForKey:(NSString *)key{
    if (key==nil) {return;}
    [self.memoryCache removeObjectForKey:key];
    [self removeObjectDataForKey:key];
}
/**
 *  移除指定缓存协议和key对应的缓存对象
 */
- (void)removeObjectForKey:(NSString *)key option:(HHCacheOption)option{
    if (key==nil) {return;}
    if (option==HHCacheOptionMemoryAndDisk) {
        [self.memoryCache removeObjectForKey:key];
        [self removeObjectDataForKey:key];

    }else if (option==HHCacheOptionMemoryOnly){
        [self.memoryCache removeObjectForKey:key];

    }else if (option==HHCacheOptionDiskOnly){
        [self removeObjectDataForKey:key];
    }
}
/**
 *  移除所有缓存(磁盘和内存)
 */
- (void)removeAllObjects{
    [self.memoryCache removeAllObjects];
    [self removeAllObjectDatas];
}
#pragma mark - db operation

- (BOOL)saveObjectData:(NSData *)data forKey:(NSString *)key{
    return YES;
}
- (NSData *)objectDataForKey:(NSString *)key{
    return nil;
}
- (void)removeObjectDataForKey:(NSString *)key{
    
}
- (void)removeAllObjectDatas{
    
}
@end
