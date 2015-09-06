//
//  RoamHttpBusi.h
//  Roaming
//
//  Created by chendd on 15/8/24.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoamHttpBusi : NSObject
+(void)getOTA:(id)callbackTarget;
+(void)sendFeedBack:(id)callbackTarget feedback:(NSString*)feedback;
+(void)getWlanInfo:(id)callbackTarget;
+(void)getWanInfo:(id)callbackTarget;
+(void)getImgInfo:(id)callbackTarget;
+(void)getSimInfo:(id)callbackTarget;
+(void)getLoginState:(id)callbackTarget;
+(void)getLocale:(id)callbackTarget;
+(void)login:(id)callbackTarget username:(NSString*)username
             password:(NSString*)password;
+(void)getDeviceSlotMode:(id)callbackTarget;
+(void)getProfileList:(id)callbackTarget;
+(void)getCurrentProfile:(id)callbackTarget;
+(void)setWlanInfo:(id)callbackTarget
             wmode:(NSString*)wmode
                 wifi_state:(NSString*)wifi_state
                       ssdi:(NSString*)ssid
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
+(void)logout:(id)callbackTarget;
+(void)getRouterInfo:(id)callbackTarget;
+(void)setRouterInfo:(id)callbackTarget
           host_name:(NSString*)host_name
                       a5_ip_addr:(NSString*)a5_ip_addr
                     sub_net_mask:(NSString*)sub_net_mask
                      enable_dhcp:(NSString*)enable_dhcp
                  dhcp_start_addr:(NSString*)dhcp_start_addr
                    dhcp_end_addr:(NSString*)dhcp_end_addr
                dhcp_release_time:(NSString*)dhcp_release_time;
+(void)getSystemInfo:(id)callbackTarget;
+(void)setLogin:(id)callbackTarget
       username:(NSString*)username
       password:(NSString*)password;
+(void)getSMSStoreState:(id)callbackTarget;
+(void)getSMSPageInfo:(id)callbackTarget;
+(void)getSMSList:(id)callbackTarget pageNum:(NSString*)pageNum;
+(void)getNetworkInfo:(id)callbackTarget;
+(void)getMacFilterInfo:(id)callbackTarget;
+(void)setMacFilterInfo:(id)callbackTarget
          filter_policy:(NSString*)filter_policy
                                address0:(NSString*)address0
                         mac_address_num:(NSString*)mac_address_num;
+(void)register:(id)callbackTarget
    username:(NSString *)username
    password:(NSString*)password;
@end
