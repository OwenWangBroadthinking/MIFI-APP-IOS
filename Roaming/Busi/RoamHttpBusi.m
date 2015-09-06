//
//  RoamHttpBusi.m
//  Roaming
//
//  Created by chendd on 15/8/24.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "RoamHttpBusi.h"
#import "AppDefines.h"
#import "DDHttpClient.h"
#import "RoamRAC.h"
#import "DDString.h"
#import "Tool.h"
#import "RoamLoginParameter.h"
#import "RoamWlanInfoParameter.h"
#import "RoamRouterInfoParameter.h"
#import "DDBase64.h"
#import "DDOpenSSL.h"
#import "DDAES.h"
@implementation RoamHttpBusi
//获取在线更新信息
+(void)getOTA:(id)callbackTarget{
    NSString * fid=[[NSUserDefaults standardUserDefaults] valueForKey:KEY_FID];
    if (fid==nil) {//当fid不存在时，默认为0
        fid=@"0";
    }
    NSDictionary * dict=[[NSDictionary alloc]initWithObjectsAndKeys:fid,@"fid", nil];
    [[DDHttpClient createHttpClient]getDataFromURL:App_OTA parameters:dict dataCallBack:^(NSData *data) {
        if (data==nil) {
            [Tool showAlertWithMessage:@"获取OTA失败"];
        }else{
            NSDictionary * dict=(NSDictionary*)data;
            [RoamRAC sharedRoamRAC].OTAInfo=dict;
            if ([callbackTarget respondsToSelector:@selector(roamRAC:OTAInfo:)]) {
                [callbackTarget roamRAC:[RoamRAC sharedRoamRAC] OTAInfo:dict];
            }
        }
    }];
}
//发送意见反馈
+(void)sendFeedBack:(id)callbackTarget feedback:(NSString *)feedback{
    NSString * phone_no=[[NSUserDefaults standardUserDefaults]valueForKey:KEY_BINDPHONENUMBER];
    if(phone_no==nil){
        [Tool showAlertWithMessage:@"手机号为空"];
        return;
    }
    
    if (feedback==nil||feedback.length<5||feedback.length>255) {
        [Tool showAlertWithMessage:@"内容长度为5～255字节"];
        return;
    }
    NSString * time=[Tool getTime];
    NSString * source=@"1";
    NSString * belonging=@"1";
    NSString * fid=[[NSUserDefaults standardUserDefaults] valueForKey:KEY_FID];
    if (fid==nil) {//当fid不存在时，默认为0
        fid=@"0";
    }
    NSDictionary * dict=[[NSDictionary alloc]initWithObjectsAndKeys:
                         phone_no,@"phone_no",
                         feedback,@"feedback_content",
                         time,@"time",
                         source,@"source",
                         belonging,@"belonging",
                         fid,@"fid",
                         nil];
    [[DDHttpClient createHttpClient] postDataToURL:App_FeedBack parameters:dict dataCallBack:^(id data) {
        if (data==nil) {
            [Tool showAlertWithMessage:@"反馈意见失败"];
        }else{
            [RoamRAC sharedRoamRAC].feedBackInfo=data;
            if ([callbackTarget respondsToSelector:@selector(roamRAC:feedBackInfo:)]) {
                [callbackTarget roamRAC:[RoamRAC sharedRoamRAC] feedBackInfo:data];
            }
        }
    }];
}
//获取Wlan信息
+(void)getWlanInfo:(id)callbackTarget{
    [[DDHttpClient createHttpClient] getDataFromURL:HTTP_GetWlanInfo parameters:nil dataCallBack:^(id data) {
        if (data==nil) {
            [Tool showAlertWithMessage:@"读取Wlan信息失败"];
        }else{
            NSDictionary * dict=data;
            RoamWlanInfo* wlanInfo=  [RoamWlanInfo createWlanInfoWithDict:dict];
            [RoamRAC sharedRoamRAC].wlanInfo=wlanInfo;
            if ([callbackTarget respondsToSelector:@selector(roamRAC:wlanInfo:)]) {
                [callbackTarget roamRAC:[RoamRAC sharedRoamRAC] wlanInfo:wlanInfo];
            }
        }
        
    }];
}
//获取Wan信息
+(void)getWanInfo:(id)callbackTarget{
    [[DDHttpClient createHttpClient] getDataFromURL:HTTP_GetWanInfo parameters:nil dataCallBack:^(id data) {
        if (data==nil) {
            [Tool showAlertWithMessage:@"读取Wan信息失败"];
        }else{
            NSDictionary * dict=data;
            RoamWanInfo * wanInfo=[RoamWanInfo createWanInfoWithDict:dict];
            [RoamRAC sharedRoamRAC].wanInfo=wanInfo;
            if ([callbackTarget respondsToSelector:@selector(roamRAC:wanInfo:)]) {
                [callbackTarget roamRAC:[RoamRAC sharedRoamRAC] wanInfo:wanInfo];
            }
        }
        
    }];
}
//获取固件信息
+(void)getImgInfo:(id)callbackTarget{
    [[DDHttpClient createHttpClient] getDataFromURL:HTTP_GetImgInfo parameters:nil dataCallBack:^(id data) {
        if (data==nil) {
            [Tool showAlertWithMessage:@"读取Img信息失败"];
        }else{
            NSDictionary * dict=data;
            RoamImgInfo * imgInfo=[RoamImgInfo createImgInfoWithDict:dict];
            [RoamRAC sharedRoamRAC].imgInfo=imgInfo;
            if ([callbackTarget respondsToSelector:@selector(roamRAC:imgInfo:)]) {
                [callbackTarget roamRAC:[RoamRAC sharedRoamRAC] imgInfo:imgInfo];
            }
        }
    }];
}
//获取SIM卡信息
+(void)getSimInfo:(id)callbackTarget{
    [[DDHttpClient createHttpClient] getDataFromURL:HTTP_GetSimInfo parameters:nil dataCallBack:^(id data) {
        if (data==nil) {
            [Tool showAlertWithMessage:@"读取Sim信息失败"];
        }else{
            NSDictionary * dict=data;
            RoamSimInfo* simInfo= [RoamSimInfo createSimInfoWithDict:dict];
            [RoamRAC sharedRoamRAC].simInfo=simInfo;
            if ([callbackTarget respondsToSelector:@selector(roamRAC:simInfo:)]) {
                [callbackTarget roamRAC:[RoamRAC sharedRoamRAC] simInfo:simInfo];
            }
        }
    }];
}
//获取登陆状态
+(void)getLoginState:(id)callbackTarget{
    [[DDHttpClient createHttpClient] getDataFromURL:HTTP_GetLoginState parameters:nil dataCallBack:^(id data) {
        if (data==nil) {
            [Tool showAlertWithMessage:@"读取LoginState失败"];
        }else{
            NSDictionary * dict=data;
            RoamLoginState * loginState=[RoamLoginState createLoginStateWithDict:dict];
            [RoamRAC sharedRoamRAC].loginState=loginState;
            if ([callbackTarget respondsToSelector:@selector(roamRAC:loginState:)]) {
                [callbackTarget roamRAC:[RoamRAC sharedRoamRAC] loginState:loginState];
            }
        }
    }];
}
//获取Mifi当前语言
+(void)getLocale:(id)callbackTarget{
    [[DDHttpClient createHttpClient]getDataFromURL:HTTP_GetLocale parameters:nil dataCallBack:^(id data) {
        if (data==nil) {
            [Tool showAlertWithMessage:@"读取Mifi当前语言失败"];
        }else{
            NSDictionary * dict=data;
            RoamLocale * locale=[RoamLocale createLocaleWithDict:dict];
            [RoamRAC sharedRoamRAC].locale=locale;
            if ([callbackTarget respondsToSelector:@selector(roamRAC:locale:)]) {
                [callbackTarget roamRAC:[RoamRAC sharedRoamRAC] locale:locale];
            }
        }
    }];
}
//获取登陆回应
+(void)login:(id)callbackTarget username:(NSString *)username password:(NSString *)password{
    RoamLoginParameter * loginParameter=[RoamLoginParameter createLoginParameterWithUserName:username andPassword:password];
    [[DDHttpClient createHttpClient]postDataToURL:HTTP_SetLogin parameters:loginParameter.dict dataCallBack:^(id data) {
        if (data==nil) {
            [Tool showAlertWithMessage:@"登陆失败"];
        }else{
            NSDictionary * dict=data;
            RoamLoginReply * loginReply=[RoamLoginReply createLoginReplyWithDict:dict];
            [RoamRAC sharedRoamRAC].loginReply=loginReply;
            if ([callbackTarget respondsToSelector:@selector(roamRAC:loginReply:)]) {
                [callbackTarget roamRAC:[RoamRAC sharedRoamRAC] loginReply:loginReply];
            }
        }
    }];
}
//获取DeviceSlot模式
+(void)getDeviceSlotMode:(id)callbackTarget{
    [[DDHttpClient createHttpClient]getDataFromURL:HTTP_GetDeviceSlot parameters:nil dataCallBack:^(id data) {
        if (data==nil) {
            [Tool showAlertWithMessage:@"获取DeviceSlot模式失败"];
        }else{
            NSDictionary * dict=data;
            RoamDeviceSlotMode *deviceSlotMode=[RoamDeviceSlotMode createDeviceSlotModeWithDict:dict];
            [RoamRAC sharedRoamRAC].deviceSlotMode=deviceSlotMode;
            if ([callbackTarget respondsToSelector:@selector(roamRAC:deviceSlotMode:)]) {
                [callbackTarget roamRAC:[RoamRAC sharedRoamRAC] deviceSlotMode:deviceSlotMode];
            }
        }
    }];
}
//获取Profile列表
+(void)getProfileList:(id)callbackTarget{
    [[DDHttpClient createHttpClient]getDataFromURL:HTTP_GetProfileList parameters:nil dataCallBack:^(id data) {
        if (data==nil) {
            [Tool showAlertWithMessage:@"读取Profile列表失败"];
        }else{
            NSDictionary * dict=data;
            RoamProfileList* profileList= [RoamProfileList createProfileListWithDict:dict];
            [RoamRAC sharedRoamRAC].profileList=profileList;
            if ([callbackTarget respondsToSelector:@selector(roamRAC:profileList:)]) {
                [callbackTarget roamRAC:[RoamRAC sharedRoamRAC] profileList:profileList];
            }
        }
    }];
}
//获取Mifi Profile
+(void)getCurrentProfile:(id)callbackTarget{
    [[DDHttpClient createHttpClient]getDataFromURL:HTTP_GetCurrentProfile parameters:nil dataCallBack:^(id data) {
        if (data==nil) {
            [Tool showAlertWithMessage:@"读取当前Profile失败"];
        }else{
            NSDictionary * dict=data;
            RoamCurrentProfile *currentProfile=[RoamCurrentProfile createCurrentProfileWithDict:dict];
            [RoamRAC sharedRoamRAC].currentProfile=currentProfile;
            if ([callbackTarget respondsToSelector:@selector(roamRAC:currentProfile:)]) {
                [callbackTarget roamRAC:[RoamRAC sharedRoamRAC] currentProfile:currentProfile];
            }
        }
    }];
}
//设置wlan信息
+(void)setWlanInfo:(id)callbackTarget wmode:(NSString *)wmode wifi_state:(NSString *)wifi_state ssdi:(NSString *)ssid hidden_ssid:(NSString *)hidden_ssid channel:(NSString *)channel max_numsta:(NSString *)max_numsta security_mode:(NSString *)security_mode wep_sec:(NSString *)wep_sec wep_key:(NSString *)wep_key wpa_sec:(NSString *)wpa_sec wpa_passphrase:(NSString *)wpa_passphrase ap_status:(NSString *)ap_status ssid_5g:(NSString *)ssid_5g wifi_country_code:(NSString *)wifi_country_code max_numsta_5g:(NSString *)max_numsta_5g wlan_mode:(NSString *)wlan_mode wmode_5g:(NSString *)wmode_5g channel_5g:(NSString *)channel_5g hidden_ssid_5g:(NSString *)hidden_ssid_5g{
    RoamWlanInfoParameter * wlanInfoParameter= [RoamWlanInfoParameter createWlanInfoParameterWithWmode:wmode wifi_state:wifi_state ssid:ssid hidden_ssid:hidden_ssid channel:channel max_numsta:max_numsta security_mode:security_mode wep_sec:wep_sec wep_key:wep_key wpa_sec:wpa_sec wpa_passphrase:wpa_passphrase ap_status:ap_status ssid_5g:ssid_5g wifi_country_code:wifi_country_code max_numsta_5g:max_numsta_5g wlan_mode:wlan_mode wmode_5g:wmode_5g channel_5g:channel_5g hidden_ssid_5g:hidden_ssid_5g];
    [[DDHttpClient createHttpClient]postDataToURL:HTTP_SetWlanInfo parameters:wlanInfoParameter.dict dataCallBack:^(id data) {
        if (data==nil) {
            [Tool showAlertWithMessage:@"设置Wlan信息失败"];
        }else{
            NSDictionary * dict=data;
            NSString * error= [dict objectForKey:@"error"];
            NSNumber * setWlanInfoState=[NSNumber numberWithInt:-1];
            if (error!=nil) {
                [RoamRAC sharedRoamRAC].setWlanInfoState=[NSNumber numberWithInt:(int)[DDString strtoul:error]];
            }
            [RoamRAC sharedRoamRAC].setWlanInfoState=setWlanInfoState;
            if ([callbackTarget respondsToSelector:@selector(roamRAC:setWlanInfoState:)]) {
                [callbackTarget roamRAC:[RoamRAC sharedRoamRAC] setWlanInfoState:setWlanInfoState];
            }
        }
    }];
}
+(void)logout:(id)callbackTarget{
    [[DDHttpClient createHttpClient]postDataToURL:HTTP_SetLogout parameters:@{@"some":@"a"} dataCallBack:^(id data) {
        if (data==nil) {
            [Tool showAlertWithMessage:@"注销失败"];
        }else{
            NSDictionary * dict=data;
            NSString * error= [dict objectForKey:@"error"];
            NSNumber * logoutState=[NSNumber numberWithInt:-1];
            if (error!=nil) {
                logoutState=[NSNumber numberWithInt:(int)[DDString strtoul:error]];
            }
            [RoamRAC sharedRoamRAC].logoutState=logoutState;
            if ([callbackTarget respondsToSelector:@selector(roamRAC:logoutState:)]) {
                [callbackTarget roamRAC:[RoamRAC sharedRoamRAC] logoutState:logoutState];
            }
        }
    }];
}
+(void)getRouterInfo:(id)callbackTarget{
    [[DDHttpClient createHttpClient]getDataFromURL:HTTP_GetRouterInfo parameters:nil dataCallBack:^(id data) {
        if (data==nil) {
            [Tool showAlertWithMessage:@"获取路由信息失败"];
        }else{
            NSDictionary * dict=data;
            RoamRouterInfo * routerInfo=[RoamRouterInfo createRouterInfoWithDict:dict];
            [RoamRAC sharedRoamRAC].routerInfo=routerInfo;
            if ([callbackTarget respondsToSelector:@selector(roamRAC:routerInfo:)]) {
                [callbackTarget roamRAC:[RoamRAC sharedRoamRAC] routerInfo:routerInfo];
            }
        }
    }];
}
+(void)setRouterInfo:(id)callbackTarget host_name:(NSString *)host_name a5_ip_addr:(NSString *)a5_ip_addr sub_net_mask:(NSString *)sub_net_mask enable_dhcp:(NSString *)enable_dhcp dhcp_start_addr:(NSString *)dhcp_start_addr dhcp_end_addr:(NSString *)dhcp_end_addr dhcp_release_time:(NSString *)dhcp_release_time{
    RoamRouterInfoParameter * routerInfoParameter=[RoamRouterInfoParameter createRouterInfoParameterWithHost_name:host_name a5_ip_addr:a5_ip_addr sub_net_mask:sub_net_mask enable_dhcp:enable_dhcp dhcp_start_addr:dhcp_start_addr dhcp_end_addr:dhcp_end_addr dhcp_release_time:dhcp_release_time];
    [[DDHttpClient createHttpClient]postDataToURL:HTTP_SetRouterInfo parameters:routerInfoParameter.dict dataCallBack:^(id data) {
        if (data==nil) {
            [Tool showAlertWithMessage:@"设置路由信息失败"];
        }else{
            NSDictionary * dict=data;
            NSString * error= [dict objectForKey:@"error"];
            NSNumber * setRouterInfoState=[NSNumber numberWithInt:-1];
            if (error!=nil) {
                setRouterInfoState=[NSNumber numberWithInt:(int)[DDString strtoul:error]];
            }
            [RoamRAC sharedRoamRAC].setRouterInfoState=setRouterInfoState;
            if ([callbackTarget respondsToSelector:@selector(roamRAC:setRouterInfoState:)]) {
                [callbackTarget roamRAC:[RoamRAC sharedRoamRAC] setRouterInfoState:setRouterInfoState];
            }
        }
    }];
}
+(void)getSystemInfo:(id)callbackTarget{
    [[DDHttpClient createHttpClient]getDataFromURL:HTTP_GetSystemInfo parameters:nil dataCallBack:^(id data) {
        if (data==nil) {
            [Tool showAlertWithMessage:@"读取系统信息失败"];
        }else{
            NSDictionary * dict=data;
            RoamSystemInfo * systemInfo=[RoamSystemInfo createSystemInfoWithDict:dict];
            [RoamRAC sharedRoamRAC].systemInfo=systemInfo;
            if ([callbackTarget respondsToSelector:@selector(roamRAC:systemInfo:)]) {
                [callbackTarget roamRAC:[RoamRAC sharedRoamRAC] systemInfo:systemInfo];
            }
        }
    }];
}
+(void)setLogin:(id)callbackTarget username:(NSString *)username password:(NSString *)password{
    [[DDHttpClient createHttpClient]postDataToURL:HTTP_SetUserNameAndPW parameters:@{@"newPassword":password,@"newUsername":username} dataCallBack:^(id data) {
        if (data==nil) {
            [Tool showAlertWithMessage:@"设置用户名密码失败"];
        }else{
            NSDictionary * dict=data;
            NSString * error= [dict objectForKey:@"error"];
            NSNumber * setUsernameAndPWState=[NSNumber numberWithInt:-1];
            if (error!=nil) {
                setUsernameAndPWState=[NSNumber numberWithInt:(int)[DDString strtoul:error]];
            }
            [RoamRAC sharedRoamRAC].setUsernameAndPWState=setUsernameAndPWState;
            if ([callbackTarget respondsToSelector:@selector(roamRAC:setUsernameAndPWState:)]) {
                [callbackTarget roamRAC:[RoamRAC sharedRoamRAC] setUsernameAndPWState:setUsernameAndPWState];
            }
        }
    }];
}
+(void)getSMSStoreState:(id)callbackTarget{
    [[DDHttpClient createHttpClient]postDataToURL:HTTP_GetSMSStoreState parameters:@{@"d":@"1"} dataCallBack:^(id data) {
        if (data==nil) {
            [Tool showAlertWithMessage:@"获取SMS存储状态失败"];
        }else{
            NSDictionary * dict=data;
            RoamSMSStoreState *smsStoreState=[RoamSMSStoreState createSMSStoreStateWithDict:dict];
            [RoamRAC sharedRoamRAC].smsStoreState=smsStoreState;
            if ([callbackTarget respondsToSelector:@selector(roamRAC:smsStoreState:)]) {
                [callbackTarget roamRAC:[RoamRAC sharedRoamRAC] smsStoreState:smsStoreState];
            }
        }
    }];
}
+(void)getSMSPageInfo:(id)callbackTarget{
    [[DDHttpClient createHttpClient]postDataToURL:HTTP_GetSMSPageInfo parameters:@{@"d":@"1"}  dataCallBack:^(id data) {
        if (data==nil) {
            [Tool showAlertWithMessage:@"获取SMS页面信息失败"];
        }else{
            NSDictionary * dict=data;
            RoamSMSPageInfo *smsPageInfo=[RoamSMSPageInfo createSMSPageInfoWithDict:dict];
            [RoamRAC sharedRoamRAC].smsPageInfo=smsPageInfo;
            if ([callbackTarget respondsToSelector:@selector(roamRAC:smsPageInfo:)]) {
                [callbackTarget roamRAC:[RoamRAC sharedRoamRAC] smsPageInfo:smsPageInfo];
            }
        }
    }];
}
+(void)getSMSList:(id)callbackTarget pageNum:(NSString *)pageNum{
    [[DDHttpClient createHttpClient]postDataToURL:HTTP_GetSMSList parameters:@{@"key":@"inbox",@"pageNum":pageNum} dataCallBack:^(id data) {
        if (data==nil) {
            [Tool showAlertWithMessage:@"获取SMS列表失败"];
        }else{
            NSDictionary * dict=data;
            RoamSMSList * smsList=[RoamSMSList createSMSListWithDict:dict];
            [RoamRAC sharedRoamRAC].smsList=smsList;
            if ([callbackTarget respondsToSelector:@selector(roamRAC:smsList:)]) {
                [callbackTarget roamRAC:[RoamRAC sharedRoamRAC] smsList:smsList];
            }
        }
    }];
}
+(void)getNetworkInfo:(id)callbackTarget{
    [[DDHttpClient createHttpClient]postDataToURL:HTTP_GetNetworkInfo parameters:@{@"d":@"1"} dataCallBack:^(id data) {
        if (data==nil) {
            [Tool showAlertWithMessage:@"获取网络信息失败"];
        }else{
            NSDictionary * dict=data;
            RoamNetworkInfo * networkInfo=[RoamNetworkInfo createNetworkInfoWithDict:dict];
            [RoamRAC sharedRoamRAC].networkInfo=networkInfo;
            if ([callbackTarget respondsToSelector:@selector(roamRAC:networkInfo:)]) {
                [callbackTarget roamRAC:[RoamRAC sharedRoamRAC] networkInfo:networkInfo];
            }
        }
    }];
}
+(void)getMacFilterInfo:(id)callbackTarget{
    [[DDHttpClient createHttpClient]postDataToURL:HTTP_GetMACFilterInfo parameters:@{@"d":@"1"} dataCallBack:^(id data) {
        if (data==nil) {
            [Tool showAlertWithMessage:@"获取Mac过滤列表失败"];
        }else{
            NSDictionary * dict=data;
            RoamMacFilterInfo * macFilterInfo= [RoamMacFilterInfo createMacFilterInfoWithDict:dict];
            [RoamRAC sharedRoamRAC].macFilterInfo=macFilterInfo;
            if ([callbackTarget respondsToSelector:@selector(roamRAC:macFilterInfo:)]) {
                [callbackTarget roamRAC:[RoamRAC sharedRoamRAC] macFilterInfo:macFilterInfo];
            }
        }
    }];
}
+(void)setMacFilterInfo:(id)callbackTarget filter_policy:(NSString *)filter_policy address0:(NSString *)address0 mac_address_num:(NSString *)mac_address_num{
    [[DDHttpClient createHttpClient] postDataToURL:HTTP_SetMACFilterInfo parameters:@{@"filter_policy":filter_policy,@"address0":address0,@"mac_address_num":mac_address_num} dataCallBack:^(id data) {
        if (data==nil) {
            [Tool showAlertWithMessage:@"设置Mac过滤列表失败"];
        }else{
            NSDictionary * dict=data;
            NSString * error= [dict objectForKey:@"error"];
            NSNumber *setMacFilterInfoState=[NSNumber numberWithInt:-1];
            if (error!=nil) {
                setMacFilterInfoState=[NSNumber numberWithInt:(int)[DDString strtoul:error]];
            }
            [RoamRAC sharedRoamRAC].setMacFilterInfoState=setMacFilterInfoState;
            if ([callbackTarget respondsToSelector:@selector(roamRAC:setMacFilterInfoState:)]) {
                [callbackTarget roamRAC:[RoamRAC sharedRoamRAC] setMacFilterInfoState:setMacFilterInfoState];
            }
        }
    }];
}
+(NSData *)sort_Data:(NSData*)data{
    NSMutableArray * arr=[[NSMutableArray alloc]init];
    for (int i=0; i<data.length; i++) {
        NSData * data_i=[NSData dataWithBytes:[data bytes]+i length:1];
        [arr addObject:data_i];
    }
    NSArray * sort_arr=[arr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        const unsigned char * p1=[obj1 bytes];
        const unsigned char * p2=[obj2 bytes];
        NSNumber * number1=[NSNumber numberWithUnsignedChar:p1[0]];
        NSNumber * number2=[NSNumber numberWithUnsignedChar:p2[0]];
        NSComparisonResult result = [number1 compare:number2];
        return result == NSOrderedDescending;
    }];
    NSMutableData * sort_Data=[[NSMutableData alloc]init];
    for (int i=0; i<sort_arr.count; i++) {
        [sort_Data appendData:[sort_arr objectAtIndex:i] ];
    }
    return sort_Data;
}
+(NSString *)getTempKeyWithTime:(NSString*)time
                          rand1:(NSString*)rand1
                          rand2:(NSString*)rand2{
    NSString * time_b64=[DDBase64 Encrypt:[time dataUsingEncoding:NSUTF8StringEncoding]];
    //    NSLog(@"time_b64=%@",time_b64);
    NSString * rand1_b64=[DDBase64 Encrypt:[rand1 dataUsingEncoding:NSUTF8StringEncoding]];
    //    NSLog(@"rand1_b64=%@",rand1_b64);
    NSString * timeAndRand1=[NSString stringWithFormat:@"%@%@",time_b64,rand1_b64];
    //    NSLog(@"timeAndRand1=%@",timeAndRand1);
    NSData * sort_data=[self sort_Data:[timeAndRand1 dataUsingEncoding:NSUTF8StringEncoding]];
    //    NSLog(@"sort_str=%@",[[NSString alloc] initWithData:sort_data encoding:NSUTF8StringEncoding] );
    NSString * sort_str_md5=[DDOpenSSL Md5:sort_data];
    //    NSLog(@"md5=%@",sort_str_md5);
    NSString * left8=[DDString substr:sort_str_md5 start:0 length:16];
    NSString * right8=[DDString substr:sort_str_md5 start:16 length:16];
    NSData* left8_aes= [DDAES encrypt:[DDString dataFromHexString:left8] key:rand2];
    NSData* right8_aes=[DDAES encrypt:[DDString dataFromHexString:right8] key:rand2];
    //    NSLog(@"left8=%@",left8);
    //    NSLog(@"right8=%@",right8);
    NSString * left8_aes_str=[DDString hexStringFromData:left8_aes];
    NSString * right8_aes_str=[DDString hexStringFromData:right8_aes];
    //    NSLog(@"left8_aec=%@",left8_aes_str);
    //    NSLog(@"right8_aec=%@",right8_aes_str);
    NSString * aes_padding=[NSString stringWithFormat:@"%@%@",left8_aes_str,right8_aes_str];
    NSData * aes_sort_data= [self sort_Data:[DDString dataFromHexString:aes_padding ]];
    NSString * aes_sort_string=[DDString hexStringFromData:aes_sort_data];
    //    NSLog(@"aes_sort_string=%@",aes_sort_string);
    NSString * temp_key= [[DDOpenSSL Md5:[[aes_sort_string lowercaseString] dataUsingEncoding:NSUTF8StringEncoding] ] lowercaseString];
    //    NSLog(@"temp_key=%@",temp_key);
    return temp_key;
}
+(NSString*)encryptWithTempKey:(NSString*)content tempKey:(NSString*)tempKey{
//    NSString * content=@"13810091001";
    NSString * content_b64= [DDBase64 Encrypt:[content dataUsingEncoding:NSUTF8StringEncoding]];
//    NSLog(@"content_b64=%@",content_b64);
    NSData * content_aes=[DDAES encrypt:[content_b64 dataUsingEncoding:NSUTF8StringEncoding] datakey:[DDString dataFromHexString:tempKey]];
    NSString * encryptContent=[[DDString hexStringFromData:content_aes] lowercaseString];
//    NSLog(@"content_aes=%@",encryptContent);
    return encryptContent;
}
+(void)register:(id)callbackTarget username:(NSString *)username password:(NSString *)password{
//    username=@"13644368536";
//    password=@"12345678";
    NSString * time=[Tool getISOTime];
    NSString * rand1=[Tool getRandomString16];
    NSString * rand2=[Tool getRandomString16];
    NSLog(@"time=%@ rand1=%@ rand2=%@",time,rand1,rand2);
//    time=@"2015-08-31T10:46:14+0800";
//    rand1=@"EIKG3RMXHZX7NIXP";
//    rand2=@"FZEOSTDEZMKDUNK4";
    NSString * tempkey=[self getTempKeyWithTime:time rand1:rand1 rand2:rand2];
    NSString * encrypt_username=[self encryptWithTempKey:username tempKey:tempkey];
    NSString * encrypt_password=[self encryptWithTempKey:password tempKey:tempkey];
    NSLog(@"encrypt_username=%@, encrypt_password=%@",encrypt_username,encrypt_password);
    [[DDHttpClient createHttpClient] postDataToURL:App_Register
                                        parameters:@{@"time":time,
                                                     @"username":encrypt_username,
                                                     @"password":encrypt_password,
                                                     @"rand1":rand1,
                                                     @"rand2":rand2,
                                                     @"_elapsed":@0}
      dataCallBack:^(id data) {
        if (data==nil) {
            [Tool showAlertWithMessage:@"注册用户失败"];
        }else{
            NSDictionary * dict=data;
            RoamRegisterReply* registerReply=[RoamRegisterReply createRegistorReplyWithDict:dict];
            [RoamRAC sharedRoamRAC].registerReply=registerReply;
            if([callbackTarget respondsToSelector:@selector(roamRAC:registerReply:)]){
                [callbackTarget roamRAC:[RoamRAC sharedRoamRAC] registerReply:registerReply];
            }
        }
    }];
}
@end
