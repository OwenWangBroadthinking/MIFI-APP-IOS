//
//  RoamWanInfo.m
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "RoamWanInfo.h"
#import "Tool.h"
@implementation RoamWanInfo
+(instancetype)createWanInfoWithDict:(NSDictionary *)dict{
    RoamWanInfo * wanInfo=[[RoamWanInfo alloc]init];
    [Tool reflectPropertyValueFromDict:wanInfo dict:dict];
    return wanInfo;
}
@end
