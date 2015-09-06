//
//  RoamSimInfo.h
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoamSimInfo : NSObject
+(instancetype)createSimInfoWithDict:(NSDictionary*)dict;
@property (nonatomic, copy) NSString * sim_state;
@property (nonatomic, copy) NSString * pin_state;
@property (nonatomic, copy) NSString * pin_puk_times;
@property (nonatomic, copy) NSString * sim_lock_state;
@property (nonatomic, copy) NSString * sim_lock_remain_time;
@property (nonatomic, copy) NSString * error;
@end
