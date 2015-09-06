//
//  RoamProfile.m
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "RoamProfile.h"
#import "Tool.h"
@implementation RoamProfile
+(instancetype)createProfileWithDict:(NSDictionary*)dict{
    RoamProfile * profile = [[RoamProfile alloc]init];
    [Tool reflectPropertyValueFromDict:profile dict:dict];
    return profile;
}
@end
