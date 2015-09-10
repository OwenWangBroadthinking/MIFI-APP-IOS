//
//  RoamWanInfo.h
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoamWanInfo : NSObject
+(instancetype)createWanInfoWithDict:(NSDictionary *)dict;
@property (nonatomic, copy) NSString * wan_state;
@property (nonatomic, copy) NSString * wan_ip;
@property (nonatomic, copy) NSString * wan_ip6;
@property (nonatomic, copy) NSString * network_type;
@property (nonatomic, copy) NSString * network_name;
@property (nonatomic, copy) NSString * roam;
@property (nonatomic, copy) NSString * dur_time;
@property (nonatomic, copy) NSString * download;
@property (nonatomic, copy) NSString * upload;
@property (nonatomic, copy) NSNumber * usage;
@property (nonatomic, copy) NSString * error;
@end
