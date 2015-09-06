//
//  AppDefines.h
//  Roaming
//
//  Created by chendd on 15/8/24.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#ifndef Roaming_AppDefines_h
#define Roaming_AppDefines_h

//日志打印
#define kLogDirectory [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]  stringByAppendingPathComponent:@"Logs"]
#define NSLog DDLogDebug
#import <CocoaLumberjack.h>
static const int ddLogLevel = DDLogLevelVerbose;// 定义日志级别
//接口定义
#include "InterfaceDefines.h"
#include "UserDefaultKey.h"
#import "AppDelegate.h"
#import <UIView+Toast.h>
//UI
#define ALERT_COMMON_TITLE @"温馨提示"
#define MIFI_PORT 10593
#define APP_BKCOLOR [UIColor colorWithRed:57/255.0f green:153/255.0 blue:153/255.0 alpha:1.0f]
#define TBV_BKCOLOR [UIColor colorWithRed:244/255.0f green:244/255.0 blue:244/255.0 alpha:1.0f]
//获取设备的物理高度
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
//获取设备的物理宽度
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
//获取版本号
#define kOSVersion [[[UIDevice currentDevice] systemVersion] floatValue]
//获取应用实例
#define appD ((AppDelegate *)[UIApplication sharedApplication ].delegate)
//去除警告
#define RoamPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#define SHOWHUD(x)  MBProgressHUD* hud_roamonlyone = [[MBProgressHUD alloc]initWithView:appD.window]; \
                    hud_roamonlyone.labelText=x;\
                    [appD.window addSubview:hud_roamonlyone];\
                    [RoamRAC sharedRoamRAC].hud=hud_roamonlyone;\
                    [hud_roamonlyone show:YES];
#define HIDEHUD     MBProgressHUD* hud_roamonly = [RoamRAC sharedRoamRAC].hud;\
                    [hud_roamonly hide:YES];\
                    [hud_roamonly removeFromSuperview];
#define Toast(v,m) [v makeToast:m duration:1.0f position:CSToastPositionCenter]
#endif
