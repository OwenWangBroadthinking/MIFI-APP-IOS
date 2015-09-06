//
//  MKBase64.h
//  TSMClientCore
//
//  Created by chendd on 14-5-26.
//  Copyright (c) 2014年 chendd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

@interface DDBase64 : NSObject
/**
 *  BASE64编码加密文本
 *
 *  @param text 需要加密的文本
 *
 *  @return 加密后的结果
 */
+(NSString*)Encrypt:(NSData*)text;
/**
 *  BASE64编码解密文本
 *
 *  @param text 需要解密的文本
 *
 *  @return 解密后的结果
 */
+(NSData*)Decrypt:(NSString*)text;
@end

/***********************************
 
 NSLog(@"%@",[[TSMGlobalVal me] CommPrePbcKey] );
 NSLog(@"%@",[MKString hexStringFromData:[MKBase64 Decrypt:[[TSMGlobalVal me] CommPrePbcKey] ] ]  );
***********************************/