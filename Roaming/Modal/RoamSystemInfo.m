//
//  RoamSystemInfo.m
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "RoamSystemInfo.h"
#import "Tool.h"
@implementation RoamSystemInfo
+(instancetype)createSystemInfoWithDict:(NSDictionary*)dict{
    RoamSystemInfo * systemInfo=[[RoamSystemInfo alloc]init];
    [Tool reflectPropertyValueFromDict:systemInfo dict:dict];
    return systemInfo;
}
@end
