//
//  HHLocationManager.h
//  HHKit
//
//  Created by LWJ on 16/7/21.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@class HHLocation;
@class HHLocationManager;

typedef NS_ENUM(NSInteger,HHLocationStatus) {
    HHLocationStatusNormal,//定位/反地理编码/地理编码正常
    HHLocationStatusFailed,//定位/反地理编码失败
    HHLocationStatusGeoFailed,//地理编码失败
    HHLocationStatusDenied,//用户拒绝app使用定位
    HHLocationStatusRestricted,//当前用户没有权限使用定位，比如家长控制
    HHLocationStatusServiceUnabled,//定位服务不可用

};
typedef void (^CompleteLocationBlock)(HHLocation *location,HHLocationStatus resultState);


#pragma mark - manager
@interface HHLocationManager : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, assign, readonly) BOOL locationEnabled;//定位是否有效
@property (nonatomic, assign, readonly) BOOL isUpdatingLocation;//是否正在定位
@property (nonatomic, strong, readonly) HHLocation *locationCache;//获取上次app定位缓存信息
/**
 *  开始定位，只定一次
 *  @isGeo 是否需要反地理编码，YES,则执行反地理编码，并且将编码结果返回在location参数中。如果定位成功，但反地理编码失败，则返回error信息，两者同时成功则才返回location。NO 则不执行反地理编码，只返回定位后的经纬度等信息
 */
- (void)startLocationReverseGeocode:(BOOL)isGeo complete:(CompleteLocationBlock)complete;
/**
 *  开始定位，实时更新，暂时不支持反编码
 */
- (void)startUpdateLocationComplete:(CompleteLocationBlock)complete;
/**
 *  停止定位,如果在反地理编码则同时停止编码
 */
- (void)stopUpdateLocation;

/**
 *  地理编码
 */
- (void)geocodeAddressString:(NSString *)addressString completionHandler:(CompleteLocationBlock)completionHandler;

@end



#pragma mark - 位置数据
@interface HHLocation : NSObject <NSCoding>

@property (nonatomic, assign, readonly) CLLocationCoordinate2D coordinate;/**经纬度*/

@property (nonatomic, strong, readonly) NSString *country;//  国家

@property (nonatomic, strong, readonly) NSString *province;//  省

@property (nonatomic, strong, readonly) NSString *city;// 市

@property (nonatomic, strong, readonly) NSString *district;  //  区

@property (nonatomic, strong, readonly) NSString *street;// 街道

@property (nonatomic, strong) NSString *address;//省市区街道合并

/**
    CLLocation,所有位置信息都在CLLocation中,获取更多定位位置信息
 */
@property (nonatomic, strong, readonly) CLLocation *location;

/**
    CLPlacemark,反地理编码结果,获取更多反编码后地址结果
 */
@property (nonatomic, strong, readonly) CLPlacemark *placemark;


- (instancetype)initWithCLLocation:(CLLocation *)location;
- (instancetype)initWithCLPlacemark:(CLPlacemark *)placemark;

@end