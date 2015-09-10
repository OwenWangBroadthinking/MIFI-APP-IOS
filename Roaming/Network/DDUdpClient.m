//
//  DDUdpClient.m
//  Roaming
//
//  Created by chendd on 15/8/24.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "DDUdpClient.h"
#import "DDString.h"
#import <AsyncUdpSocket.h>
#import "RoamUdpPackage.h"
@interface DDUdpClient()
@property (nonatomic, strong) AsyncUdpSocket * asyncUdpSocket;
@property (nonatomic, copy) void (^m_recvDataCallBack) (NSData *);
@end
@implementation DDUdpClient

+(instancetype)createUdpClient{
    DDUdpClient * udpClient= [[DDUdpClient alloc]init];
    return udpClient;
}
-(instancetype)init{
    self=[super init];
    if (self) {
        _asyncUdpSocket=[[AsyncUdpSocket alloc]initWithDelegate:self];
    }
    return self;
}
-(void)dealloc{
    NSLog(@"DDUdpClient dealloc");
}
-(void)sendData:(NSData*)data IP:(NSString*)IP port:(UInt16)port recvDataCallBack:(void(^)(NSData* recvData))recvDataCallBack{
    [_asyncUdpSocket receiveWithTimeout:10 tag:0];
    self.m_recvDataCallBack=recvDataCallBack;
//    //编写挡板测试
//    RoamUdpPackage * sendPack=[RoamUdpPackage createPackageWithData:data];
//    NSData * recvData=nil;
//    //如果是50，则回复51
//    if([sendPack.commandID isEqualToString:@"50"]){
//        //未绑定
//        recvData=[RoamUdpPackage createPackageWithPayLoad:@"00" andCommandID:@"51"].data;
//        //已绑定
////        recvData=[RoamUdpPackage createPackageWithPayLoad:@"01000B3138323130303533303535" andCommandID:@"51"].data;
//        [self callBack:recvData];
//        [self cleanUp];
//        return;
//    }else if([sendPack.commandID isEqualToString:@"54"]){
//        recvData=[RoamUdpPackage createPackageWithPayLoad:@"0000" andCommandID:@"55"].data;
//        [self callBack:recvData];
//        [self cleanUp];
//        return;
//        
//    }else if([sendPack.commandID isEqualToString:@"56"]){//激活
////        recvData=[RoamUdpPackage createPackageWithPayLoad:@"0000" andCommandID:@"57"].data;
//        recvData=[RoamUdpPackage createPackageWithPayLoad:@"000100000000000000" andCommandID:@"57"].data;
//        [self callBack:recvData];
//        [self cleanUp];
//        return;
//    }
//    else if ([sendPack.commandID isEqualToString:@"58"]){
//        recvData=[RoamUdpPackage createPackageWithPayLoad:@"313233343536373839313233" andCommandID:@"59"].data;
//        [self callBack:recvData];
//        [self cleanUp];
//        return;
//    }else if([sendPack.commandID isEqualToString:@"52"])//绑定
//    {
//        recvData=[RoamUdpPackage createPackageWithPayLoad:@"0001313233343536373839313233" andCommandID:@"53"].data;//绑定成功
////        recvData=[RoamUdpPackage createPackageWithPayLoad:@"00" andCommandID:@"53"];//绑定失败
//        [self callBack:recvData];
//        [self cleanUp];
//        return;
//    }
    
    BOOL res=[_asyncUdpSocket sendData:data toHost:IP port:port withTimeout:10 tag:0];
    if (!res) {
        _error=@"发送失败";
        [self callBack:nil];
        [self cleanUp];
    }
}
-(void)cleanUp{
    NSLog(@"udpClient.error=%@",_error);
    [self close];
}
-(void)timeout:(id)sender{
    //超时
    _error=@"发送后10秒内没有收到响应";
    [self callBack:nil];
    [self cleanUp];
}
//确保回调只执行一次
-(void)callBack:(NSData*)data{
    if (self.m_recvDataCallBack!=nil) {
        self.m_recvDataCallBack(data);
        self.m_recvDataCallBack=nil;
    }
}
-(void)continueRecv{
    [self.asyncUdpSocket receiveWithTimeout:10 tag:0];
    //根据需要关闭连接，如果接收完成则回调，并且关闭连接
}
-(void)close{
    [self.asyncUdpSocket close];
    self.asyncUdpSocket=nil;
}
#pragma mark UDP Delegate Methods
//此处会一直接收数据，需要关闭udp连接
- (BOOL)onUdpSocket:(AsyncUdpSocket *)sock didReceiveData:(NSData *)data withTag:(long)tag fromHost:(NSString *)host port:(UInt16)port
{
    if (tag==0) {
        NSLog(@"udpClient recvData[%lu]",(unsigned long)data.length);
        NSLog(@"%@",[DDString hexStringFromData:data]);
        [self callBack:data];
        [self cleanUp];
    }
    return YES;
}
//发送失败
- (void)onUdpSocket:(AsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error
{
    _error=@"未发送成功数据";
    [self callBack:nil];
    [self cleanUp];
}
- (void)onUdpSocket:(AsyncUdpSocket *)sock didNotReceiveDataWithTag:(long)tag dueToError:(NSError *)error
{
    _error=@"未接收成功数据";
    [self callBack:nil];
    [self cleanUp];
}
//发送成功
- (void)onUdpSocket:(AsyncUdpSocket *)sock didSendDataWithTag:(long)tag{
    NSLog(@"udpClient sendData");
}
//关闭连接
- (void)onUdpSocketDidClose:(AsyncUdpSocket *)sock{
    NSLog(@"onUdpSocketDidClose");
}


@end
