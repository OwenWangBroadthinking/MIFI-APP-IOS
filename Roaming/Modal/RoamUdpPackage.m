//
//  RoamUdpPackage.m
//  Roaming
//
//  Created by chendd on 15/8/25.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "RoamUdpPackage.h"
#import "DDString.h"
@implementation RoamUdpPackage
-(instancetype)init{
    self=[super init];
    if (self) {
        _headerFlag=@"1A1F";
        _reserve=@"00";
    }
    return self;
}
+(instancetype)createPackageWithPayLoad:(NSString *)payLoad
                           andCommandID:(NSString*)commandID{
    RoamUdpPackage * udpPackage=[[RoamUdpPackage alloc]init];
    if (payLoad==nil) {
        udpPackage.dataLength=@"0000";
    }else{
        udpPackage.dataLength=[NSString stringWithFormat:@"%02X%02X",(UInt8)(payLoad.length/2/0x100),(UInt8)(payLoad.length/2%0x100)];
    }
    
    udpPackage.commandID=commandID;
    //计算commandIdx
    NSString * commandIdx=[[NSUserDefaults standardUserDefaults] objectForKey:@"commandIdx"];
    if (commandIdx==nil) {
        commandIdx=@"00";
    }else{
        unsigned long nextCommandIdx=strtoul([[NSString stringWithFormat:@"0x%@",commandIdx ] UTF8String], 0, 16)+1;
        commandIdx=[NSString stringWithFormat:@"%02X",(UInt8)nextCommandIdx];
    }
    [[NSUserDefaults standardUserDefaults] setValue:commandIdx forKey:@"commandIdx"];
    udpPackage.commandIdx=commandIdx;
    NSString * sumCheck=[self getSumCheckByPayLoad:payLoad];
    udpPackage.sumCheck=sumCheck;
    udpPackage.payLoad=payLoad;
    if (payLoad!=nil) {
        udpPackage.dataString=[NSString stringWithFormat:@"%@%@%@%@%@%@%@",
                               udpPackage.headerFlag,
                               udpPackage.dataLength,
                               udpPackage.commandID,
                               udpPackage.commandIdx,
                               udpPackage.sumCheck,
                               udpPackage.reserve,
                               udpPackage.payLoad];
    }else{
        udpPackage.dataString=[NSString stringWithFormat:@"%@%@%@%@%@%@",
                               udpPackage.headerFlag,
                               udpPackage.dataLength,
                               udpPackage.commandID,
                               udpPackage.commandIdx,
                               udpPackage.sumCheck,
                               udpPackage.reserve];
    }
    
    udpPackage.data=[DDString dataFromHexString:udpPackage.dataString];
    return udpPackage;
}
+(instancetype)createPackageWithData:(NSData*)data{
    RoamUdpPackage * udpPackage=[[RoamUdpPackage alloc]init];
    if (data==nil||data.length<8) {
        return udpPackage;
    }
    //根据 dataString是否为空来判断是否加载data成功
    NSString * dataString=[DDString hexStringFromData:data];
    //判断头是否正常
    NSString * header=[dataString substringWithRange:NSMakeRange(0, 4)];
    if (![udpPackage.headerFlag isEqualToString:header]) {//报文头错误
        NSLog(@"解析报文头错误 预期[%@] [%@] ",udpPackage.headerFlag,header);
        return udpPackage;
    }
    NSString * dataLength=[dataString substringWithRange:NSMakeRange(4, 4)];
    NSString * commandID=[dataString substringWithRange:NSMakeRange(8, 2)];
    NSString * commandIdx=[dataString substringWithRange:NSMakeRange(10, 2)];
    NSString * sumCheck=[dataString substringWithRange:NSMakeRange(12, 2)];
    NSString * reserve=[dataString substringWithRange:NSMakeRange(14, 2)];
    NSString * payLoad=[dataString substringFromIndex:16];
    //判断长度是否符合
    unsigned long len=[DDString strtoul:dataLength];
    if (payLoad.length/2!=len) {//长度错误
        NSLog(@"长度错误 预期[%lu] [%lu]",len,payLoad.length/2);
        return udpPackage;
    }
    //判断合校验是否正确
    NSString * sumCheck_c=[self getSumCheckByPayLoad:payLoad];
    if (![sumCheck_c isEqualToString:sumCheck]) {//和校验错误
        NSLog(@"和校验错误 预期[%@] [%@]",sumCheck_c,sumCheck);
        return udpPackage;
    }
    //校验成功，给data和dataString赋值
    udpPackage.dataLength=dataLength;
    udpPackage.commandID=commandID;
    udpPackage.commandIdx=commandIdx;
    udpPackage.sumCheck=sumCheck;
    udpPackage.reserve=reserve;
    udpPackage.payLoad=payLoad;
    udpPackage.dataString=dataString;
    udpPackage.data=data;
    return udpPackage;
    
}
+(NSString *)getSumCheckByPayLoad:(NSString*)payLoad{
    //计算sumCheck
    NSString * sumCheck=@"00";
    if (payLoad!=nil) {
        UInt8 sum=0;
        for (NSInteger i=0; i<payLoad.length; i+=2) {
            NSString * str_i=[payLoad substringWithRange:NSMakeRange(i, 2)];
            unsigned long sum_i=[DDString strtoul:str_i];
            sum+=sum_i;
        }
        sumCheck=[NSString stringWithFormat:@"%02X",sum];
    }
    return sumCheck;
}
@end
