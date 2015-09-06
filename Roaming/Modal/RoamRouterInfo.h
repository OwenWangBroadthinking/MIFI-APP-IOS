//
//  RoamRouterInfo.h
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoamRouterInfo : NSObject
+(instancetype)createRouterInfoWithDict:(NSDictionary*)dict;
@property (nonatomic, copy) NSString * host_name;
@property (nonatomic, copy) NSString * a5_ip_addr;
@property (nonatomic, copy) NSString * sub_net_mask;
@property (nonatomic, copy) NSString * enable_dhcp;
@property (nonatomic, copy) NSString * dhcp_start_addr;
@property (nonatomic, copy) NSString * dhcp_end_addr;
@property (nonatomic, copy) NSString * dhcp_release_time;
@property (nonatomic, copy) NSString * error;
@end
