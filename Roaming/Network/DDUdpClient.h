//
//  DDUdpClient.h
//  Roaming
//
//  Created by chendd on 15/8/24.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDUdpClient : NSObject
@property (nonatomic, copy) NSString * error;
//工厂模式创建对象
+(instancetype)createUdpClient;
//发送内容并block接收回应
-(void)sendData:(NSData*)data
             IP:(NSString*)IP
           port:(UInt16)port
    recvDataCallBack:(void(^)(NSData* recvData))recvDataCallBack;
-(void)close;
@end
