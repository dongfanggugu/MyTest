//
//  location.m
//  elevatorMan
//
//  Created by Cove on 15/6/29.
//
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "location.h"

@interface location () <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation location


+ (instancetype)sharedLocation
{
    static location *_sharedLocation = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        _sharedLocation = [[location alloc] init];

    });

    return _sharedLocation;
}

- (CLLocationManager *)locationManager
{
    
    if (!_locationManager)
    {
        _locationManager = [[CLLocationManager alloc] init];
        
        _locationManager.pausesLocationUpdatesAutomatically = NO;
        
        _locationManager.allowsBackgroundLocationUpdates = YES;
        
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        _locationManager.delegate = self;
    }
    
    return _locationManager;
}

/**
 *  启动位置更新
 */
- (void)startLocationService
{
    if ([CLLocationManager locationServicesEnabled])
    {
        [self.locationManager startUpdatingLocation];
//        [self.locationManager startMonitoringSignificantLocationChanges];
    }
}

/**
 *  位置更新时回调
 *
 *  @param manager   manager
 *  @param locations locations
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *myLocation = locations.firstObject;
    
    NSLog(@"location complte: %@", [self format]);
    
//    NSLog(@"remain time: %lf", [UIApplication sharedApplication].backgroundTimeRemaining);
    
//    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:info forKey:@"userLocation"];
//    
//    NSNotification *notification = [NSNotification notificationWithName:@"userLocationUpdate" object:nil userInfo:userInfo];
//    //通过通知中心发送通知
//    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

- (NSString *)format
{
    NSDate *date = [NSDate date];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *result = [format stringFromDate:date];
    
    return result;
}

/**
 *  停止定位
 */
- (void)stopLocation
{
    if (self.locationManager)
    {
        [_locationManager stopUpdatingLocation];
    }
}

/**
 *  改变授权状态
 *
 *  @param manager manager
 *  @param status  status
 */
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status)
    {
        case kCLAuthorizationStatusNotDetermined:
            if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
            {
                [self.locationManager requestAlwaysAuthorization];
            }
            break;
            
        case kCLAuthorizationStatusDenied:
            if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
            {
            }
            break;
            
        default:
            break;
    }
}

@end
