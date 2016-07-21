//
//  HHSystemInfo.m
//  HHKit
//
//  Created by liuwenjie on 16/7/9.
//  Copyright © 2016年 hhauto. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "HHSystemInfo.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#include <sys/types.h>
#include <sys/sysctl.h>

#include <string>

using namespace std;

@implementation HHSystemInfo
+ (HHSystemInfo *)sharedInstance
{
    static HHSystemInfo * g_instance = nil;
    if (nil == g_instance)
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            g_instance = [[HHSystemInfo alloc] init];
        });
    }
    
    return g_instance;
}

#pragma mark - 硬件信息

//获得设备型号
- (NSString *)getCurrentDeviceModel
{
    int mib[2];
    size_t len;
    char * machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = (char *)malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    return platform;
}

- (NSString *)getCurrentDeviceModelDetail
{
    NSString *platform = [self getCurrentDeviceModel];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    return platform;
}

- (NSString *)deviceType;       ///< 设备型号
{
    static NSString * g_deviceType = [self getCurrentDeviceModel];
    return g_deviceType;
}

- (NSString *)deviceTypeDetail;       ///< 设备型号
{
    static NSString * g_deviceTypeDetail = [self getCurrentDeviceModelDetail];
    return g_deviceTypeDetail;
}

- (NSString *)deviceModel      ///< e.g. @"iPhone", @"iPod touch"
{
    return [[UIDevice currentDevice] model];
}

- (NSString *)deviceName;       ///< 设备名称
{
    return [[UIDevice currentDevice] name];
}

- (unsigned long long)totalDiskSpace;       ///< 设备总计磁盘空间容量
{
    static unsigned long long totalDiskSpace = 0;
    if (totalDiskSpace == 0.0)
    {
        NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
        totalDiskSpace = [[fattributes objectForKey:NSFileSystemSize] unsignedLongLongValue];
    }
    
    return totalDiskSpace;
}

- (unsigned long long)totalMemorySpace;     ///< 设备总计内存空间容量
{
    return [NSProcessInfo processInfo].physicalMemory;
}

- (BOOL)isLowEndEquipment;      ///< 是否低端设备 注意只包含iPhone, iPod，不包含iPad
{
    static BOOL isLowEndEquipment = NO;
    static BOOL needCheckDeviceModel = YES;
    
    if (needCheckDeviceModel)
    {
        NSString * deviceModel = [self deviceModel];
        isLowEndEquipment = [self isLowDevString:deviceModel];
        
        needCheckDeviceModel = NO;
    }
    
    return isLowEndEquipment;
}

- (BOOL)isLowDevString:(NSString*)deviceModel
{
    if (([deviceModel isEqualToString:@"iPhone1,1"])       // @"iPhone 2G";
        || ([deviceModel isEqualToString:@"iPhone1,2"])    // @"iPhone 3G";
        || ([deviceModel isEqualToString:@"iPhone2,1"])    // @"iPhone 3GS";
        || ([deviceModel isEqualToString:@"iPhone3,1"])    // @"iPhone 4";
        || ([deviceModel isEqualToString:@"iPhone3,2"])    // @"iPhone 4";
        || ([deviceModel isEqualToString:@"iPhone3,3"])    // @"iPhone 4 (CDMA)";
        || ([deviceModel isEqualToString:@"iPod1,1"])      // @"iPod Touch (1 Gen)";
        || ([deviceModel isEqualToString:@"iPod2,1"])      // @"iPod Touch (2 Gen)";
        || ([deviceModel isEqualToString:@"iPod3,1"])      // @"iPod Touch (3 Gen)";
        || ([deviceModel isEqualToString:@"iPod4,1"]))     // @"iPod Touch (4 Gen)";
    {
        return YES;
    }
    
    return NO;
}

#pragma mark - 操作系统信息
- (CGFloat)iosVersion;          ///< 操作系统版本
{
    static float versionValue = -1.0;
    if(versionValue < 0.f)
    {
        NSString *os_verson = [[UIDevice currentDevice] systemVersion];
        
        // 处理形如6.1.3的版本号，使其变成6.13，方便外部处理
        NSArray* versionNumbers = [os_verson componentsSeparatedByString:@"."];
        os_verson = @"";
        for (int i = 0; i < versionNumbers.count; i++)
        {
            os_verson = [os_verson stringByAppendingString:[versionNumbers objectAtIndex:i]];
            if (i == 0)
            {
                os_verson = [os_verson stringByAppendingString:@"."];
            }
        }
        
        versionValue = [os_verson floatValue];
    }
    
    return versionValue;
}

- (NSString *)iosName             ///< 操作系统名称 iPhone OS 8.0
{
    NSString * strSysName = [[UIDevice currentDevice] systemName];
    NSString * strSysVersion = [[UIDevice currentDevice] systemVersion];
    
    NSString * name = [NSString stringWithFormat:@"%@ %@", strSysName, strSysVersion];
    
    return name;
}

- (NSString *)iosShotName      ///< 操作系统名称： iOS 8.0
{
    NSString * strSysVersion = [[UIDevice currentDevice] systemVersion];
    
    NSString * name = [NSString stringWithFormat:@"iOS %@", strSysVersion];
    
    return name;
}

- (NSString *)iosLanguageID;       ///< 操作系统当前语言ID
{
    NSArray *languageArray = [NSLocale preferredLanguages];
    NSString *language = [languageArray objectAtIndex:0];
    //NSLog(@"语言：%@", language);   ///< en/en_US/zh-Hans
    
    return language;
}

- (NSString *)iosBuildID          ///< 操作系统Build id
{
    static NSString * sysBuildID = nil;
    
    if (nil == sysBuildID)
    {
        char buildId[128];
        memset(buildId, 0, sizeof(buildId));
        
        const char *versionString = [[[NSProcessInfo processInfo] operatingSystemVersionString] UTF8String];
        
        if (NULL != versionString)
        {
            // versionString的格式如："Version 5.1.1 (Build 9B176)"
            sscanf(versionString, "%*s%*s%*s %[0-9A-Za-z]", buildId);
        }
        
        if (0 == strlen(buildId))
        {
            strcpy(buildId, "9A405");
        }
        
        sysBuildID = [NSString stringWithUTF8String:buildId];
    }
    
    return sysBuildID;
}

struct DefaultWebkitVersionTableItem {
    CGFloat minIOSVersion;
    const char* webkitVersion;
};


const DefaultWebkitVersionTableItem kWebkitVersionTable[] = {
    5.00, "534.46",
    6.00, "536.26",
    7.00, "537.51.1",
};
const int kWebkitVersionTableCount = sizeof(kWebkitVersionTable) / sizeof(DefaultWebkitVersionTableItem);

const char* tryToMatchNearestWebkitVersionWithIOSVersion(CGFloat iosVersion)
{
    assert(kWebkitVersionTableCount > 0);
    const char* ret = kWebkitVersionTable[0].webkitVersion;
    
    for (int i = 0; i < kWebkitVersionTableCount; i++)
    {
        if (iosVersion > kWebkitVersionTable[i].minIOSVersion - 0.0001)
        {
            ret = kWebkitVersionTable[i].webkitVersion;
        }
    }
    
    return ret;
}

- (NSString *)webkitVersion;       ///< WebKit版本号
{
    static NSString * retWKVStr = [NSString stringWithUTF8String:tryToMatchNearestWebkitVersionWithIOSVersion([self iosVersion])];
    
    return retWKVStr;
}

- (BOOL)isJailbroken;          ///< 是否已越狱
{
    static int jailbroken = -1;
    
    if (-1 == jailbroken)
    {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://"]])
        {
            jailbroken = 1;
        }
        else
        {
            jailbroken = 0;
        }
    }
    
    return (1 == jailbroken) ? YES : NO;
}

#define PP_APP_SCHEME                      @"pphelperNS://"
- (BOOL)isPPInstalled;      ///< 是否已经安装PP助手
{
    BOOL bRet = NO;
    
    bRet = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:PP_APP_SCHEME]];
    
    return bRet;
}

// Get IP Address
- (NSString *)IPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

- (CGSize)screenSize;     ///< 屏幕Size，按贴图坐标计算 例如iPhone 4S为 320 * 480
{
    UIScreen * mainScreen = [UIScreen mainScreen];
    CGSize size = [mainScreen bounds].size;
    return size;
}

- (CGSize)screenResolution;     ///< 屏幕分辨率，按真实像素计算 例如iPhone 4S为 640 * 960
{
    UIScreen * mainScreen = [UIScreen mainScreen];
    UIScreenMode * screenMode = [mainScreen currentMode];
    CGSize size = [screenMode size];
    return size;
}

@end
