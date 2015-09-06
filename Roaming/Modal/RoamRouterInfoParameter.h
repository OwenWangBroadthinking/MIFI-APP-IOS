//
//  RoamRouterInfoParameter.h
//  Roaming
//
//  Created by 陈丁丁 on 15/8/29.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoamRouterInfoParameter : NSObject
+(instancetype)createRouterInfoParameterWithHost_name:(NSString*)host_name
                                           a5_ip_addr:(NSString*)a5_ip_addr
                                         sub_net_mask:(NSString*)sub_net_mask
                                          enable_dhcp:(NSString*)enable_dhcp
                                      dhcp_start_addr:(NSString*)dhcp_start_addr
                                        dhcp_end_addr:(NSString*)dhcp_end_addr
                                    dhcp_release_time:(NSString*)dhcp_release_time;
@property (nonatomic, copy) NSString * host_name;
@property (nonatomic, copy) NSString * a5_ip_addr;
@property (nonatomic, copy) NSString * sub_net_mask;
@property (nonatomic, copy) NSString * enable_dhcp;
@property (nonatomic, copy) NSString * dhcp_start_addr;
@property (nonatomic, copy) NSString * dhcp_end_addr;
@property (nonatomic, copy) NSString * dhcp_release_time;
@property (nonatomic, strong) NSDictionary * dict;
@end
