//
//  HHSystemInfo.h
//  HHKit
//
//  Created by liuwenjie on 16/7/9.
//  Copyright © 2016年 hhauto. All rights reserved.



// * Description	: 硬件信息、操作系统信息


#import <UIKit/UIKit.h>

@interface HHSystemInfo : NSObject
+ (HHSystemInfo *)sharedInstance;

#pragma mark - 硬件信息
- (NSString *)deviceModel;      ///< e.g. @"iPhone", @"iPod touch"
- (NSString *)deviceType;       ///< 设备型号：iPhone4,1
- (NSString *)deviceTypeDetail; ///< 设备型号（详情）：iPhone 6 Plus (A1522/A1524)
- (NSString *)deviceName;       ///< 设备名称："XXX" 的 iPhone
- (unsigned long long)totalDiskSpace;       ///< 设备总计磁盘空间容量
- (unsigned long long)totalMemorySpace;     ///< 设备总计内存空间容量

- (BOOL)isLowEndEquipment;      ///< 是否低端设备 注意只包含iPhone, iPod，不包含iPad


#pragma mark - 操作系统信息
- (CGFloat)iosVersion;          ///< 操作系统版本： 7.1
- (NSString *)iosName;          ///< 操作系统名称： iPhone OS 8.0
- (NSString *)iosShotName;      ///< 操作系统名称： iOS 8.0
- (NSString *)iosLanguageID;    ///< 操作系统当前语言ID en/en_US/zh-Hans
- (NSString *)iosBuildID;       ///< 操作系统Build id
- (NSString *)webkitVersion;    ///< WebKit版本号，e.g. @"537.51.1"

- (BOOL)isJailbroken;           ///< 是否已越狱
- (BOOL)isPPInstalled;          ///< 是否已经安装PP助手

- (NSString *)IPAddress;        ///< IP地址

- (CGSize)screenSize;           ///< 屏幕Size，按贴图坐标计算 例如iPhone 4S为 320 * 480
- (CGSize)screenResolution;     ///< 屏幕分辨率，按真实像素计算 例如iPhone 4S为 640 * 960


@end
