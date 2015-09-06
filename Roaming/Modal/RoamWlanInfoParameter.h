//
//  RoamWlanInfoParameter.h
//  Roaming
//
//  Created by 陈丁丁 on 15/8/29.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoamWlanInfoParameter : NSObject
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
                                     channel_5g:(NSString*)channel_5g
                                 hidden_ssid_5g:(NSString*)hidden_ssid_5g;

@property (nonatomic, copy) NSString * wmode;
@property (nonatomic, copy) NSString * wifi_state;
@property (nonatomic, copy) NSString * ssid;
@property (nonatomic, copy) NSString * hidden_ssid;
@property (nonatomic, copy) NSString * channel;
@property (nonatomic, copy) NSString * max_numsta;
@property (nonatomic, copy) NSString * security_mode;
@property (nonatomic, copy) NSString * wep_sec;
@property (nonatomic, copy) NSString * wep_key;
@property (nonatomic, copy) NSString * wpa_sec;
@property (nonatomic, copy) NSString * wpa_passphrase;
@property (nonatomic, copy) NSString * ap_status;
@property (nonatomic, copy) NSString * ssid_5g;
@property (nonatomic, copy) NSString * wifi_country_code;
@property (nonatomic, copy) NSString * max_numsta_5g;
@property (nonatomic, copy) NSString * wlan_mode;
@property (nonatomic, copy) NSString * wmode_5g;
@property (nonatomic, copy) NSString * channel_5g;
@property (nonatomic, copy) NSString * hidden_ssid_5g;
@property (nonatomic, strong) NSDictionary * dict;
@end
