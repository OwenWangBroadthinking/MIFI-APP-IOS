//
//  MKFile.m
//  TSMClientCore
//
//  Created by chendd on 14-5-26.
//  Copyright (c) 2014年 chendd. All rights reserved.
//

#import "DDFile.h"
#import "DDString.h"
#import "DDGzip.h"
#import <ZipArchive/ZipArchive.h>
@implementation DDFile
+(NSData*)ReadFromDocumentPath:(NSString*)path{

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * filepath=[[paths objectAtIndex:0] stringByAppendingPathComponent:path];
    return [NSData dataWithContentsOfFile:filepath ];
}
+(BOOL)WriteToDocumentPath:(NSString*)path content:(NSData*)content{
    //need To Complete
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * filepath=[[paths objectAtIndex:0] stringByAppendingPathComponent:path];
    return [self Write:filepath content:content];
}
+(BOOL)WriteStringToDocumentPath:(NSString*)path content:(NSString*)content{
    return [self WriteToDocumentPath:path content:[content dataUsingEncoding:NSUTF8StringEncoding] ];
}

+(BOOL)RemoveFromDocumentPath:(NSString*)path{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * filepath=[[paths objectAtIndex:0] stringByAppendingPathComponent:path];
    return [self Remove:filepath];
}
+(BOOL)Write:(NSString*)path content:(NSData*)content{
    if ([content writeToFile:path atomically:YES]) {
        return YES;
    }else
    {
        [NSException raise:@"Write Error" format:@"Cannot write to %@", path];
        return NO;
    }
    
}
+(NSData*)Read:(NSString*)path{
    return [NSData dataWithContentsOfFile:path ];
}
+(BOOL)Remove:(NSString*)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager removeItemAtPath:path error:nil];
}
+(BOOL)Exist:(NSString*)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir=NO;
    BOOL isExist=[fileManager fileExistsAtPath:path isDirectory:&isDir];
    return isExist&&!isDir;
}
+(BOOL)ExistDir:(NSString*)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir=NO;
    BOOL isExist= [fileManager fileExistsAtPath:path isDirectory:&isDir];
    return isExist&&isDir;
}
+(NSString *)getFileNameFromPath:(NSString*)path{
    NSArray * arr=[DDString split:path token:@"/"];
    return [arr objectAtIndex:[arr count]-1];
}
+(NSArray *)GetFileList:(NSString*)path{
    NSMutableArray *filenamelist = [NSMutableArray arrayWithCapacity:10];
    NSArray *tmplist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    for (NSString *filename in tmplist) {
        NSString *fullpath = [path stringByAppendingPathComponent:filename];
        if ([self Exist:fullpath ]) {
            [filenamelist  addObject:fullpath];
        }
    }
    return filenamelist;
}

+(NSString*)ArchiveToZip:(NSString*)path{
    NSString * zipFile=nil;
    NSLog(@"进入压缩");
    //打包
    //1、根据path获取要打包的路径
    zipFile=[NSString stringWithFormat:@"%@.zip",path];
    //2、需要判断是文件还是目录
    ZipArchive *za1 = [[ZipArchive alloc] init];
    [za1 CreateZipFile2:zipFile];
    if ([self Exist:path]) {//是文件
        if (![za1 addFileToZip:path newname:[self getFileNameFromPath:path]]) {
            [za1 CloseZipFile2];
            return nil;
        }
    }else if([self ExistDir:path]){//是目录
        NSLog(@"是目录，执行压缩");
        NSArray *tmplist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
        for (NSString* filename in tmplist) {
            if (![za1 addFileToZip:[path stringByAppendingPathComponent:filename] newname:filename]) {
                //NSLog(@"添加失败");
                [za1 CloseZipFile2];
                return nil;
            }
            
        }
    }else
        return nil;
    // 7 把zip从内存中写入到磁盘中去
    BOOL success =  [za1 CloseZipFile2];
    if (!success) {
        NSLog(@"压缩失败：");
        return nil;
       
    }
    NSLog(@"压缩完成");
    return zipFile;
}


+ (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}
//单个文件的大小
+ (float) fileSizeAtPath:(NSString*) filePath{
    
    //
    //    NSData* data = [NSData dataWithContentsOfFile:[VoiceRecorderBaseVC getPathByFileName:_convertAmr ofType:@"amr"]];
    //    NSLog(@"amrlength = %d",data.length);
    //    NSString * amr = [NSString stringWithFormat:@"amrlength = %d",data.length];
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){
        
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize]/(1024.0*1024);
    }
    return 0;
    
}
@end
