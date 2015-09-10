//
//  RoamImgInfo.h
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoamImgInfo : NSObject
+(instancetype)createImgInfoWithDict:(NSDictionary*)dict;
@property (nonatomic, copy) NSString * chg_state;
@property (nonatomic, copy) NSNumber * bat_level;
@property (nonatomic, copy) NSString * signal;
@property (nonatomic, copy) NSString * sim_state;
@property (nonatomic, copy) NSString * pin_state;
@property (nonatomic, copy) NSString * sms;
@property (nonatomic, copy) NSString * sms_new_count;
@property (nonatomic, copy) NSString * error;
@end
