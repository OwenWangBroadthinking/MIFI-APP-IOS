//
//  MKFile.h
//  TSMClientCore
//
//  Created by chendd on 14-5-26.
//  Copyright (c) 2014年 chendd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDFile : NSObject
/**
 *  读取指定路径文件内容
 *
 *  @param path 相对Document的路径
 *
 *  @return 文件的所有内容
 */
+(NSData*)ReadFromDocumentPath:(NSString*)path;
/**
 *  在Document目录下写入文件
 *
 *  @param path    相对Document的路径
 *  @param content 需要写入的内容
 *
 *  @return 写入成功与否
 */
+(BOOL)WriteToDocumentPath:(NSString*)path content:(NSData*)content;
/**
 *  在Document目录下写入文件
 *
 *  @param path    相对Document的路径
 *  @param content 需要写入的内容
 *
 *  @return 写入成功与否
 */
+(BOOL)WriteStringToDocumentPath:(NSString*)path content:(NSString*)content;
/**
 *  删除Document目录下的文件
 *
 *  @param path 相对Document的路径
 *
 *  @return 删除是否成功
 */
+(BOOL)RemoveFromDocumentPath:(NSString*)path;
/**
 *  在指定路径下写入内容
 *
 *  @param path    指定路径
 *  @param content 内容
 *
 *  @return 是否写入成功
 */
+(BOOL)Write:(NSString*)path content:(NSData*)content;
/**
 *  判断指定文件是否存在
 *
 *  @param path 指定路径
 *
 *  @return 是否存在
 */
+(BOOL)Exist:(NSString*)path;
/**
 *  删除指定路径文件
 *
 *  @param path 指定路径
 *
 *  @return 是否成功
 */
+(BOOL)Remove:(NSString*)path;
/**
 *  获取目录下的所有文件
 *
 *  @param path 指定目录
 *
 *  @return 文件列表
 */
+(NSArray *)GetFileList:(NSString*)path;
/**
 *  压缩文件
 *
 *  @param path 文件路径
 *
 *  @return 返回压缩文件的路径
 */
+(NSString*)ArchiveToZip:(NSString*)path;

/**
 *  获取文件夹大小
 *
 *  @param folderPath 文件夹路径
 *
 *  @return 大小
 */
+ (float ) folderSizeAtPath:(NSString*) folderPath;
/**
 *  获取文件大小
 *
 *  @param filePath 文件路径
 *
 *  @return 大小
 */
+ (float) fileSizeAtPath:(NSString*) filePath;

@end
