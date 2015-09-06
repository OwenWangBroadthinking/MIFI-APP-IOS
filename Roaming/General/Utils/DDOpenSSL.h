//
//  MKOpenSSL.h
//  TSMClientCore
//
//  Created by chendd on 14-5-24.
//  Copyright (c) 2014年 chendd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
//实现加解密算法，MD5 SHA1 DES 3DES等
@interface DDOpenSSL : NSObject
/**
 *  MD5算法 32位
 *
 *  @param s 需要生成MD5的数据
 *
 *  @return MD5运算后的结果
 */
+(NSString *)Md5:(NSData*)s;//转换后的结果是可见字符
/**
 *  SHA1算法 40位
 *
 *  @param data 需要生成SHA1的数据
 *
 *  @return SHA1运算后的结果
 */
+(NSString *)Sha1:(NSData*)data;//转换后的结果是可见字符
@end
