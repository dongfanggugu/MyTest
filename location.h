//
//  location.h
//  elevatorMan
//
//  Created by Cove on 15/6/29.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LocationMode)
{
    SignificantChangeLocation,
    BackgroundLocaton
};

@interface location : NSObject

+ (instancetype)sharedLocation;

- (void)startLocationService;

- (void)stopLocation;

@property (nonatomic, assign) LocationMode mode;

@end
