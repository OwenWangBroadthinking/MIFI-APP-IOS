//
//  DDHttpClient.h
//  Roaming
//
//  Created by chendd on 15/8/24.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDHttpClient : NSObject
//通过工厂模式创建HttpClient对象
+(instancetype)createHttpClient;
//发送内容并回调结果
-(void)getDataFromURL:(NSString*)url parameters:(NSDictionary*)parameters dataCallBack:(void (^)(id data))dataCallBack;
-(void)postDataToURL:(NSString*)url parameters:(NSDictionary*)parameters dataCallBack:(void(^)(id data))dataCallBack;
@end
