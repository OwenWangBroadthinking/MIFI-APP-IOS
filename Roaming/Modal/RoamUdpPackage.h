//
//  RoamUdpPackage.h
//  Roaming
//
//  Created by chendd on 15/8/25.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoamUdpPackage : NSObject
+(instancetype)createPackageWithPayLoad:(NSString *)payLoad
                           andCommandID:(NSString*)commandID;
+(instancetype)createPackageWithData:(NSData*)data;
@property (nonatomic, copy) NSString * headerFlag;//两个字节，所有数据包的头标识，恒为0x1A1F
@property (nonatomic, copy) NSString * dataLength;//两个字节，数据包payload长度，不包括数据包包头长度
@property (nonatomic, copy) NSString * commandID;//一个字节，标识当前数据包的命令类型
@property (nonatomic, copy) NSString * commandIdx;//一个字节，命令序列号，从0递增，用于控制重发
@property (nonatomic, copy) NSString * sumCheck;//一个字节,针对数据部分的校验，包头不参与校验计算，如果没有数据部分，则该字节为0
@property (nonatomic, copy) NSString * reserve;//一个字节,RESV
@property (nonatomic, copy) NSString * payLoad;//Packet数据内容，长度为变长，取决于<数据包长度>字段
@property (nonatomic, copy) NSString * dataString;
@property (nonatomic, copy) NSData * data;
@end
