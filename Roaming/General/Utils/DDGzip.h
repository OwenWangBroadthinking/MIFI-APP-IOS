//
//  MKZlib.h
//  TSMClientCore
//
//  Created by chendd on 14-5-24.
//  Copyright (c) 2014年 chendd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <zlib.h>
@interface DDGzip : NSObject
/**
 *  Gzip压缩数据
 *
 *  @param data 需要压缩的数据
 *
 *  @return 压缩后的结果
 */
+(NSData *)compress:(NSData * )data;
/**
 *  Gzip解压数据
 *
 *  @param data 需要解压的数据
 *
 *  @return 解压后的结果
 */
+(NSData *)decompress:(NSData *)data;
@end
