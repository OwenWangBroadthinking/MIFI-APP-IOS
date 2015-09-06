//
//  Tool.m
//  Roaming
//
//  Created by chendd on 15/8/24.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "Tool.h"
#import <objc/runtime.h>
#import "AppDefines.h"
#import <SIAlertView.h>
#include <sys/socket.h>
#import <netinet/in.h>
#import <netinet6/in6.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#include <netdb.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#import <arpa/inet.h>
#import "getgateway.h"
#import "DDString.h"
@implementation Tool
+(SIAlertView*)generateAlertWithTitle:(NSString *)title andMessage:(NSString *)message{
    SIAlertView * alert=[[SIAlertView alloc]initWithTitle:title andMessage:message];
    return alert;
}
+(void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message
{
    SIAlertView *alert=[Tool generateAlertWithTitle:title andMessage:message];
    [alert addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDestructive handler:nil];
    [alert show];
}
+(void)showAlertWithMessage:(NSString*)message{
    [Tool showAlertWithTitle:ALERT_COMMON_TITLE andMessage:message];
}
+(NSString*)getTime{
    return [self getTimeWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}
+(NSString*)getTimeWithFormat:(NSString*)format{
    NSDate * cur=[NSDate date];
    NSDateFormatter * DateFormat=[[NSDateFormatter alloc]init];
    [DateFormat setDateFormat:format];
    return [DateFormat stringFromDate:cur];
}
+(NSString *)getISOTime{
    NSDate * cur=[NSDate date];
    NSDateFormatter * DateFormat=[[NSDateFormatter alloc]init];
    [DateFormat setDateFormat:@"yyyy-MM-dd.HH:mm:ss+0800"];
    NSString * IOSTime=[DDString replace:[DateFormat stringFromDate:cur] src:@"." replaceWith:@"T"];
    return IOSTime;
}
+(NSString*)getRandomString16{
    UInt32 a= arc4random();
    UInt32 b= arc4random();
    NSData * data_a=[NSData dataWithBytes:&a length:sizeof(a)];
    NSData * data_b=[NSData dataWithBytes:&b length:sizeof(b)];
    NSString * randomString16=[NSString stringWithFormat:@"%@%@",
                               [DDString hexStringFromData:data_a],
                               [DDString hexStringFromData:data_b]];
    return randomString16;
}
+(NSString *)routerIp {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0)
    {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        //*/
        while(temp_addr != NULL)
        {
            if(temp_addr->ifa_addr->sa_family == AF_INET)
            {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
                {
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    //routerIP----192.168.1.255 广播地址
                    NSLog(@"broadcast address--%@",[NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_dstaddr)->sin_addr)]);
                    //--192.168.1.106 本机地址
                    NSLog(@"local device ip--%@",[NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)]);
                    //--255.255.255.0 子网掩码地址
                    NSLog(@"netmask--%@",[NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_netmask)->sin_addr)]);
                    //--en0 端口地址
                    NSLog(@"interface--%@",[NSString stringWithUTF8String:temp_addr->ifa_name]);
                    
                }
                
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    in_addr_t i =inet_addr([address cStringUsingEncoding:NSUTF8StringEncoding]);
    in_addr_t* x =&i;
    unsigned char *s=getdefaultgateway(x);
    NSString *ip=[NSString stringWithFormat:@"%d.%d.%d.%d",s[0],s[1],s[2],s[3]];
    NSLog(@"路由器地址-----%@",ip);
    return ip;
}
+(void)reflectPropertyValueFromDict:(id)object dict:(NSDictionary*)dict{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([object class], &outCount);
    for (i=0; i<outCount; i++) {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        [object setValue:[dict objectForKey:propertyName] forKey:propertyName];
    }
    free(properties);
}
+(NSDictionary *)reflectDictFromPropertyValue:(id)object{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([object class], &outCount);
    NSMutableDictionary * dict=[[NSMutableDictionary alloc]init];
    for (i=0; i<outCount; i++) {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        NSString * value=[object valueForKey:propertyName];
        if (value==nil) {
            NSLog(@"object has no value for key[%@]",propertyName);
        }else{
            [dict setObject:value forKey:propertyName];
        }
    }
    free(properties);
    return dict;
}
//替换url中的路由地址和随机数
+(NSString *)replaceArgs:(NSString*)urlWithArgs{
//    urlWithArgs=[DDString replace:urlWithArgs src:@"192.168.1.1" replaceWith:@"localhost:8080"];
    urlWithArgs=[DDString replace:urlWithArgs src:@"RANDOM" replaceWith:[NSString stringWithFormat:@"0.%u",arc4random()]];
    return urlWithArgs;
}
@end
