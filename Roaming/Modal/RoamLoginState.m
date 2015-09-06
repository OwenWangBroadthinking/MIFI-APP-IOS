
//
//  RoamLoginState.m
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "RoamLoginState.h"
#import "Tool.h"
@implementation RoamLoginState
+(instancetype)createLoginStateWithDict:(NSDictionary*)dict{
    RoamLoginState * loginState=[[RoamLoginState alloc]init];
    [Tool reflectPropertyValueFromDict:loginState dict:dict];
    return loginState;
}
@end
