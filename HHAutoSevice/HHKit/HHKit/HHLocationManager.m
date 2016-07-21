//
//  HHLocationManager.m
//  HHKit
//
//  Created by LWJ on 16/7/21.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import "HHLocationManager.h"

@implementation HHLocationManager{
    CLLocationManager *_locationManager;
    CLGeocoder *_geoCoder;
}
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
    }
    return self;
}
- (void)startLocationReverseGeocode:(BOOL)isGeo complete:(CompleteLocationBlock)complete{
    
}
- (void)startUpdateLocationComplete:(CompleteLocationBlock)complete{
    
}
- (void)stopUpdateLocation{
    
}
- (void)geocodeAddressString:(NSString *)addressString completionHandler:(CompleteLocationBlock)completionHandler{
    
}

@end
