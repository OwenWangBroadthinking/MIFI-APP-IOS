//
//  MKString.m
//  TSMClientCore
//
//  Created by chendd on 14-5-24.
//  Copyright (c) 2014年 chendd. All rights reserved.
//

#import "DDString.h"

@implementation DDString
+ (NSString *)stringFromHexString:(NSString *)hexString { //
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr] ;
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    free(myBuffer);
    return unicodeString;
} 
+ (NSString *)hexStringFromString:(NSString *)string{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr]; 
    } 
    return hexStr; 
}
+(NSString *)hexStringFromData:(NSData *)data{
    unsigned char * cc=(unsigned char*)[data bytes];
    NSString * hexStr=@"";
    for(int i=0;i<[data length];i++)
    {
        hexStr=[hexStr stringByAppendingString:[NSString stringWithFormat:@"%02X",cc[i]]];
    }
    return hexStr;
}
+(NSData *)dataFromHexString:(NSString*)hexString{
    if (hexString==nil||[hexString length]==0) {
        return nil;
    }
    char * myBuffer=(char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr] ;
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSMutableData * data=[NSMutableData dataWithBytes:myBuffer length:[hexString length]/2];
    free(myBuffer);
    return data;
}
+ (NSString *)substr:(NSString*)strng start:(int)start length:(int)length{
    if (strng.length<start+length) {
        return nil;
    }
    return [strng substringWithRange:NSMakeRange(start, length)];
}
+ (NSString *)substr:(NSString*)strng start:(int)start{
    if (strng.length<start) {
        return nil;
    }
    return [strng substringFromIndex:start];
}
+ (NSData *)subdata:data start:(int)start length:(int)length{
    return [data subdataWithRange:NSMakeRange(start, length) ];
}
+(NSData*)subdata:(NSData*)data start:(int)start{
    if (start>=data.length) {
        return nil;
    }
    return [data subdataWithRange:NSMakeRange(start, [data length]-start)];
}
+ (NSString *)subdataToString:data start:(int)start length:(int)length{
    NSData * sub=[DDString subdata:data start:start length:length] ;
    return [[NSString alloc]initWithData:sub encoding:NSUTF8StringEncoding];
}
+ (NSArray *)split:(NSString*)strng token:(NSString*)token{
    return [strng componentsSeparatedByString:token];
}
+ (NSString *)replace:(NSString*)strng src:(NSString*)src replaceWith:(NSString*)replaceWith{
    return [strng stringByReplacingOccurrencesOfString:src withString:replaceWith];
}
+(NSString *)removeright:(NSString*)strng token:(NSString*)token{
    NSRange range=[strng rangeOfString:token];
    if (range.location==NSNotFound) {
        return strng;
    }
    return [strng substringToIndex:range.location];
}
+(NSString *)removeleft:(NSString*)strng token:(NSString *)token{
    NSRange range=[strng rangeOfString:token];
    if (range.location==NSNotFound) {
        return strng;
    }
    return [strng substringFromIndex:range.location+range.length];
}
+(NSString*)between:(NSString *)strng begin:(NSString *)begin end:(NSString *)end{
    NSRange range_begin=[strng rangeOfString:begin];
    if (range_begin.location!=NSNotFound) {
        NSString * right=[strng substringFromIndex:range_begin.location+range_begin.length];
        NSRange range_end=[right rangeOfString:end];
        if (range_end.location!=NSNotFound) {
            NSString*ret=[right substringToIndex:range_end.location];
            return ret;
        }
    }
    return @"";
}
+(NSString*)FenToYuan:(NSString*)strng{
    if (strng==nil)
        return @"";
    long long int number = [strng longLongValue];
    float f = number/100.0f;
    NSString * balance = [NSString stringWithFormat:@"%.2f", f];
    return balance;
}
+(BOOL)containString:(NSString*)strng sub:(NSString*)sub{
    NSRange range=[strng rangeOfString:sub];
    return range.location!=NSNotFound;
}

+(unsigned long)strtoul:(NSString*)strng{
    unsigned long ul=strtoul([[NSString stringWithFormat:@"0x%@",strng]UTF8String],0,16);
    return ul;
}
+(NSData *)reverse:(NSData*)source{
    NSMutableData * data=[[NSMutableData alloc]init];
    const void * p=[source bytes];
    for (int i=(int)source.length-1; i>=0; i--) {
        [data appendBytes:p+i length:1];
    }
    return data;
}
@end
