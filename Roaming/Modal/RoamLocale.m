//
//  RoamLocale.m
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "RoamLocale.h"
#import "Tool.h"
@implementation RoamLocale
+(instancetype)createLocaleWithDict:(NSDictionary*)dict{
    RoamLocale * locale=[[RoamLocale alloc]init];
    [Tool reflectPropertyValueFromDict:locale dict:dict];
    return locale;
}
@end
