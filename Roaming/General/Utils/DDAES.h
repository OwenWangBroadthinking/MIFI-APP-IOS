//
//  DDAES.h
//  Roaming
//
//  Created by 陈丁丁 on 15/8/30.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
@interface DDAES : NSObject
+(NSData *) encrypt:(NSData*)source key:(NSString *)key;
+(NSData *) encrypt:(NSData*)source datakey:(NSData *)datakey ;
+(NSData *) decrypt:(NSData*)source key:(NSString *)key;
@end
