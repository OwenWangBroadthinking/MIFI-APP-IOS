//
//  RoamSMSStoreState.h
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoamSMSStoreState : NSObject
+(instancetype)createSMSStoreStateWithDict:(NSDictionary*)dict;
@property (nonatomic, copy) NSString * sms_center_num;
@property (nonatomic, copy) NSString * store_flag;
@property (nonatomic, copy) NSString * used_count;
@property (nonatomic, copy) NSString * total_count;
@property (nonatomic, copy) NSString * sms_is_report;
@property (nonatomic, copy) NSString * error;
@end
