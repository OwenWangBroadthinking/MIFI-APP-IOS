//
//  RoamRAC.m
//  Roaming
//
//  Created by chendd on 15/8/24.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "RoamRAC.h"
#import <ReactiveCocoa.h>
#import <AFNetworkReachabilityManager.h>
#import "Tool.h"
#import <CocoaLumberjack.h>
#import <DDLog.h>
@implementation RoamRAC
+(instancetype)sharedRoamRAC{
    static RoamRAC * roamRAC=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      if (roamRAC==nil) {
                          roamRAC= [[RoamRAC alloc] init];
                      }
                  });
    return roamRAC;
}
-(instancetype)init{
    self=[super init];
    if (self) {
        //开启日志打印
        [self startLogger];
        //监测网络连接
        [self startMoniNetwork];
    }
    return self;
}
-(void)startLogger{
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    DDFileLogger * fileLogger=[[DDFileLogger alloc]init];
    fileLogger.rollingFrequency= 60 * 60 * 24;
    fileLogger.logFileManager.maximumNumberOfLogFiles = 1;
    [DDLog addLogger:fileLogger];
}

-(void)startMoniNetwork{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:{
                NSLog(@"无网络");
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                NSLog(@"WiFi网络");
                //获取路由地址，根据路由地址发送Udp请求获取对方Mac地址
                _routeIP=[Tool routerIp];
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                NSLog(@"无线网络");
                break;
            }
            default:
                break;
        }
    }];
}


#pragma mark unused
//监测异常情况
//        [self startMoniUdpError];

//-(void)startMoniUdpError{
//    [RACObserve(self, udpError) subscribeNext:^(NSString * udpError) {
//        if (udpError!=nil) {
//            if (_delegate!=nil && [_delegate respondsToSelector:@selector(roamRAC:udpError:)]) {
//                [_delegate roamRAC:self udpError:udpError];
//            }
//        }
//    }];
//}

//        //开启KVO
//        [self startMoniOTA];
//        [self startMoniFeedBack];
//        [self startMoniRegisterReply];
//
//
//        //http相关
//        [self startMoniWlanInfo];
//        [self startMoniWanInfo];
//        [self startMoniImgInfo];
//        [self startMoniSimInfo];
//        [self startMoniLoginState];
//        [self startMoniLocale];
//        [self startMoniLoginReply];
//        [self startMoniDeviceSlotMode];
//        [self startMoniProfileList];
//        [self startMoniCurrentProfile];
//        [self startMoniSetWlanInfoState];
//        [self startMoniLogoutState];
//        [self startMoniRouterInfo];
//        [self startMoniSetRouterInfoState];
//        [self startMoniSystemInfo];
//        [self startMoniSetUsernameAndPWState];
//        [self startMoniSMSStoreState];
//        [self startMoniSMSPageInfo];
//        [self startMoniSMSList];
//        [self startMoniNetworkInfo];
//        [self startMoniMacFilterInfo];
//        [self startMoniSetMacFilterInfoState];
//-(void)startMoniOTA{
//    //当接收到有效信息时触发
//    [RACObserve(self, OTAInfo) subscribeNext:^(NSDictionary * otaInfo) {
//        if(otaInfo!=nil){
//            if (_delegate!=nil&&[_delegate respondsToSelector:@selector(roamRAC:OTAInfo:)]) {
//                [_delegate roamRAC:self OTAInfo:otaInfo];
//            }
//        }
//    }];
//}
//-(void)startMoniFeedBack{
//    [RACObserve(self, feedBackInfo) subscribeNext:^(NSDictionary * feedbackInfo) {
//        if (feedbackInfo!=nil) {
//            NSLog(@"%@",[feedbackInfo objectForKey:@"msg"]);
//        }
//    }];
//}
//-(void)startMoniWlanInfo{
//    [RACObserve(self, wlanInfo)subscribeNext:^(RoamWlanInfo * wlanInfo) {
//        if (wlanInfo!=nil) {
//            if (_delegate!=nil&&[_delegate respondsToSelector:@selector(roamRAC:wlanInfo:)]) {
//                [_delegate roamRAC:self wlanInfo:wlanInfo];
//            }
//        }
//    }];
//}
//-(void)startMoniWanInfo{
//    [RACObserve(self, wanInfo)subscribeNext:^(RoamWanInfo*wanInfo) {
//        if (wanInfo!=nil) {
//            if (_delegate!=nil&&[_delegate respondsToSelector:@selector(roamRAC:wanInfo:)]) {
//                [_delegate roamRAC:self wanInfo:wanInfo];
//            }
//        }
//    }];
//}
//-(void)startMoniRegisterReply{
//    [RACObserve(self, registerReply) subscribeNext:^(RoamRegisterReply * registerReply) {
//        if (registerReply!=nil) {
//            if (_delegate!=nil && [_delegate respondsToSelector:@selector(roamRAC:registerReply:)]) {
//                [_delegate roamRAC:self registerReply:registerReply];
//            }
//        }
//    }];
//}
//-(void)startMoniImgInfo{
//    [RACObserve(self, imgInfo)subscribeNext:^(RoamImgInfo * imgInfo) {
//        if (imgInfo!=nil) {
//            if (_delegate!=nil&&[_delegate respondsToSelector:@selector(roamRAC:imgInfo:)]) {
//                [_delegate roamRAC:self imgInfo:imgInfo];
//            }
//        }
//    }];
//}
//-(void)startMoniSimInfo{
//    [RACObserve(self, simInfo)subscribeNext:^(RoamSimInfo * simInfo) {
//        if (simInfo!=nil) {
//            NSLog(@"sim_state=%@",simInfo.sim_state);
//            if (_delegate!=nil&&[_delegate respondsToSelector:@selector(roamRAC:simInfo:)]) {
//                [_delegate roamRAC:self simInfo:simInfo];
//            }
//        }
//    }];
//}
//-(void)startMoniLoginState{
//    [RACObserve(self, loginState)subscribeNext:^(RoamLoginState * loginState) {
//        if (loginState!=nil) {
//            NSLog(@"loginStatus=%@",loginState.loginStatus);
//            if (_delegate!=nil&&[_delegate respondsToSelector:@selector(roamRAC:loginState:)]) {
//                [_delegate roamRAC:self loginState:loginState];
//            }
//        }
//    }];
//}
//-(void)startMoniLocale{
//    [RACObserve(self, locale) subscribeNext:^(RoamLocale* locale) {
//        if (locale!=nil) {
//            if (_delegate!=nil&&[_delegate respondsToSelector:@selector(roamRAC:locale:)]) {
//                [_delegate roamRAC:self locale:locale];
//            }
//        }
//    }];
//}
//-(void)startMoniLoginReply{
//    [RACObserve(self, loginReply) subscribeNext:^(RoamLoginReply * loginReply) {
//        if (loginReply!=nil) {
//            if (_delegate!=nil&&[_delegate respondsToSelector:@selector(roamRAC:loginReply:)]) {
//                [_delegate roamRAC:self loginReply:loginReply];
//            }
//        }
//    }];
//}
//-(void)startMoniDeviceSlotMode{
//    [RACObserve(self, deviceSlotMode) subscribeNext:^(RoamDeviceSlotMode * deviceSlotMode) {
//        if (deviceSlotMode!=nil) {
//            if (_delegate!=nil&&[_delegate respondsToSelector:@selector(roamRAC:deviceSlotMode:)]) {
//                [_delegate roamRAC:self deviceSlotMode:deviceSlotMode];
//            }
//        }
//    }];
//}
//-(void)startMoniProfileList{
//    [RACObserve(self, profileList) subscribeNext:^(RoamProfileList * profileList) {
//        if (profileList!=nil) {
//            if (_delegate!=nil && [_delegate respondsToSelector:@selector(roamRAC:profileList:)]) {
//                [_delegate roamRAC:self profileList:profileList];
//            }
//        }
//    }];
//}
//-(void)startMoniCurrentProfile{
//    [RACObserve(self, currentProfile) subscribeNext:^(RoamCurrentProfile* currentProfile) {
//        if (currentProfile!=nil) {
//            if (_delegate!=nil&& [_delegate respondsToSelector:@selector(roamRAC:currentProfile:)]) {
//                [_delegate roamRAC:self currentProfile:currentProfile];
//            }
//        }
//    }];
//}
//-(void)startMoniSetWlanInfoState{
//    [RACObserve(self, setWlanInfoState) subscribeNext:^(NSNumber* setWlanInfoState) {
//        if (setWlanInfoState!=nil) {
//            if (_delegate!=nil && [_delegate respondsToSelector:@selector(roamRAC:setWlanInfoState:)]) {
//                [_delegate roamRAC:self setWlanInfoState:setWlanInfoState];
//            }
//        }
//    }];
//}
//-(void)startMoniLogoutState{
//    [RACObserve(self, logoutState) subscribeNext:^(NSNumber * logoutState) {
//        if (logoutState!=nil) {
//            if (_delegate!=nil && [_delegate respondsToSelector:@selector(roamRAC:logoutState:)]) {
//                [_delegate roamRAC:self logoutState:logoutState];
//            }
//        }
//    }];
//}
//-(void)startMoniRouterInfo{
//    [RACObserve(self, routerInfo) subscribeNext:^(RoamRouterInfo * routerInfo) {
//        if (routerInfo!=nil) {
//            if (_delegate!=nil&& [_delegate respondsToSelector:@selector(roamRAC:routerInfo:)]) {
//                [_delegate roamRAC:self routerInfo:routerInfo];
//            }
//        }
//    }];
//}
//-(void)startMoniSetRouterInfoState{
//    [RACObserve(self, setRouterInfoState) subscribeNext:^(NSNumber* setRouterInfoState) {
//        if (setRouterInfoState!=nil) {
//            if (_delegate!=nil && [_delegate respondsToSelector:@selector(roamRAC:setRouterInfoState:)]) {
//                [_delegate roamRAC:self setRouterInfoState:setRouterInfoState];
//            }
//        }
//    }];
//}
//-(void)startMoniSystemInfo{
//    [RACObserve(self, systemInfo) subscribeNext:^(RoamSystemInfo * systemInfo) {
//        if (systemInfo!=nil) {
//            if (_delegate!=nil && [_delegate respondsToSelector:@selector(roamRAC:systemInfo:)]) {
//                [_delegate roamRAC:self systemInfo:systemInfo];
//            }
//        }
//    }];
//}
//-(void)startMoniSetUsernameAndPWState{
//    [RACObserve(self, setUsernameAndPWState) subscribeNext:^(NSNumber * setUsernameAndPWState) {
//        if (setUsernameAndPWState!=nil) {
//            if (_delegate!=nil && [_delegate respondsToSelector:@selector(roamRAC:setUsernameAndPWState:)]) {
//                [_delegate roamRAC:self setUsernameAndPWState:setUsernameAndPWState];
//            }
//        }
//    }];
//}
//-(void)startMoniSMSStoreState{
//    [RACObserve(self, smsStoreState) subscribeNext:^(RoamSMSStoreState * smsStoreState) {
//        if (smsStoreState!=nil) {
//            if (_delegate!=nil && [_delegate respondsToSelector:@selector(roamRAC:smsStoreState:)]) {
//                [_delegate roamRAC:self smsStoreState:smsStoreState];
//            }
//        }
//    }];
//}
//-(void)startMoniSMSPageInfo{
//    [RACObserve(self, smsPageInfo) subscribeNext:^(RoamSMSPageInfo * smsPageInfo) {
//        if (smsPageInfo!=nil) {
//            if (_delegate!=nil && [_delegate respondsToSelector:@selector(roamRAC:smsPageInfo:)]) {
//                [_delegate roamRAC:self smsPageInfo:smsPageInfo];
//            }
//        }
//    }];
//}
//-(void)startMoniSMSList{
//    [RACObserve(self, smsList) subscribeNext:^(RoamSMSList * smsList) {
//        if (smsList!=nil) {
//            if (_delegate!=nil && [_delegate respondsToSelector:@selector(roamRAC:smsList:)]) {
//                [_delegate roamRAC:self smsList:smsList];
//            }
//        }
//    }];
//}
//-(void)startMoniNetworkInfo{
//    [RACObserve(self, networkInfo) subscribeNext:^(RoamNetworkInfo * networkInfo) {
//        if (networkInfo!=nil) {
//            if (_delegate!=nil && [_delegate respondsToSelector:@selector(roamRAC:networkInfo:)]) {
//                [_delegate roamRAC:self networkInfo:networkInfo];
//            }
//        }
//    }];
//}
//-(void)startMoniMacFilterInfo{
//    [RACObserve(self, macFilterInfo) subscribeNext:^(RoamMacFilterInfo * macFilterInfo) {
//        if (macFilterInfo!=nil) {
//            if (_delegate!=nil && [_delegate respondsToSelector:@selector(roamRAC:macFilterInfo:)]) {
//                [_delegate roamRAC:self macFilterInfo:macFilterInfo];
//            }
//        }
//    }];
//}
//-(void)startMoniSetMacFilterInfoState{
//    [RACObserve(self, setMacFilterInfoState) subscribeNext:^(NSNumber * setMacFilterInfoState) {
//        if (setMacFilterInfoState!=nil) {
//            if (_delegate!=nil && [_delegate respondsToSelector:@selector(roamRAC:setMacFilterInfoState:)]) {
//                [_delegate roamRAC:self setMacFilterInfoState:setMacFilterInfoState];
//            }
//        }
//    }];
//}
//udp相关
//        [self startMoniMifiMac];
//        [self startMoniBindState];//监测绑定状态
//        [self startMoniBindReply];//监测绑定
//        [self startMoniDisbindReply];//监测解绑结果
//        [self startMoniActivateReply];//监测激活返回
//        [self startMoniMifiVersion];
//        [self startMoniFlowReply];
//-(void)startMoniMifiMac{
//    [RACObserve(self, MifiMac) subscribeNext:^(NSString * mifiMac) {
//        if (mifiMac!=nil) {
//            NSLog(@"mifiMac=%@",mifiMac);
//            if (_delegate!=nil&&[_delegate respondsToSelector:@selector(roamRAC:MifiMac:)]) {
//                [_delegate roamRAC:self MifiMac:mifiMac];
//            }
//        }
//    }];
//}
//-(void)startMoniBindState{
//    [RACObserve(self, bindState) subscribeNext:^(RoamBindState * bindState) {
//        if (bindState!=nil) {
//            if (bindState.bindData==nil) {
//                NSLog(@"bindState解析失败");
//            }else{
//                NSLog(@"isBinded=%d",bindState.isBinded);
//                if (_delegate!=nil&&[_delegate respondsToSelector:@selector(roamRAC:bindState:)]) {
//                    [_delegate roamRAC:self bindState:bindState];
//                }
//            }
//        }
//    }];
//}
//-(void)startMoniBindReply{
//    [RACObserve(self, bindReply) subscribeNext:^(RoamBindReply * bindReply) {
//        if (bindReply!=nil) {
//            if (bindReply.macAddress==nil) {
//                NSLog(@"bindReply解析失败");
//            }else{
//                NSLog(@"bindSuccess=%d",bindReply.bindSuccess);
//                if (_delegate!=nil&&[_delegate respondsToSelector:@selector(roamRAC:bindReply:)]) {
//                    [_delegate roamRAC:self bindReply:bindReply];
//                }
//            }
//        }
//    }];
//}
//-(void)startMoniDisbindReply{
//    [RACObserve(self, disbindReply) subscribeNext:^(NSNumber * disbindReply) {
//        if (disbindReply!=nil) {
//            NSLog(@"bindState=%d",[disbindReply intValue]);
//            if (_delegate!=nil&&[_delegate respondsToSelector:@selector(roamRAC:disbindReply:)]) {
//                [_delegate roamRAC:self disbindReply:disbindReply];
//            }
//        }
//    }];
//}
//-(void)startMoniActivateReply{
//    [RACObserve(self, activateReply) subscribeNext:^(RoamActivateReply * activateReply) {
//        if (activateReply!=nil) {
//            if (activateReply.actvateState==-1) {
//                NSLog(@"activateReply解析失败");
//            }else{
//                NSLog(@"activateDate=%@ activateTime=%@",activateReply.activateDate,activateReply.activateTime);
//                if (_delegate!=nil&&[_delegate respondsToSelector:@selector(roamRAC:activateReply:)]) {
//                    [_delegate roamRAC:self activateReply:activateReply];
//                }
//            }
//        }
//    }];
//}
//-(void)startMoniMifiVersion{
//    [RACObserve(self, MifiVersion) subscribeNext:^(NSString * mifiVersion) {
//        if (mifiVersion!=nil) {
//            NSLog(@"mifiVersion=%@",mifiVersion);
//            if (_delegate!=nil&&[_delegate respondsToSelector:@selector(roamRAC:MifiVersion:)]) {
//                [_delegate roamRAC:self MifiVersion:mifiVersion];
//            }
//        }
//    }];
//}
//-(void)startMoniFlowReply{
//    [RACObserve(self, flowReply)subscribeNext:^(RoamFlowReply * flowReply) {
//        if (flowReply!=nil) {
//            if (flowReply.totalFlow==nil) {
//                NSLog(@"flowReply解析失败");
//            }else{
//                NSLog(@"totalFlow=%@",flowReply.totalFlow);
//                if (_delegate!=nil&&[_delegate respondsToSelector:@selector(roamRAC:flowReply:)]) {
//                    [_delegate roamRAC:self flowReply:flowReply];
//                }
//            }
//
//        }
//    }];
//}
@end
