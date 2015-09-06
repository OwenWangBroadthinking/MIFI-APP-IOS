//
//  RoamSMSStoreState.m
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "RoamSMSStoreState.h"
#import "Tool.h"
@implementation RoamSMSStoreState
+(instancetype)createSMSStoreStateWithDict:(NSDictionary*)dict{
    RoamSMSStoreState * smsStoreState=[[RoamSMSStoreState alloc]init];
    [Tool reflectPropertyValueFromDict:smsStoreState dict:dict];
    return smsStoreState;
}
@end
