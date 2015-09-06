//
//  RoamRAC.h
//  Roaming
//
//  Created by chendd on 15/8/24.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RoamBindState.h"
#import "RoamBindReply.h"
#import "RoamActivateReply.h"
#import "RoamFlowReply.h"
#import "RoamWlanInfo.h"
#import "RoamWanInfo.h"
#import "RoamImgInfo.h"
#import "RoamSimInfo.h"
#import "RoamLoginState.h"
#import "RoamLocale.h"
#import "RoamLoginReply.h"
#import "RoamDeviceSlotMode.h"
#import "RoamProfile.h"
#import "RoamProfileList.h"
#import "RoamCurrentProfile.h"
#import "RoamRouterInfo.h"
#import "RoamSystemInfo.h"
#import "RoamSMSStoreState.h"
#import "RoamSMSPageInfo.h"
#import "RoamSMS.h"
#import "RoamSMSList.h"
#import "RoamNetworkInfo.h"
#import "RoamMacFilterInfo.h"
#import <MBProgressHUD.h>
#import "RoamRegisterReply.h"
#import "MainViewController.h"
//RoamRAC用于KVO，当获取OTA时的操作，绑定状态发生改变时的操作，网络状态改变时的操作
//采用单例方式实现
@protocol RoamRACDelegate <NSObject>

@optional
-(void)roamRAC:(id)roamRAC OTAInfo:(NSDictionary*)OTAInfo;
-(void)roamRAC:(id)roamRAC feedBackInfo:(NSDictionary *)feedBackInfo;
-(void)roamRAC:(id)roamRAC registerReply:(RoamRegisterReply *)registerReply;
-(void)roamRAC:(id)roamRAC wlanInfo:(RoamWlanInfo*)wlanInfo;
-(void)roamRAC:(id)roamRAC wanInfo:(RoamWanInfo *)wanInfo;
-(void)roamRAC:(id)roamRAC imgInfo:(RoamImgInfo *)imgInfo;
-(void)roamRAC:(id)roamRAC simInfo:(RoamSimInfo *)simInfo;
-(void)roamRAC:(id)roamRAC loginState:(RoamLoginState *)loginState;
-(void)roamRAC:(id)roamRAC locale:(RoamLocale *)locale;
-(void)roamRAC:(id)roamRAC loginReply:(RoamLoginReply *)loginReply;
-(void)roamRAC:(id)roamRAC deviceSlotMode:(RoamDeviceSlotMode *)deviceSlotMode;
-(void)roamRAC:(id)roamRAC profileList:(RoamProfileList *)profileList;
-(void)roamRAC:(id)roamRAC currentProfile:(RoamCurrentProfile *)currentProfile;
-(void)roamRAC:(id)roamRAC setWlanInfoState:(NSNumber *)setWlanInfoState;
-(void)roamRAC:(id)roamRAC logoutState:(NSNumber *)logoutState;
-(void)roamRAC:(id)roamRAC routerInfo:(RoamRouterInfo *)routerInfo;
-(void)roamRAC:(id)roamRAC setRouterInfoState:(NSNumber *)setRouterInfoState;
-(void)roamRAC:(id)roamRAC systemInfo:(RoamSystemInfo *)systemInfo;
-(void)roamRAC:(id)roamRAC setUsernameAndPWState:(NSNumber *)setUsernameAndPWState;
-(void)roamRAC:(id)roamRAC smsStoreState:(RoamSMSStoreState *)smsStoreState;
-(void)roamRAC:(id)roamRAC smsPageInfo:(RoamSMSPageInfo *)smsPageInfo;
-(void)roamRAC:(id)roamRAC smsList:(RoamSMSList *)smsList;
-(void)roamRAC:(id)roamRAC networkInfo:(RoamNetworkInfo *)networkInfo;
-(void)roamRAC:(id)roamRAC macFilterInfo:(RoamMacFilterInfo *)macFilterInfo;
-(void)roamRAC:(id)roamRAC setMacFilterInfoState:(NSNumber *)setMacFilterInfoState;
-(void)roamRAC:(id)roamRAC MifiMac:(NSString *)MifiMac;
-(void)roamRAC:(id)roamRAC bindState:(RoamBindState *)bindState;
-(void)roamRAC:(id)roamRAC bindReply:(RoamBindReply *)bindReply;
-(void)roamRAC:(id)roamRAC disbindReply:(NSNumber *)disbindReply;
-(void)roamRAC:(id)roamRAC activateReply:(RoamActivateReply *)activateReply;
-(void)roamRAC:(id)roamRAC MifiVersion:(NSString *)MifiVersion;
-(void)roamRAC:(id)roamRAC flowReply:(RoamFlowReply *)flowReply;
-(void)roamRAC:(id)roamRAC udpError:(NSString *)udpError;
@end
@interface RoamRAC : NSObject
+(instancetype)sharedRoamRAC;
@property (nonatomic, strong) NSDictionary * OTAInfo;
@property (nonatomic, strong) NSDictionary * feedBackInfo;
@property (nonatomic, strong) RoamRegisterReply * registerReply;
@property (nonatomic, copy) NSString * routeIP;
@property (nonatomic, copy) NSString * MifiMac;
@property (nonatomic, strong) RoamBindState * bindState;
@property (nonatomic, strong) RoamBindReply * bindReply;
@property (nonatomic, strong) NSNumber * disbindReply;
@property (nonatomic, strong) RoamActivateReply * activateReply;
@property (nonatomic, copy) NSString * MifiVersion;
@property (nonatomic, strong) RoamFlowReply * flowReply;
@property (nonatomic, strong) RoamWlanInfo * wlanInfo;
@property (nonatomic, strong) RoamWanInfo * wanInfo;
@property (nonatomic, strong) RoamImgInfo * imgInfo;
@property (nonatomic, strong) RoamSimInfo * simInfo;
@property (nonatomic, strong) RoamLoginState * loginState;
@property (nonatomic, strong) RoamLocale * locale;
@property (nonatomic, strong) RoamLoginReply * loginReply;
@property (nonatomic, strong) RoamDeviceSlotMode * deviceSlotMode;
@property (nonatomic, strong) RoamProfileList * profileList;
@property (nonatomic, strong) RoamCurrentProfile * currentProfile;
@property (nonatomic, strong) NSNumber * setWlanInfoState;
@property (nonatomic, strong) NSNumber * logoutState;
@property (nonatomic, strong) RoamRouterInfo * routerInfo;
@property (nonatomic, strong) NSNumber * setRouterInfoState;
@property (nonatomic, strong) RoamSystemInfo * systemInfo;
@property (nonatomic, strong) NSNumber * setUsernameAndPWState;
@property (nonatomic, strong) RoamSMSStoreState * smsStoreState;
@property (nonatomic, strong) RoamSMSPageInfo* smsPageInfo;
@property (nonatomic, strong) RoamSMSList * smsList;
@property (nonatomic, strong) RoamNetworkInfo * networkInfo;
@property (nonatomic, strong) RoamMacFilterInfo * macFilterInfo;
@property (nonatomic, strong) NSNumber * setMacFilterInfoState;
@property (nonatomic, strong) NSString * udpError;
@property (nonatomic, strong) MBProgressHUD * hud;
@property (nonatomic, strong) MainViewController * mainViewController;
@end
