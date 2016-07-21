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



typedef NS_ENUM(NSInteger,HHLocationResult) {
    HHLocationResultNormal,//定位+反地理编码正常
    HHLocationResultFailed,//定位、反地理编码失败
    HHLocationResultGeoFailed,//地理编码失败
    HHLocationResultDenied,//用户拒绝app使用定位
    HHLocationResultRestricted//当前用户没有权限使用定位，比如家长控制
};
typedef  (^CompleteLocationBlock)(HHLocation *location,HHLocationResult resultState);


#pragma mark - manager
@interface HHLocationManager : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, assign, readonly) BOOL locationEnabled;//定位是否有效

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
@interface HHLocation : NSObject

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;/**经纬度*/

@property (nonatomic, strong) NSString *country;// "Country" 国家

@property (nonatomic, strong) NSString *province;// "State" 省

@property (nonatomic, strong) NSString *city;// "City" 市

@property (nonatomic, strong) NSString *district;  // "SubLocality" 区

@property (nonatomic, strong) NSString *street;//"Street" 街道

@property (nonatomic, strong) NSString *address;//省市区街道合并

/**
    CLLocation,所有位置信息都在CLLocation中,获取更多定位位置信息
 */
@property (nonatomic, strong) CLLocation *location;

/**
    CLPlacemark,反地理编码结果,获取更多反编码后地址结果
 */
@property (nonatomic, strong) CLPlacemark *placemark;


@end