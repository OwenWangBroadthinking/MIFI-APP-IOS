//
//  RoamWlanInfoParameter.m
//  Roaming
//
//  Created by 陈丁丁 on 15/8/29.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "RoamWlanInfoParameter.h"
#import "Tool.h"
@implementation RoamWlanInfoParameter
+(instancetype)createWlanInfoParameterWithWmode:(NSString*)wmode
                                     wifi_state:(NSString*)wifi_state
                                           ssid:(NSString*)ssid
                                    hidden_ssid:(NSString*)hidden_ssid
                                        channel:(NSString*)channel
                                     max_numsta:(NSString*)max_numsta
                                  security_mode:(NSString*)security_mode
                                        wep_sec:(NSString*)wep_sec
                                        wep_key:(NSString*)wep_key
                                        wpa_sec:(NSString*)wpa_sec
                                 wpa_passphrase:(NSString*)wpa_passphrase
                                      ap_status:(NSString*)ap_status
                                        ssid_5g:(NSString*)ssid_5g
                              wifi_country_code:(NSString*)wifi_country_code
                                  max_numsta_5g:(NSString*)max_numsta_5g
                                      wlan_mode:(NSString*)wlan_mode
                                       wmode_5g:(NSString*)wmode_5g
                                     channel_5g:(NSString *)channel_5g
                                 hidden_ssid_5g:(NSString*)hidden_ssid_5g{
    RoamWlanInfoParameter * wlanInfoParameter=[[RoamWlanInfoParameter alloc]init];
    wlanInfoParameter.wmode=wmode;
    wlanInfoParameter.wifi_state=wifi_state;
    wlanInfoParameter.ssid=ssid;
    wlanInfoParameter.hidden_ssid=hidden_ssid;
    wlanInfoParameter.channel=channel;
    wlanInfoParameter.max_numsta=max_numsta;
    wlanInfoParameter.security_mode=security_mode;
    wlanInfoParameter.wep_sec=wep_sec;
    wlanInfoParameter.wep_key=wep_key;
    wlanInfoParameter.wpa_sec=wpa_sec;
    wlanInfoParameter.wpa_passphrase=wpa_passphrase;
    wlanInfoParameter.ap_status=ap_status;
    wlanInfoParameter.ssid_5g=ssid_5g;
    wlanInfoParameter.wifi_country_code=wifi_country_code;
    wlanInfoParameter.max_numsta_5g=max_numsta_5g;
    wlanInfoParameter.wlan_mode=wlan_mode;
    wlanInfoParameter.wmode_5g=wmode_5g;
    wlanInfoParameter.channel_5g=channel_5g;
    wlanInfoParameter.hidden_ssid_5g=hidden_ssid_5g;
    wlanInfoParameter.dict=[Tool reflectDictFromPropertyValue:wlanInfoParameter];
    return wlanInfoParameter;
}
@end
