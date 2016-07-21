//
//  HHNetworking.h
//  HHNetworking
//
//  Created by LWJ on 16/7/7.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for HHNetworking.
FOUNDATION_EXPORT double HHNetworkingVersionNumber;

//! Project version string for HHNetworking.
FOUNDATION_EXPORT const unsigned char HHNetworkingVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <HHNetworking/PublicHeader.h>


#pragma mark - server
/**
 *  用于切换服务器环境，只需修改此处宏值即可
 *  如果新增服务器环境，需要添加环境定义，并且在下面宏条件语句中添加条件分支，并且修改主机域名值
 *  如果修改服务器环境，则只在宏条件里面修改具体对应环境的值
 */

#define HH_CUR_SERVER_CONFIG   HH_SERVER_DEV /* 当前服务器环境,如需切换则改 */


/**
 *  服务器环境类型值
 *  新增或删除的同时也需同步修改条件判断
 */

#define HH_SERVER_DEV      1001 //开发环境

#define HH_SERVER_QA       1002 //测试环境

#define HH_SERVER_UAT      1003 //UAT

#define HH_SERVER_RELEASE  2001 //正式环境




///////
#pragma mark - import

#import "HHClient.h"






