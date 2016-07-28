//
//  HHServerConfig.h
//  HHNetworking
//
//  Created by liuwenjie on 16/7/28.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#ifndef HHServerConfig_h
#define HHServerConfig_h

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


/**
 *  根据 CUR_SERVER_CONFIG 判断当前服务器该选择哪一主机
 *  具体根据服务器类型值判断，需要和服务器类型值一一对应
 */
#   if (HH_CUR_SERVER_CONFIG == HH_SERVER_DEV) /* 开发环境服务器 */

static NSString * const kDefaultBaseURLString = @"http://192.168.1.150:8008/api/";

//static NSString * const kDefaultBaseURLString = @"http://192.168.1.150:8001/api/";

static NSString * const kAutoThreehundredURLStringHH = @"http://192.168.1.150:8011/vehicleapi/"; //车300

#   elif (HH_CUR_SERVER_CONFIG == HH_SERVER_QA) /* 测试环境 */


static NSString * const kDefaultBaseURLString = @"http://192.168.1.150:8008/api/";

static NSString * const kAutoThreehundredURLStringHH = @"http://192.168.1.150:8018/vehicleapi/"; //车300

#   elif (HH_CUR_SERVER_CONFIG == HH_SERVER_UAT)/* UAT */

static NSString * const kDefaultBaseURLString = @"http://192.168.1.150:8009/api/";

static NSString * const kAutoThreehundredURLStringHH = @"http://192.168.1.150:119/vehicleapi/";//车300

#   else /* 正式线上版本 */

static NSString * const kDefaultBaseURLString = @"http://api.v23.honghongauto.com/api/";

static NSString * const kAutoThreehundredURLStringHH = @"http://vehicles.honghongauto.com/vehicleapi/"; //车300

#   endif







#endif /* HHServerConfig_h */
