//
//  MKOpenSSL.m
//  TSMClientCore
//
//  Created by chendd on 14-5-24.
//  Copyright (c) 2014年 chendd. All rights reserved.
//

#import "DDOpenSSL.h"

@implementation DDOpenSSL
+(NSString *)Md5:(NSData *) data{
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5([data bytes],(unsigned int)[data length],result);
    NSMutableString * hash=[NSMutableString string];
    for(int i=0;i<CC_MD5_DIGEST_LENGTH;i++){
        [hash appendFormat:@"%02X",result[i]];
    }
    return hash;
}
//SHA1加签
+(NSString *) Sha1:(NSData*)data
{
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    NSMutableString *hash = [NSMutableString string];
    for (int i=0;i<CC_SHA1_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02X",digest[i] ];
    }
    return hash;
}
@end
