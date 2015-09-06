//
//  Tool.h
//  Roaming
//
//  Created by chendd on 15/8/24.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tool : NSObject

+(void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message;
+(void)showAlertWithMessage:(NSString*)message;
+(NSString*)getTime;
+(NSString*)getISOTime;
+(NSString*)getTimeWithFormat:(NSString*)format;
+(NSString*)getRandomString16;
+(NSString *)routerIp;
+(void)reflectPropertyValueFromDict:(id)object dict:(NSDictionary*)dict;
+(NSDictionary *)reflectDictFromPropertyValue:(id)object;
+(NSString *)replaceArgs:(NSString*)urlWithArgs;
@end
