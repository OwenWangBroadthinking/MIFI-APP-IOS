//
//  RoamSystemInfo.h
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoamSystemInfo : NSObject
+(instancetype)createSystemInfoWithDict:(NSDictionary*)dict;
@property (nonatomic, copy) NSString * dev_mac;
@property (nonatomic, copy) NSString * soft_ver;
@property (nonatomic, copy) NSString * hard_ver;
@property (nonatomic, copy) NSString * webui_ver;
@property (nonatomic, copy) NSString * dev_name;
@property (nonatomic, copy) NSString * dev_imei;
@property (nonatomic, copy) NSString * dev_msisdn;
@property (nonatomic, copy) NSString * error;
@end
