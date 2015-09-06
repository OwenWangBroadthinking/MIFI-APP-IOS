//
//  RoamProfileList.m
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "RoamProfileList.h"
#import "RoamProfile.h"
#import "Tool.h"
@implementation RoamProfileList
+(instancetype)createProfileListWithDict:(NSDictionary*)dict{
    RoamProfileList * profileList=[[RoamProfileList alloc]init];
    [Tool reflectPropertyValueFromDict:profileList dict:dict];
    //判断data数组是否为空，如果不为空则进行遍历赋值
    NSMutableArray * profileArray=[[NSMutableArray alloc]init];
    if (profileList.data!=nil) {
        for(NSDictionary * s_dict in profileList.data){
            [profileArray addObject:[RoamProfile createProfileWithDict:s_dict]];
        }
    }
    //更新data
    profileList.data=profileArray;
    return profileList;
}
@end
