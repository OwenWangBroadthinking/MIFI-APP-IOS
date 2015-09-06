//
//  RoamUdpBusi.h
//  Roaming
//
//  Created by chendd on 15/8/24.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoamUdpBusi : NSObject
+(void)getBindState:(id)callbackTarget;
+(void)bind:(id)callbackTarget phonenumber:(NSString*)phonenumber;
+(void)disbind:(id)callbackTarget phonenumber:(NSString*)phonenumber;
+(void)activate:(id)callbackTarget phonenumber:(NSString*)phonenumber;
+(void)getMifiMac:(id)callbackTarget;
+(void)getMifiVersion:(id)callbackTarget;
+(void)getUsedFlow:(id)callbackTarget;
@end
