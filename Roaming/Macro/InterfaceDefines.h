//
//  InterfaceDefines.h
//  Roaming
//
//  Created by chendd on 15/8/24.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#ifndef Roaming_InterfaceDefines_h
#define Roaming_InterfaceDefines_h
//检测网络是否联通可以访问此网址
#define Cloud_Server @"www.siicloud.com"
//FID是程序版本代号，未知情况下为0
#define App_OTA @"http://www.siicloud.com/RoamingCloud/app/cloud/ota"
#define App_FeedBack @"http://www.siicloud.com/RoamingCloud/user_feedback"
#define App_Register @"http://www.siicloud.com/RoamingCloud/app/cloud/regist"
//UDP协议
#define UDP_GetBindState @"50"
#define UDP_GetBindStateReply @"51"
#define UDP_Bind @"52"
#define UDP_BindReply @"53"
#define UDP_Disbind @"54"
#define UDP_DisbindReply @"55"
#define UDP_Activate @"56"
#define UDP_ActivateReply @"57"
#define UDP_GetMifiMac @"58"
#define UDP_GetMifiMacReply @"59"
#define UDP_GetMifiVersion @"5A"
#define UDP_GetMifiVersionReply @"5B"
#define UDP_GetUsedFlow @"5C"
#define UDP_GetUsedFlowReply @"5D"
//HTTP协议
#define HTTP_GetWlanInfo        [Tool replaceArgs:@"http://192.168.1.1/goform/getWlanInfo?rand=RANDOM"]
#define HTTP_GetWanInfo         [Tool replaceArgs:@"http://192.168.1.1/goform/getWanInfo?rand=RANDOM"]
#define HTTP_GetImgInfo         [Tool replaceArgs:@"http://192.168.1.1/goform/getImgInfo?rand=RANDOM"]
#define HTTP_GetSimInfo         [Tool replaceArgs:@"http://192.168.1.1/goform/getSimcardInfo?rand=RANDOM"]
#define HTTP_GetLoginState      [Tool replaceArgs:@"http://192.168.1.1/goform/getLoginState?rand=RANDOM"]
#define HTTP_GetLocale          [Tool replaceArgs:@"http://192.168.1.1/goform/getCurrentLanguage?rand=RANDOM"]
#define HTTP_SetLogin           [Tool replaceArgs:@"http://192.168.1.1/goform/setLogin?rand=RANDOM"]
#define HTTP_GetDeviceSlot      [Tool replaceArgs:@"http://192.168.1.1/goform/getDeviceSlotMode"]
#define HTTP_GetProfileList     [Tool replaceArgs:@"http://192.168.1.1/goform/getProfileList?rand=RANDOM"]
#define HTTP_GetCurrentProfile  [Tool replaceArgs:@"http://192.168.1.1/goform/getCurrentProfile?rand=RANDOM"]
#define HTTP_SetWlanInfo        [Tool replaceArgs:@"http://192.168.1.1/goform/setWlanInfo?rand=RANDOM"]
#define HTTP_SetLogout          [Tool replaceArgs:@"http://192.168.1.1/goform/setLogout?rand=RANDOM"]
#define HTTP_GetRouterInfo      [Tool replaceArgs:@"http://192.168.1.1/goform/getRouterInfo?rand=RANDOM"]
#define HTTP_SetRouterInfo      [Tool replaceArgs:@"http://192.168.1.1/goform/setRouterInfo?rand=RANDOM"]
#define HTTP_GetSystemInfo      [Tool replaceArgs:@"http://192.168.1.1/goform/getSysteminfo?rand=RANDOM"]
#define HTTP_SetUserNameAndPW   [Tool replaceArgs:@"http://192.168.1.1/goform/setUsernameAndPW?rand=RANDOM"]
#define HTTP_GetSMSStoreState   [Tool replaceArgs:@"http://192.168.1.1/goform/getSMSStoreState?rand=RANDOM"]
#define HTTP_GetSMSPageInfo     [Tool replaceArgs:@"http://192.168.1.1/goform/getSMSPageInfo?key=inbox&rand=RANDOM"]
#define HTTP_GetSMSList         [Tool replaceArgs:@"http://192.168.1.1/goform/getSMSlist?rand=RANDOM"]
#define HTTP_GetNetworkInfo     [Tool replaceArgs:@"http://192.168.1.1/goform/getNetworkInfo?rand=RANDOM"]
#define HTTP_GetMACFilterInfo   [Tool replaceArgs:@"http://192.168.1.1/goform/getMACFilterInfo?rand=RANDOM"]
#define HTTP_SetMACFilterInfo   [Tool replaceArgs:@"http://192.168.1.1/goform/setMACFilterInfo?rand=RANDOM"]



#endif
