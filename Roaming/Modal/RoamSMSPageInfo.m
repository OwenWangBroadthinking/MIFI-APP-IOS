//
//  RoamSMSPageInfo.m
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "RoamSMSPageInfo.h"
#import "Tool.h"
@implementation RoamSMSPageInfo
+(instancetype)createSMSPageInfoWithDict:(NSDictionary*)dict{
    RoamSMSPageInfo * smsPageInfo=[[RoamSMSPageInfo alloc]init];
    [Tool reflectPropertyValueFromDict:smsPageInfo dict:dict];
    return smsPageInfo;
}
@end
