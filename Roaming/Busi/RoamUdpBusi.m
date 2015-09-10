//
//  RoamUdpBusi.m
//  Roaming
//
//  Created by chendd on 15/8/24.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "RoamUdpBusi.h"
#import "DDUdpClient.h"
#import "RoamUdpPackage.h"
#import "AppDefines.h"
#import "RoamRAC.h"
#import "RoamBindState.h"
#import "RoamBindReply.h"
#import "DDString.h"
#import "Tool.h"
#define MifiIP @"192.168.1.1"
@implementation RoamUdpBusi
//查询绑定状态
+(void)getBindState:(id)callbackTarget{
    RoamUdpPackage * udpPackage=[RoamUdpPackage createPackageWithPayLoad:nil andCommandID:UDP_GetBindState];
    NSLog(@"%@",udpPackage.dataString);
    DDUdpClient * udpClient=[DDUdpClient createUdpClient];
    [udpClient sendData:udpPackage.data IP:MifiIP port:MIFI_PORT recvDataCallBack:^(NSData *recvData) {
        if (recvData==nil) {
            NSString * udpError=@"getBindState UDP通讯异常";
            [RoamRAC sharedRoamRAC].udpError=udpError;
            if ([callbackTarget respondsToSelector:@selector(roamRAC:udpError:)]) {
                [callbackTarget roamRAC:[RoamRAC sharedRoamRAC] udpError:udpError];
            }
        }else{
            RoamUdpPackage * recvUdpPackage=[RoamUdpPackage createPackageWithData:recvData];
            //校验是Mac回应
            if ([recvUdpPackage.commandID isEqualToString:UDP_GetBindStateReply]) {
                RoamBindState * bindState=[RoamBindState createBindStateWithString:recvUdpPackage.payLoad];
                [RoamRAC sharedRoamRAC].bindState=bindState;
                if([callbackTarget respondsToSelector:@selector(roamRAC:bindState:)]){
                    [callbackTarget roamRAC:[RoamRAC sharedRoamRAC] bindState:bindState];
                }
            }
        }
        
    }];
}
//绑定
+(void)bind:(id)callbackTarget phonenumber:(NSString*)phonenumber{
    NSString * payLoad=[NSString stringWithFormat:@"000B%@",[DDString hexStringFromString:phonenumber]];
    RoamUdpPackage * udpPackage=[RoamUdpPackage createPackageWithPayLoad:payLoad andCommandID:UDP_Bind];
    NSLog(@"%@",udpPackage.dataString);
    DDUdpClient * udpClient=[DDUdpClient createUdpClient];
    [udpClient sendData:udpPackage.data IP:MifiIP port:MIFI_PORT recvDataCallBack:^(NSData *recvData) {
        if (recvData==nil) {
            NSString * udpError=@"bind UDP通讯异常";
            [RoamRAC sharedRoamRAC].udpError=udpError;
            if ([callbackTarget respondsToSelector:@selector(roamRAC:udpError:)]) {
                [callbackTarget roamRAC:[RoamRAC sharedRoamRAC] udpError:udpError];
            }
        }else{
            RoamUdpPackage * recvUdpPackage=[RoamUdpPackage createPackageWithData:recvData];
            //校验是Mac回应
            if ([recvUdpPackage.commandID isEqualToString:UDP_BindReply]) {
                RoamBindReply * bindReply=[RoamBindReply createBindReplyWithString:recvUdpPackage.payLoad];
                [RoamRAC sharedRoamRAC].bindReply=bindReply;
                if ([callbackTarget respondsToSelector:@selector(roamRAC:bindReply:)]) {
                    [callbackTarget roamRAC:[RoamRAC sharedRoamRAC] bindReply:bindReply];
                }
            }
        }
    }];
}
//解绑
+(void)disbind:(id)callbackTarget phonenumber:(NSString*)phonenumber{
    RoamUdpPackage * udpPackage=[RoamUdpPackage createPackageWithPayLoad:[DDString hexStringFromString:phonenumber] andCommandID:UDP_Disbind];
    NSLog(@"%@",udpPackage.dataString);
    DDUdpClient * udpClient=[DDUdpClient createUdpClient];
    [udpClient sendData:udpPackage.data IP:MifiIP port:MIFI_PORT recvDataCallBack:^(NSData *recvData) {
        if (recvData==nil) {
            NSString * udpError=@"disbind UDP通讯异常";
            [RoamRAC sharedRoamRAC].udpError=udpError;
            if ([callbackTarget respondsToSelector:@selector(roamRAC:udpError:)]) {
                [callbackTarget roamRAC:[RoamRAC sharedRoamRAC] udpError:udpError];
            }
        }else{
            RoamUdpPackage * recvUdpPackage=[RoamUdpPackage createPackageWithData:recvData];
            //校验是Mac回应
            if ([recvUdpPackage.commandID isEqualToString:UDP_DisbindReply]) {
                //如果失败认为解绑失败
                unsigned long disbindSuccess=[DDString strtoul:[DDString substr:recvUdpPackage.payLoad start:0 length:4]];
                if (disbindSuccess>2) {
                    NSLog(@"报文回应错误，应为0，1，2");
                    disbindSuccess=0;
                }
                [RoamRAC sharedRoamRAC].disbindReply=[NSNumber numberWithInt:(int)disbindSuccess];
                if ([callbackTarget respondsToSelector:@selector(roamRAC:disbindReply:)]) {
                    [callbackTarget roamRAC:[RoamRAC sharedRoamRAC] disbindReply:[NSNumber numberWithInt:(int)disbindSuccess]];
                }
            }
        }
    }];
}
//激活
+(void)activate:(id)callbackTarget phonenumber:(NSString*)phonenumber{
    NSString * datetime=[Tool getTimeWithFormat:@"yyyyMMddHHmmss"];
    NSString * payload=[NSString stringWithFormat:@"%@%@",datetime,[DDString hexStringFromString:phonenumber]];
    RoamUdpPackage * udpPackage=[RoamUdpPackage createPackageWithPayLoad:payload andCommandID:UDP_Activate];
    NSLog(@"%@",udpPackage.dataString);
    DDUdpClient * udpClient=[DDUdpClient createUdpClient];
    [udpClient sendData:udpPackage.data IP:MifiIP port:MIFI_PORT recvDataCallBack:^(NSData *recvData) {
        if (recvData==nil) {
            NSString * udpError=@"activate UDP通讯异常";
            [RoamRAC sharedRoamRAC].udpError=udpError;
            if ([callbackTarget respondsToSelector:@selector(roamRAC:udpError:)]) {
                [callbackTarget roamRAC:[RoamRAC sharedRoamRAC] udpError:udpError];
            }
        }else{
            RoamUdpPackage * recvUdpPackage=[RoamUdpPackage createPackageWithData:recvData];
            //校验是Mac回应
            if ([recvUdpPackage.commandID isEqualToString:UDP_ActivateReply]) {
                RoamActivateReply * activateReply= [RoamActivateReply createActivateReplyWithString:recvUdpPackage.payLoad];
                [RoamRAC sharedRoamRAC].activateReply=activateReply;
                if ([callbackTarget respondsToSelector:@selector(roamRAC:activateReply:)]) {
                    [callbackTarget roamRAC:[RoamRAC sharedRoamRAC] activateReply:activateReply];
                }
            }
        }
    }];
}
//获取Mac地址，第一轮测试OK
+(void)getMifiMac:(id)callbackTarget {
    RoamUdpPackage * udpPackage= [RoamUdpPackage createPackageWithPayLoad:nil andCommandID:UDP_GetMifiMac];
    NSLog(@"%@",udpPackage.dataString);
    DDUdpClient * udpClient=[DDUdpClient createUdpClient];
    [udpClient sendData:udpPackage.data IP:MifiIP port:MIFI_PORT recvDataCallBack:^(NSData *recvData){
        if (recvData==nil) {
            NSString * udpError=@"getMifiMac UDP通讯异常";
            [RoamRAC sharedRoamRAC].udpError=udpError;
            if ([callbackTarget respondsToSelector:@selector(roamRAC:udpError:)]) {
                [callbackTarget roamRAC:[RoamRAC sharedRoamRAC] udpError:udpError];
            }
        }else{
            
            RoamUdpPackage * recvUdpPackage=[RoamUdpPackage createPackageWithData:recvData];
            //校验是Mac回应
            if ([recvUdpPackage.commandID isEqualToString:UDP_GetMifiMacReply]) {
                NSString * MifiMac=nil;
                if (recvUdpPackage.payLoad.length>=24) {
                    MifiMac=[DDString substr:recvUdpPackage.payLoad start:0 length:24];
                }
                [RoamRAC sharedRoamRAC].MifiMac=MifiMac;
                if ([callbackTarget respondsToSelector:@selector(roamRAC:MifiMac:)]) {
                    [callbackTarget roamRAC:[RoamRAC sharedRoamRAC] MifiMac:MifiMac];
                }
            }
            
        }
    }];
}
//获取mifi版本
+(void)getMifiVersion:(id)callbackTarget {
    RoamUdpPackage * udpPackage= [RoamUdpPackage createPackageWithPayLoad:nil andCommandID:UDP_GetMifiVersion];
    NSLog(@"%@",udpPackage.dataString);
    DDUdpClient * udpClient=[DDUdpClient createUdpClient];
    [udpClient sendData:udpPackage.data IP:MifiIP port:MIFI_PORT recvDataCallBack:^(NSData *recvData) {
        if (recvData==nil) {
            NSString * udpError=@"getMifiVersion UDP通讯异常";
            [RoamRAC sharedRoamRAC].udpError=udpError;
            if ([callbackTarget respondsToSelector:@selector(roamRAC:udpError:)]) {
                [callbackTarget roamRAC:[RoamRAC sharedRoamRAC] udpError:udpError];
            }
            
        }else{

        RoamUdpPackage * recvUdpPackage=[RoamUdpPackage createPackageWithData:recvData];
        if ([recvUdpPackage.commandID isEqualToString:UDP_GetMifiVersionReply]) {
            [RoamRAC sharedRoamRAC].MifiMac=recvUdpPackage.payLoad;
            if ([callbackTarget respondsToSelector:@selector(roamRAC:MifiVersion:)]) {
                [callbackTarget roamRAC:[RoamRAC sharedRoamRAC] MifiVersion:recvUdpPackage.payLoad];
            }
        }
        }
    }];
}
//获取当天已用流量
+(void)getUsedFlow:(id)callbackTarget {
    NSString * datatime=[Tool getTimeWithFormat:@"yyyyMMddHHmmss"];
    RoamUdpPackage * udpPackage= [RoamUdpPackage createPackageWithPayLoad:datatime andCommandID:UDP_GetUsedFlow];
    NSLog(@"%@",udpPackage.dataString);
    DDUdpClient * udpClient=[DDUdpClient createUdpClient];
    [udpClient sendData:udpPackage.data IP:MifiIP port:MIFI_PORT recvDataCallBack:^(NSData *recvData) {
        if (recvData==nil) {
            NSString * udpError=@"getUsedFlow UDP通讯异常";
            [RoamRAC sharedRoamRAC].udpError=udpError;
            if ([callbackTarget respondsToSelector:@selector(roamRAC:udpError:)]) {
                [callbackTarget roamRAC:[RoamRAC sharedRoamRAC] udpError:udpError];
            }
        }else{

        RoamUdpPackage * recvUdpPackage=[RoamUdpPackage createPackageWithData:recvData];
        if ([recvUdpPackage.commandID isEqualToString:UDP_GetUsedFlowReply]) {
            RoamFlowReply * flowReply=[RoamFlowReply createFlowReplyWithString:recvUdpPackage.payLoad];
            [RoamRAC sharedRoamRAC].flowReply=flowReply;
            if ([callbackTarget respondsToSelector:@selector(roamRAC:flowReply:)]) {
                [callbackTarget roamRAC:[RoamRAC sharedRoamRAC] flowReply:flowReply];
            }
        }
        }
    }];
}
@end
