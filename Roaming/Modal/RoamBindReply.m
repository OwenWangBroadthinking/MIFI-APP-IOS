
//
//  RoamBindReply.m
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "RoamBindReply.h"
#import "DDString.h"
@implementation RoamBindReply
+(instancetype)createBindReplyWithString:(NSString*)string{
    RoamBindReply * bindReply=[[RoamBindReply alloc]init];
    if (string==nil||string.length<4) {
        NSLog(@"报文长度错误");
        return bindReply;
    }
    unsigned long bindSuccess= [DDString strtoul:[DDString substr:string start:0 length:4]];
    if (bindSuccess!=0&&bindSuccess!=1) {
        NSLog(@"解析绑定状态错误，应为0或1");
        return bindReply;
    }
    bindReply.bindSuccess=bindSuccess;
    if (bindSuccess==1) {
        NSString * macAddress=[DDString substr:string start:4 length:24];
        bindReply.macAddress=macAddress;
    }
    return bindReply;
}
@end
