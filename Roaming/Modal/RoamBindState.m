//
//  RoamBindState.m
//  Roaming
//
//  Created by chendd on 15/8/26.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "RoamBindState.h"
#import "DDString.h"

@implementation RoamBindState
+(instancetype)createBindStateWithData:(NSData *)data{
    return [self createBindStateWithString:[DDString hexStringFromData:data]];
}
+(instancetype)createBindStateWithString:(NSString *)string{
    
    RoamBindState * bindState=[[RoamBindState alloc]init];
    if (string==nil||string.length<2) {
        NSLog(@"报文长度错误");
        return bindState;
    }
    unsigned long isBinded=[DDString strtoul:[DDString substr:string start:0 length:2]];
    if (isBinded!=0&&isBinded!=1) {
        NSLog(@"解析报文绑定状态超出范围，应为0或1");
        return bindState;
    }
    bindState.isBinded=isBinded;
    if (isBinded==0) {
        bindState.bindData=@"NULL";
    }else{
        unsigned long bindType=[DDString strtoul:[DDString substr:string start:2 length:2]];
        if (bindType!=0&&bindType!=2) {
            NSLog(@"解析报文绑定类型超出范围，应为0或2");
            return bindState;
        }
        unsigned long bindDataLength=[DDString strtoul:[DDString substr:string start:4 length:2]];
        if (bindDataLength*2>string.length-6) {
            NSLog(@"解析报文数据长度错误");
            return bindState;
        }
        bindState.bindType=(int)bindType;
        bindState.bindDataLength=(int)bindDataLength;
        bindState.bindData=[DDString substr:string start:6 length:(int)bindDataLength*2];
    }
    return bindState;
}
@end
