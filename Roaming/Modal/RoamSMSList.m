//
//  RoamSMSList.m
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "RoamSMSList.h"
#import "RoamSMS.h"
#import "Tool.h"
@implementation RoamSMSList
+(instancetype)createSMSListWithDict:(NSDictionary *)dict{
    RoamSMSList * smsList=[[RoamSMSList alloc]init];
    [Tool reflectPropertyValueFromDict:smsList dict:dict];
    NSMutableArray * smsArray=[[NSMutableArray alloc]init];
    if (smsList.data!=nil) {
        for (NSDictionary * s_dict in smsList.data) {
            RoamSMS * sms=[RoamSMS createSMSWithDict:s_dict];
            [smsArray addObject:sms];
        }
    }
    //更新data
    smsList.data=smsArray;
    return smsList;
}
@end
