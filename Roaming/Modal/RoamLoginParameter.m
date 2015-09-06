//
//  RoamLoginParameter.m
//  Roaming
//
//  Created by 陈丁丁 on 15/8/29.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "RoamLoginParameter.h"
#import "Tool.h"
@implementation RoamLoginParameter
+(instancetype)createLoginParameterWithUserName:(NSString*)username
                                    andPassword:(NSString*)password{
    RoamLoginParameter * loginParameter=[[RoamLoginParameter alloc]init];
    loginParameter.username=username;
    loginParameter.password=password;
    loginParameter.dict=[Tool reflectDictFromPropertyValue:loginParameter];
    return loginParameter;
}
@end
