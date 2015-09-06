//
//  RoamDeviceSlotMode.h
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoamDeviceSlotMode : NSObject
+(instancetype)createDeviceSlotModeWithDict:(NSDictionary*)dict;
@property (nonatomic, copy) NSString * device_slot_mode;
@property (nonatomic, copy) NSString * error;
@end
