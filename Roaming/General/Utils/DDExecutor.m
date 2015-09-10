//
//  MKExecutor.m
//  MKit
//
//  Created by chendd on 15/6/9.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "DDExecutor.h"
#import <skpsmtpmessage/SKPSMTPMessage.h>
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)
@implementation DDExecutor
+(instancetype)sharedExecutor{
    static DDExecutor * executor;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      if (executor==nil) {
                          executor= [[DDExecutor alloc] init];
                      }
                  });
    return executor;
}
#pragma mark SKPSMTPMessageDelegate
-(void)messageSent:(SKPSMTPMessage *)message{
    SuppressPerformSelectorLeakWarning(
                                       [_SKPSMTPMessageTarget performSelector:_SKPSMTPMessageSuccessSEL];
                                       );
}
-(void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error{
    SuppressPerformSelectorLeakWarning(
                                       [_SKPSMTPMessageTarget performSelector:_SKPSMTPMessageFailSEL];
    );
}

@end
