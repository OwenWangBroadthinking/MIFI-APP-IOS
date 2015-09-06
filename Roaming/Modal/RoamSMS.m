//
//  RoamSMS.m
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "RoamSMS.h"
#import "Tool.h"
@implementation RoamSMS
+(instancetype)createSMSWithDict:(NSDictionary *)dict{
    RoamSMS * sms=[[RoamSMS alloc]init];
    [Tool reflectPropertyValueFromDict:sms dict:dict];
    return sms;
}
@end
