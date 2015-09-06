//
//  RoamActivateReply.m
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "RoamActivateReply.h"
#import "DDString.h"
@implementation RoamActivateReply
+(instancetype)createActivateReplyWithString:(NSString*)string{
    RoamActivateReply * activateReply=[[RoamActivateReply alloc]init];
    activateReply.actvateState=-1;
    if (string==nil||string.length<4) {
        NSLog(@"报文长度错误");
        return activateReply;
    }
    unsigned long activateState=[DDString strtoul:[DDString substr:string start:0 length:4]];
    if (activateState>2) {
        NSLog(@"激活状态错误，应为0，1，2");
        return activateReply;
    }
    activateReply.actvateState=(int)activateState;
    activateReply.activateDate=[DDString substr:string start:4 length:8];
    activateReply.activateTime=[DDString substr:string start:12 length:6];
    return activateReply;
    
}
@end
