//
//  RoamSimInfo.m
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "RoamSimInfo.h"
#import "Tool.h"
@implementation RoamSimInfo
+(instancetype)createSimInfoWithDict:(NSDictionary*)dict{
    RoamSimInfo * simInfo=[[RoamSimInfo alloc]init];
    [Tool reflectPropertyValueFromDict:simInfo dict:dict];
    return simInfo;
}
@end
