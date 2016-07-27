//
//  HHLocationManager.m
//  HHKit
//
//  Created by LWJ on 16/7/21.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import "HHLocationManager.h"
#import <UIKit/UIKit.h>
#import "PrivateHeader.h"

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice]systemVersion]floatValue]>=8.0)
#define LocationDictLongitude(x) [(x)[@"longitude"] doubleValue]
#define LocationDictLatitude(x) [(x)[@"latitude"] doubleValue]

#define locationPromptTitle @"定位服务未开启"
#define locationPromptContent @"请在设置中开启定位服务"

static NSString *const HHLocationCacheKey = @"HHLocationCacheKey";


@interface HHLocationManager()<CLLocationManagerDelegate>
{
    CLLocationManager *_locationManager;
    CLGeocoder *_geoCoder;
    CompleteLocationBlock _completeBlock;
    BOOL _isNeedGeo;
}
@property (nonatomic, assign, readwrite) BOOL isUpdatingLocation;//是否正在定位

@end
@implementation HHLocationManager

@synthesize locationCache=_locationCache;

static HHLocationManager *manager=nil;
+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[[HHLocationManager alloc] init];
    });
    return manager;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _locationManager=[[CLLocationManager alloc] init];
        _locationManager.desiredAccuracy=kCLLocationAccuracyNearestTenMeters;
        _locationManager.distanceFilter=1500.f;
        if (IS_OS_8_OR_LATER) {
            [_locationManager requestAlwaysAuthorization];
        }
        _locationManager.delegate=self;
        _geoCoder=[[CLGeocoder alloc] init];
    }
    return self;
}
- (HHLocationStatus)status{
    
    CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
    HHLocationStatus managerStatus = HHLocationStatusServiceUnabled;
    switch (authorizationStatus) {
        case kCLAuthorizationStatusRestricted: {
            managerStatus = HHLocationStatusRestricted;
            break;
        }
        case kCLAuthorizationStatusDenied: {
            managerStatus = HHLocationStatusDenied;
            break;
        }
        case kCLAuthorizationStatusAuthorizedAlways:{
            managerStatus=HHLocationStatusNormal;
        }
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:{
            managerStatus=HHLocationStatusNormal;
        }
            break;
        default: {
            managerStatus = HHLocationStatusServiceUnabled;
            break;
        }
    }
    
    return managerStatus;
}
- (void)storedLocation:(HHLocation *)location
{
    _locationCache=location;
    NSData *archiver=[NSKeyedArchiver archivedDataWithRootObject:location];
    
    [[NSUserDefaults standardUserDefaults] setObject:location forKey:HHLocationCacheKey];
}
-(HHLocation *)locationCache{
    if (_locationCache) {
        return _locationCache;
    }else{
        return [[NSUserDefaults standardUserDefaults]objectForKey:HHLocationCacheKey];
    }
}
#pragma mark - updateLocation
- (void)startLocationReverseGeocode:(BOOL)isGeo complete:(CompleteLocationBlock)complete{
    _completeBlock=[complete copy];
    if (![CLLocationManager locationServicesEnabled]) {
        _locationEnabled=NO;
        if (complete) {
            complete(nil,[self status]);
        }
    }else{
        if ([self status]!=HHLocationStatusNormal) {
            _locationEnabled=NO;
            if (complete) {
                complete(nil,[self status]);
            }
        }else{
            _isNeedGeo=isGeo;
            [_locationManager startUpdatingLocation];
            self.isUpdatingLocation=YES;
        }
    }
}
- (void)startUpdateLocationComplete:(CompleteLocationBlock)complete{
    [self startLocationReverseGeocode:NO complete:complete];
}
- (void)stopUpdateLocation{
    [_locationManager stopUpdatingLocation];
}
#pragma mark - Geo
- (void)geocodeAddressString:(NSString *)addressString completionHandler:(CompleteLocationBlock)completionHandler{
    if (addressString) {
        [_geoCoder geocodeAddressString:addressString completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if (error) {
                if (completionHandler) {
                    completionHandler(nil,HHLocationStatusGeoFailed);
                }
            }else{
                CLPlacemark *place=[placemarks lastObject];
                HHLocation *hLocation=[[HHLocation alloc] initWithCLPlacemark:place];
                hLocation.address=place.name;
                if (completionHandler) {
                    completionHandler(hLocation,HHLocationStatusNormal);
                }
            }
        }];
    }else{
        if (completionHandler) {
            completionHandler(nil,HHLocationStatusGeoFailed);
        }
    }
}

#pragma mark - CLLocation Delegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    printf("\n///////\n\nchange Authorization status\n\n////////\n");
    if ([self status]==HHLocationStatusDenied) {
        [self locationServiceUnAuthorizedPrompt];
    }
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    printf("\n///////\n\nupdate location\n\n////////\n");
    
    [self stopUpdateLocation];
    if (locations.count>0) {
        CLLocation *location=[locations lastObject];
        HHLocation *hLocation=[[HHLocation alloc] initWithCLLocation:location];
        if (_isNeedGeo) {
            __weak typeof(self) weakSelf=self;
            [_geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                __strong typeof(self) strongSelf=weakSelf;
                strongSelf.isUpdatingLocation = NO;
                if (error) {
                    [strongSelf storedLocation:hLocation];
                    if (strongSelf->_completeBlock) {
                        strongSelf->_completeBlock(hLocation,HHLocationStatusFailed);
                    }
                    
                }else{
                    HHLocation *alocation=[[HHLocation alloc] initWithCLPlacemark:placemarks.lastObject];
                    [strongSelf storedLocation:alocation];
                        if (strongSelf->_completeBlock) {
                        strongSelf->_completeBlock(alocation,HHLocationStatusNormal);
                    }
                }
            }];
        }else{
            self.isUpdatingLocation = NO;
            [self storedLocation:hLocation];
            if (_completeBlock) {
                _completeBlock(hLocation,HHLocationStatusNormal);
            }
        }
    }
    _isNeedGeo=NO;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    self.isUpdatingLocation = NO;
    _isNeedGeo=NO;
    if (error.code == kCLErrorDenied) {
        [self stopUpdateLocation];
    }
    if (_completeBlock) {
        _completeBlock(nil,HHLocationStatusFailed);
    }
}

- (void)locationServiceUnAuthorizedPrompt
{
    
    if (IS_OS_8_OR_LATER) {
        [[[UIAlertView alloc] initWithTitle:locationPromptTitle
                                    message:locationPromptContent
                                   delegate:self
                          cancelButtonTitle:@"取消"
                          otherButtonTitles:@"设置", nil] show];
    } else {
        [[[UIAlertView alloc] initWithTitle:locationPromptTitle
                                    message:locationPromptContent
                                   delegate:self
                          cancelButtonTitle:@"我知道了"
                          otherButtonTitles:nil] show];
    }
    
}

- (void)locationServiceUnablePrompt
{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"设置"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}



@end
@implementation HHLocation

- (instancetype)initWithCLLocation:(CLLocation *)location{
    if (self=[super init]) {
        _location=location;
        _coordinate=location.coordinate;
    }
    return self;
}
- (instancetype)initWithCLPlacemark:(CLPlacemark *)placemark{
    if (self=[super init]) {
        _location=placemark.location;
        _coordinate=placemark.location.coordinate;
        _placemark=placemark;
        NSArray *addr=placemark.addressDictionary[@"FormattedAddressLines"];
        _address=[addr componentsJoinedByString:@""];
        _country=placemark.country;
        _province=placemark.administrativeArea;
        _city=placemark.locality;
        _district=placemark.subLocality;
        _street=placemark.thoroughfare;
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        kFastDecoder(aDecoder);
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
//    kFastEncode(aCoder);
    u_int count=0;
    objc_property_t *properties=class_copyPropertyList([self class], &count);
    for (int i=0; i<count; i++) {
        const char* pname=property_getName(properties[i]);
        NSString *key=[NSString stringWithUTF8String:pname];
        id value=[self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    free(properties);
}
- (BOOL)hasFoundationClass:(Class)aClass{
    NSArray *foundationClass=@[@""];
    if ([foundationClass containsObject:NSStringFromClass(aClass)]) {
        return YES;
    }
    return NO;
}
@end