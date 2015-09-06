//
//  RoamMacFilterInfo.m
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "RoamMacFilterInfo.h"
#import "Tool.h"
@implementation RoamMacFilterInfo
+(instancetype)createMacFilterInfoWithDict:(NSDictionary*)dict{
    RoamMacFilterInfo * macFilterInfo=[[RoamMacFilterInfo alloc]init];
    [Tool reflectPropertyValueFromDict:macFilterInfo dict:dict];
    return macFilterInfo;
}
@end
