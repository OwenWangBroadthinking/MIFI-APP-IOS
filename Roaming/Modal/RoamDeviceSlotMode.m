//
//  RoamDeviceSlotMode.m
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "RoamDeviceSlotMode.h"
#import "Tool.h"
@implementation RoamDeviceSlotMode
+(instancetype)createDeviceSlotModeWithDict:(NSDictionary*)dict{
    RoamDeviceSlotMode * deviceSlotMode=[[RoamDeviceSlotMode alloc]init];
    [Tool reflectPropertyValueFromDict:deviceSlotMode dict:dict];
    return deviceSlotMode;
}
@end
