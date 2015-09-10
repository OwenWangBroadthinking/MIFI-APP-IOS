//
//  MKExecutor.h
//  MKit
//
//  Created by chendd on 15/6/9.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <skpsmtpmessage/SKPSMTPMessage.h>
//MKExecutor用于解除代理依赖关系，将调用第三方的代理方法转为SEL方法
@interface DDExecutor : NSObject<SKPSMTPMessageDelegate>
+(instancetype)sharedExecutor;
@property (nonatomic, strong) NSObject * smtpMsg;
@property (nonatomic, assign) id SKPSMTPMessageTarget;
@property (nonatomic, assign) SEL SKPSMTPMessageSuccessSEL;
@property (nonatomic, assign) SEL SKPSMTPMessageFailSEL;
@end
