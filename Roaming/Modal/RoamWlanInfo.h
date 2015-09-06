//
//  RoamWlanInfo.h
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoamWlanInfo : NSObject
+(instancetype)createWlanInfoWithDict:(NSDictionary*)dict;
@property (nonatomic, copy) NSString * wifi_state;
@property (nonatomic, copy) NSString * wlan_mode;
@property (nonatomic, copy) NSString * wmode;
@property (nonatomic, copy) NSString * wmode_5g;
@property (nonatomic, copy) NSString * ssid;
@property (nonatomic, copy) NSString * ssid_5g;
@property (nonatomic, copy) NSString * hidden_ssid;
@property (nonatomic, copy) NSString * hidden_ssid_5g;
@property (nonatomic, copy) NSString * channel;
@property (nonatomic, copy) NSString * channel_5g;
@property (nonatomic, copy) NSString * max_numsta;
@property (nonatomic, copy) NSString * max_numsta_5g;
@property (nonatomic, copy) NSString * curr_num;
@property (nonatomic, copy) NSString * security_mode;
@property (nonatomic, copy) NSString * wep_sec;
@property (nonatomic, copy) NSString * wep_key;
@property (nonatomic, copy) NSString * wpa_sec;
@property (nonatomic, copy) NSString * wpa_passphrase;
@property (nonatomic, copy) NSString * wifi_country_code;
@property (nonatomic, copy) NSString * ap_status;
@property (nonatomic, copy) NSString * error;
@end
