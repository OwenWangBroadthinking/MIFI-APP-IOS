//
//  MKNetWorkUtils.m
//  TSMClientCore
//
//  Created by chendd on 14/6/17.
//  Copyright (c) 2014年 chendd. All rights reserved.
//

#import "DDNetWorkUtils.h"
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <AdSupport/ASIdentifierManager.h>
#import "DDString.h"
#import <skpsmtpmessage/NSData+Base64Additions.h>
#import <skpsmtpmessage/SKPSMTPMessage.h>
#import "DDExecutor.h"
@implementation DDNetWorkUtils
//提供网络访问相关方法
+(NSString *)getLocalIPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}
+(NSString *)getMacAddress{
        int                 mib[6];
        size_t              len;
        char                *buf;
        unsigned char       *ptr;
        struct if_msghdr    *ifm;
        struct sockaddr_dl  *sdl;
        
        mib[0] = CTL_NET;
        mib[1] = AF_ROUTE;
        mib[2] = 0;
        mib[3] = AF_LINK;
        mib[4] = NET_RT_IFLIST;
        
        if ((mib[5] = if_nametoindex("en0")) == 0) {
            printf("Error: if_nametoindex error/n");
            return NULL;
        }
        
        if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
            printf("Error: sysctl, take 1/n");
            return NULL;
        }
        
        if ((buf = malloc(len)) == NULL) {
            printf("Could not allocate memory. error!/n");
            return NULL;
        }
        
        if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
            printf("Error: sysctl, take 2");
            return NULL;
        }
        
        ifm = (struct if_msghdr *)buf;
        sdl = (struct sockaddr_dl *)(ifm + 1);
        ptr = (unsigned char *)LLADDR(sdl);
        NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
        
        //    NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
        
        NSLog(@"outString:%@", outstring);  
        
        free(buf);  
        
        return [outstring uppercaseString];  
    
}
+(NSString *)getMacAddressByAdSupport{
    NSString *adId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    if (adId==nil||adId.length==0) {
        return @"000000000000";
    }
    return [DDString substr:adId start:(int)(adId.length-12)];
}
+(void)sendTsmMail:(id)target
        successSEL:(SEL)successSEL
           failSEL:(SEL)failSEL
        email_host:(NSString*)email_host
           subject:(NSString*)subject
           message:(NSString*)message
{
    [self sendMail:target successSEL:successSEL failSEL:failSEL fromEmail:[NSString stringWithFormat:@"%@@sina.com",email_host]
           toEmail:[NSString stringWithFormat:@"%@@sina.com",email_host]
          bccEmail:nil relayHost:@"smtp.sina.com" login:email_host
              pass:@"1qaz2wsx"  subject:subject message:message attachfile:nil];
}
+(void)sendTsmMail:(id)target
        successSEL:(SEL)successSEL
           failSEL:(SEL)failSEL
        email_host:(NSString*)email_host
           subject:(NSString*)subject
           message:(NSString*)message
        attachfile:(NSArray*)attachfile
{
    [self sendMail:target successSEL:successSEL failSEL:failSEL fromEmail:[NSString stringWithFormat:@"%@@sina.com",email_host]
           toEmail:[NSString stringWithFormat:@"%@@sina.com",email_host]
          bccEmail:nil relayHost:@"smtp.sina.com" login:email_host pass:@"1qaz2wsx"  subject:subject message:message attachfile:attachfile];
}
+(void)sendMail:(id)target
     successSEL:(SEL)successSEL
        failSEL:(SEL)failSEL
      fromEmail:(NSString*)fromEmail
        toEmail:(NSString*)toEmail
       bccEmail:(NSString*)bccEmail
      relayHost:(NSString*)relayHost
          login:(NSString*)login
           pass:(NSString*)pass
        subject:(NSString*)subject
        message:(NSString *)message
     attachfile:(NSArray*)attachfile
{
    //设定SEL运行器
    SKPSMTPMessage * smtpMsg =[[SKPSMTPMessage alloc]init];
    DDExecutor * executor=[DDExecutor sharedExecutor];
    smtpMsg.delegate=executor;
    executor.smtpMsg=smtpMsg;
    executor.SKPSMTPMessageTarget=target;
    executor.SKPSMTPMessageSuccessSEL=successSEL;
    executor.SKPSMTPMessageFailSEL=failSEL;
    
    smtpMsg.fromEmail = fromEmail;
    smtpMsg.toEmail = toEmail;
    smtpMsg.bccEmail = bccEmail;
    smtpMsg.relayHost = relayHost;
    smtpMsg.requiresAuth = YES;
    if (smtpMsg.requiresAuth) {
        smtpMsg.login = login;
        smtpMsg.pass = pass;
    }
    smtpMsg.wantsSecure = YES; // smtp.gmail.com doesn't work without TLS!
    smtpMsg.subject = subject;
    
    // Only do this for self-signed certs!
    // smtpMsg.validateSSLChain = NO;
    
    NSDictionary *plainPart = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"text/plain",kSKPSMTPPartContentTypeKey,
                            message,kSKPSMTPPartMessageKey,
                               @"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
    if (attachfile==nil||[attachfile count]==0) {
        smtpMsg.parts = [NSArray arrayWithObjects:plainPart,nil];
    }else{
        NSMutableArray * attParts=[[NSMutableArray alloc]init];
        [attParts addObject:plainPart];
        for (NSString * path in attachfile) {
            NSData * data=[NSData dataWithContentsOfFile:path];
            NSDictionary *Part = [NSDictionary dictionaryWithObjectsAndKeys:
                                     [NSString stringWithFormat:@"text/directory;\r\n\tx-unix-mode=0644;\r\n\tname=\"%@\"",path],
                                     kSKPSMTPPartContentTypeKey,
                                     [NSString stringWithFormat:@"attachment;\r\n\tfilename=\"%@\"",path],
                                     kSKPSMTPPartContentDispositionKey,
                                     [data encodeBase64ForData],
                                     kSKPSMTPPartMessageKey,
                                     @"base64",kSKPSMTPPartContentTransferEncodingKey,nil];
            [attParts addObject:Part];
        }
        smtpMsg.parts = attParts;
        
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [smtpMsg send];
    });
    
}

@end
