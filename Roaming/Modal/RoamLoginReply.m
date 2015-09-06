//
//  RoamLoginReply.m
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "RoamLoginReply.h"
#import "Tool.h"
@implementation RoamLoginReply
+(instancetype)createLoginReplyWithDict:(NSDictionary*)dict{
    RoamLoginReply * loginReply=[[RoamLoginReply alloc]init];
    [Tool reflectPropertyValueFromDict:loginReply dict:dict];
    return loginReply;
}
@end
