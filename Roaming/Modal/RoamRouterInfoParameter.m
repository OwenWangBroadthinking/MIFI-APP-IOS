//
//  RoamRouterInfoParameter.m
//  Roaming
//
//  Created by 陈丁丁 on 15/8/29.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "RoamRouterInfoParameter.h"
#import "Tool.h"
@implementation RoamRouterInfoParameter
+(instancetype)createRouterInfoParameterWithHost_name:(NSString*)host_name
                                           a5_ip_addr:(NSString*)a5_ip_addr
                                         sub_net_mask:(NSString*)sub_net_mask
                                          enable_dhcp:(NSString*)enable_dhcp
                                      dhcp_start_addr:(NSString*)dhcp_start_addr
                                        dhcp_end_addr:(NSString*)dhcp_end_addr
                                    dhcp_release_time:(NSString*)dhcp_release_time{
    RoamRouterInfoParameter * routerInfoParameter=[[RoamRouterInfoParameter alloc]init];
    routerInfoParameter.host_name=host_name;
    routerInfoParameter.a5_ip_addr=a5_ip_addr;
    routerInfoParameter.sub_net_mask=sub_net_mask;
    routerInfoParameter.enable_dhcp=enable_dhcp;
    routerInfoParameter.dhcp_start_addr=dhcp_start_addr;
    routerInfoParameter.dhcp_end_addr=dhcp_end_addr;
    routerInfoParameter.dhcp_release_time=dhcp_release_time;
    routerInfoParameter.dict=[Tool reflectDictFromPropertyValue:routerInfoParameter];
    return routerInfoParameter;
}
@end
