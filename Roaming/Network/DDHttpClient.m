//
//  DDHttpClient.m
//  Roaming
//
//  Created by chendd on 15/8/24.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "DDHttpClient.h"
#import <AFNetworking.h>
#import <AFURLRequestSerialization.h>
@implementation DDHttpClient
+(instancetype)createHttpClient{
    DDHttpClient * httpClient=[[DDHttpClient alloc]init];
    return httpClient;
}
-(void)getDataFromURL:(NSString *)url parameters:(NSDictionary*)parameters dataCallBack:(void (^)(id data))dataCallBack{
    NSLog(@"request %@",url);
    NSString * m_url=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //接受返回类型为text/html，服务器返回的数据并非json格式
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", nil];
    [manager GET:m_url parameters:parameters success:^(AFHTTPRequestOperation * operation,id responseObject) {
        NSLog(@"reponseObject ok");
        NSLog(@"%@",responseObject);
        dataCallBack(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)  {
        NSLog(@"reponseObject error \n %@",error.description);
        dataCallBack(nil);
    }];
}
-(void)postDataToURL:(NSString*)url parameters:(NSDictionary*)parameters dataCallBack:(void(^)(id data))dataCallBack{
    NSLog(@"request %@",url);
    NSString * m_url=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //接受返回类型为text/html，服务器返回的数据并非json格式
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", nil];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    NSLog(@"%@",parameters);
    [manager POST:m_url parameters:parameters success:^(AFHTTPRequestOperation * operation,id responseObject) {
        NSLog(@"reponseObject ok");
        NSLog(@"%@",responseObject);
        dataCallBack(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)  {
        NSLog(@"reponseObject error \n %@",error.description);
        dataCallBack(nil);
    }];
}
@end
