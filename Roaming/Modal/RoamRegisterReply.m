//
//  RoamRegistorReply.m
//  Roaming
//
//  Created by chendd on 15/9/2.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "RoamRegisterReply.h"
#import "Tool.h"
@implementation RoamRegisterReply
+(instancetype)createRegistorReplyWithDict:(NSDictionary*)dict{
    RoamRegisterReply * registerReply=[[RoamRegisterReply alloc]init];
    registerReply.code=-1;//设定初始值为-1
    [Tool reflectPropertyValueFromDict:registerReply dict:dict];
    return registerReply;
}
@end
