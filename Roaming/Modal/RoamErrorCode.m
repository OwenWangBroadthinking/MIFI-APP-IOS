//
//  RoamErrorCode.m
//  Roaming
//
//  Created by chendd on 15/8/28.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "RoamErrorCode.h"
@interface RoamErrorCode()
@property (nonatomic, strong) NSDictionary *dict;
@end
@implementation RoamErrorCode
+(instancetype)sharedErrorCode{
    static RoamErrorCode * errorCode=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      if (errorCode==nil) {
                          errorCode= [[RoamErrorCode alloc] init];
                      }
                  });
    return errorCode;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _dict=@{
                @"200":@"OK",
                @"3001":@"标识信息不存在",
                @"3002":@"标识信息不合法",
                @"3003":@"密码错误",
                @"3004":@"用户尚未登录",
                @"3005":@"服务器忙",
                @"3006":@"应答超时",
                @"3007":@"无可用SIM",
                @"3008":@"数据内容错误",
                @"3009":@"token错误",
                @"3010":@"登录认证失败",
                @"3011":@"http请求访问资源不存在",
                @"3014":@"http请求的参数为空"
                };
    }
    return self;
}
+(NSString*)ErrorDescription:(NSString*)errorCode{
    NSDictionary * errorCodeDict=@{};
    return [errorCodeDict objectForKey:errorCode];
}
@end
