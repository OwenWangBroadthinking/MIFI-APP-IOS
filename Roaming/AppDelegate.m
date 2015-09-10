//
//  AppDelegate.m
//  Roaming
//
//  Created by chendd on 15/8/24.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "AppDelegate.h"
#import "RoamRAC.h"
#import "DDFile.h"
#import "DDNetWorkUtils.h"
#import "AppDefines.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [RoamRAC sharedRoamRAC];
    [self checkExceptionFileAndSend];
    return YES;
}

-(void)checkExceptionFileAndSend{
    NSString * version=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSString * subject=[NSString stringWithFormat:@"iOS Exception [%@ %@]",[[NSUserDefaults standardUserDefaults] objectForKey:KEY_BINDPHONENUMBER],version];
    NSString * zipFile=nil;
    NSLog(@"日志目录：%@",kLogDirectory);
    NSArray *files = [DDFile GetFileList:kLogDirectory];
    if (files!=nil&&[files count]!=0) {
        NSLog(@"日志文件总数:%lu",(unsigned long)[files count]);
        NSLog(@"压缩目录：%@",kLogDirectory);
        zipFile=[DDFile ArchiveToZip:kLogDirectory];
    }
    NSData * data=[DDFile ReadFromDocumentPath:CORE_DMP_FILE];
    NSString * s=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    if (s!=nil&&s.length>0) {
        //添加发送错误日志邮件对象
        if (zipFile==nil) {
            [DDNetWorkUtils sendTsmMail:self successSEL:@selector(messageSent) failSEL:@selector(messageFailed) email_host:APP_EMAILUSER  subject:subject  message:s];
        }else{
            [DDNetWorkUtils sendTsmMail:self successSEL:@selector(messageSent) failSEL:@selector(messageFailed) email_host:APP_EMAILUSER  subject:subject  message:s attachfile:[[NSArray alloc]initWithObjects:zipFile, nil]];
        }
        
    }
}

#pragma mark - SKPSMTPMessageDelegate
- (void)messageSent
{
    NSLog(@"%@ 发送成功",CORE_DMP_FILE);
    [DDFile RemoveFromDocumentPath:CORE_DMP_FILE];
}

- (void)messageFailed
{
    NSLog(@"%@ 发送失败",CORE_DMP_FILE);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
