//
//  NSString+Util.h
//  UsedCar
//
//  Created by Alan on 13-11-8.
//  Copyright (c) 2013年 Alan. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSString (Util)

/**
    md5加密
 */
- (NSString *)md5;

/**
    去掉字符串两端空格
 */
- (NSString *)trim;
/**
    哈希值
 */
- (NSString *)sha1;

/**
    3DES加密解密
 */
- (NSString *)encrypt3DES:(NSString *)key iv:(NSString *)iv;
- (NSString *)decrypt3DES:(NSString *)key iv:(NSString *)iv;

/**
    AES加密解密
 */
- (NSString *)encryptAES:(NSString *)key;
- (NSString *)decryptAES:(NSString *)key;

/*是否包含中文*/
- (BOOL)isContainsChinese;
/**
 判断emoji
 */
-(BOOL)isContainsEmoji;

//是不是链接
-(BOOL)isURL;


+ (NSString *)decodeUTF8ToChinese:(NSString *)encodeStr;
+ (NSString *)encodeChineseToUTF8:(NSString *)encodeStr;

/* 调整行间距 */
-(NSMutableAttributedString *)lineSpacing:(NSInteger)spc;

@end



@interface NSString(NSDate)
/**
    返回一个秒单位的时间戳
 */
+(NSString *)timeStamp;
/**
    返回指定格式的指定时间的字符串时间
 */
+(NSString *)dateFmtStr:(NSString *)fmt date:(NSDate *)date;
/**
    返回中文格式化描述的时间字符串
    e.g. 1分钟前,2天前
 */
+(NSString *)timeIntervalDescription:(NSDate *)date;
/**
    返回一个指定格式的且指定时间字符串的格式化字符串
 */
+(NSString *)fmtDateString:(NSString *)date withFmt:(NSString *)fmt;
/**
    返回一个指定格式时间格式化的DateComponents
 */
-(NSDateComponents *)componentsWithFormat:(NSString *)fmt;
/**
    返回一个格式为yyyy-MM-hh的时间戳转换好的时间字符串
 */
+ (NSString *)stringFromDate:(NSNumber *)number;
/**
    返回一个星座
 */
+ (NSString *)getConstellation:(NSDate *)date;
@end
