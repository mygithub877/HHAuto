//
//  NSString+Hash.h
//  HHNetworking
//
//  Created by LWJ on 16/7/29.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

@interface NSString (HHURLEncrypt)
/**
 *  计算MD5散列结果
 *
 *  终端测试命令：
 *  @code
 *  md5 -s "string"
 *  @endcode
 *
 *  <p>提示：随着 MD5 碰撞生成器的出现，MD5 算法不应被用于任何软件完整性检查或代码签名的用途。<p>
 *
 *  @return 32个字符的MD5散列字符串
 */
- (NSString *)md5String;

/**
    获取app版本号
 */
+ (NSString *)appVersion;

/**
 AES加密解密
 */
- (NSString *)net_encryptAES:(NSString *)key;
- (NSString *)net_decryptAES:(NSString *)key;


@end

@interface NSData (HHURLEncrypt)

- (NSData *)net_encryptAES:(NSString *)key;
- (NSData *)net_decryptAES:(NSString *)key;

+ (NSData *)CCCryptData:(NSData *)data algorithm:(CCAlgorithm)algorithm operation:(CCOperation)operation keyString:(NSString *)keyString iv:(NSData *)iv;

@end
