//
//  RoamNetworkInfo.m
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "RoamNetworkInfo.h"
#import "Tool.h"
@implementation RoamNetworkInfo
+(instancetype)createNetworkInfoWithDict:(NSDictionary*)dict{
    RoamNetworkInfo * networkInfo=[[RoamNetworkInfo alloc]init];
    [Tool reflectPropertyValueFromDict:networkInfo dict:dict];
    return networkInfo;
}
@end
