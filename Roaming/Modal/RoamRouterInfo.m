//
//  RoamRouterInfo.m
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "RoamRouterInfo.h"
#import "Tool.h"

@implementation RoamRouterInfo
+(instancetype)createRouterInfoWithDict:(NSDictionary*)dict{
    RoamRouterInfo * routerInfo=[[RoamRouterInfo alloc]init];
    [Tool reflectPropertyValueFromDict:routerInfo dict:dict];
    return routerInfo;
}
@end
