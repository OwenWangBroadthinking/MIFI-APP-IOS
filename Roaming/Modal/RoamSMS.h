//
//  RoamSMS.h
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoamSMS : NSObject
+(instancetype)createSMSWithDict:(NSDictionary *)dict;
@property (nonatomic, copy) NSString * sms_id;
@property (nonatomic, copy) NSString * sms_tag;
@property (nonatomic, copy) NSString * sms_number;
@property (nonatomic, copy) NSString * sms_time;
@property (nonatomic, copy) NSString * sms_content;
@end
