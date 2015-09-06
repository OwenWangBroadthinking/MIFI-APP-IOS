//
//  MKString.h
//  TSMClientCore
//
//  Created by chendd on 14-5-24.
//  Copyright (c) 2014年 chendd. All rights reserved.
//

#import <Foundation/Foundation.h>
//此类主要是方便程序源编写代码，与其他语言的语法类似
//特殊的字符串转换
@interface DDString : NSObject
/**
 *  16进制字符串转为字符串
 *
 *  @param hexString 16进制字符串
 *
 *  @return 转换后的字符串
 */
+ (NSString *)stringFromHexString:(NSString *)hexString;
/**
 *  字符串转为16进制字符串
 *
 *  @param string 字符串
 *
 *  @return 转换后的字符串
 */
+ (NSString *)hexStringFromString:(NSString *)string;
/**
 *  数据转换为16进制字符串
 *
 *  @param data 数据
 *
 *  @return 转换后的字符串
 */
+ (NSString *)hexStringFromData:(NSData *)data;
/**
 *  16进制字符串转换为数据
 *
 *  @param hexString 16进制字符串
 *
 *  @return 转换后的数据
 */
+ (NSData *)dataFromHexString:(NSString*)hexString;
//简化substr的写法
+ (NSString *)substr:strng start:(int)start length:(int)length;
+ (NSString *)substr:strng start:(int)start;
+ (NSData *)subdata:data start:(int)start length:(int)length;
+(NSData*)subdata:(NSData*)data start:(int)start;
+ (NSString *)subdataToString:data start:(int)start length:(int)length;
+ (NSArray *)split:(NSString*)strng token:(NSString*)token;
+ (NSString *)replace:(NSString*)strng src:(NSString*)src replaceWith:(NSString*)replaceWith;
+(NSString *)removeright:(NSString*)strng token:(NSString*)token;
+(NSString *)removeleft:(NSString*)strng token:(NSString *)token;
+(NSString*)between:(NSString*)strng begin:(NSString*)begin end:(NSString*)end;
+(NSString*)FenToYuan:(NSString*)strng;
+(BOOL)containString:(NSString*)strng sub:(NSString*)sub;
+(unsigned long)strtoul:(NSString*)strng;
+(NSData *)reverse:(NSData*)source;
@end
