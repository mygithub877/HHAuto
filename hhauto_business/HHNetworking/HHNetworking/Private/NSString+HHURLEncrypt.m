//
//  NSString+Hash.m
//  HHNetworking
//
//  Created by LWJ on 16/7/29.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import "NSString+HHURLEncrypt.h"

@implementation NSString (HHURLEncrypt)
- (NSString *)md5String {
    const char *str = self.UTF8String;
    uint8_t buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(str, (CC_LONG)strlen(str), buffer);
    
    return [self stringFromBytes:buffer length:CC_MD5_DIGEST_LENGTH];
}
/**
 *  返回二进制 Bytes 流的字符串表示形式
 *
 *  @param bytes  二进制 Bytes 数组
 *  @param length 数组长度
 *
 *  @return 字符串表示形式
 */
- (NSString *)stringFromBytes:(uint8_t *)bytes length:(int)length {
    NSMutableString *strM = [NSMutableString string];
    
    for (int i = 0; i < length; i++) {
        [strM appendFormat:@"%02x", bytes[i]];
    }
    
    return [strM copy];
}
+ (NSString *)appVersion{
    NSDictionary* infoDict = [NSBundle mainBundle].infoDictionary;
    
    NSString* appVersion = infoDict[@"CFBundleShortVersionString"];
    return appVersion;
}
-(NSString *)net_encryptAES:(NSString *)key{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *result = [data net_encryptAES:key];
    
    return [result base64EncodedStringWithOptions:0];

    
}
-(NSString *)net_decryptAES:(NSString *)key{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    NSData *result = [data net_decryptAES:key];
    
    return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];

}


@end
@implementation NSData (HHURLEncrypt)
#pragma mark 加密
-(NSData *)net_encryptAES:(NSString *)key{
    return  [NSData CCCryptData:self algorithm:kCCAlgorithmAES operation:kCCEncrypt keyString:key iv:nil];
}

#pragma mark 解密
-(NSData *)net_decryptAES:(NSString *)key{
    return [NSData CCCryptData:self algorithm:kCCAlgorithmAES operation:kCCDecrypt keyString:key iv:nil];
}

#pragma mark 对称加密&解密核心方法
///  @return 加密/解密结果
+ (NSData *)CCCryptData:(NSData *)data algorithm:(CCAlgorithm)algorithm operation:(CCOperation)operation keyString:(NSString *)keyString iv:(NSData *)iv {
    
    int keySize = (algorithm == kCCAlgorithmAES) ? kCCKeySizeAES256 : kCCKeySizeDES;
    int blockSize = (algorithm == kCCAlgorithmAES) ? kCCKeySizeAES256: kCCBlockSizeDES;
    
    
    NSData *keyData = [keyString dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t cKey[keySize];
    bzero(cKey, sizeof(cKey));
    [keyData getBytes:cKey length:keySize];
    
    
    uint8_t cIv[blockSize];
    bzero(cIv, blockSize);
    int option = kCCOptionPKCS7Padding | kCCOptionECBMode;
    if (iv) {
        [iv getBytes:cIv length:blockSize];
        option = kCCOptionPKCS7Padding;
    }
    
    
    size_t bufferSize = [data length] + blockSize;
    void *buffer = malloc(bufferSize);
    
    // 加密或解密
    size_t cryptorSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(operation,
                                          algorithm,
                                          option,
                                          cKey,
                                          keySize,
                                          cIv,
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          bufferSize,
                                          &cryptorSize);
    
    NSData *result = nil;
    if (cryptStatus == kCCSuccess) {
        result = [NSData dataWithBytesNoCopy:buffer length:cryptorSize];
    } else {
        free(buffer);
        NSLog(@"[错误] 加密或解密失败 | 状态编码: %d", cryptStatus);
    }
    
    return result;
}



@end