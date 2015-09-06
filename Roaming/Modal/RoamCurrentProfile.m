//
//  RoamCurrentProfile.m
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "RoamCurrentProfile.h"
#import "Tool.h"
@implementation RoamCurrentProfile
+(instancetype)createCurrentProfileWithDict:(NSDictionary *)dict{
    RoamCurrentProfile * currentProfile=[[RoamCurrentProfile alloc]init];
    [Tool reflectPropertyValueFromDict:currentProfile dict:dict];
    return currentProfile;
}
@end
