//
//  RoamWlanInfo.m
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "RoamWlanInfo.h"
#import "Tool.h"
@implementation RoamWlanInfo
+(instancetype)createWlanInfoWithDict:(NSDictionary*)dict{
    RoamWlanInfo * wlanInfo=[[RoamWlanInfo alloc]init];
    [Tool reflectPropertyValueFromDict:wlanInfo dict:dict];
    return wlanInfo;
}
@end
