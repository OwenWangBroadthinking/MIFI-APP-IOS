//
//  MKNetWorkUtils.h
//  TSMClientCore
//
//  Created by chendd on 14/6/17.
//  Copyright (c) 2014年 chendd. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
//提供网络访问相关方法
@interface DDNetWorkUtils : NSObject
/**
 *  获取本地IP地址
 *
 *  @return IP地址
 */
+(NSString *)getLocalIPAddress;
/**
 *  获取本机MAC地址
 *
 *  @return MAC地址
 */
+(NSString *)getMacAddress;
/**
 *  用广告标识符转换为MAC地址
 *
 *  @return 广告标识符转换后的MAC地址
 */
+(NSString*)getMacAddressByAdSupport;
/**
 *  发送电子邮件
 *
 *  @param smtpMsg SKPSMTPMessage实例
 *  @param subject 主题
 *  @param message 内容
 */
+(void)sendTsmMail:(id)target
        successSEL:(SEL)successSEL
           failSEL:(SEL)failSEL
        email_host:(NSString*)email_host
           subject:(NSString*)subject
           message:(NSString*)message;
/**
 *  发送电子邮件带附件
 *
 *  @param smtpMsg    SKPSMTPMessage实例
 *  @param subject    主题
 *  @param message    内容
 *  @param attachfile 附件列表
 */
+(void)sendTsmMail:(id)target
        successSEL:(SEL)successSEL
           failSEL:(SEL)failSEL
        email_host:(NSString*)email_host
           subject:(NSString*)subject
           message:(NSString*)message
        attachfile:(NSArray*)attachfile;
@end
