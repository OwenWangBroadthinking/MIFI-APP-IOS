//
//  RoamFlowReply.m
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "RoamFlowReply.h"
#import "DDString.h"
@implementation RoamFlowReply
+(instancetype)createFlowReplyWithString:(NSString*)string{
    RoamFlowReply * flowReply=[[RoamFlowReply alloc]init];
    if (string==nil||string.length<32) {
        NSLog(@"报文长度错误");
        return flowReply;
    }
    flowReply.totalFlow=[DDString substr:string start:0 length:16];
    flowReply.usedFlow=[DDString substr:string start:16 length:16];
    return flowReply;
}
@end
