//
//  RoamLoginReply.h
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoamLoginReply : NSObject
+(instancetype)createLoginReplyWithDict:(NSDictionary*)dict;
@property (nonatomic, copy) NSString * login_result;
@property (nonatomic, copy) NSString * error;
@end
