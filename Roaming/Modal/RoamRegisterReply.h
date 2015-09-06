//
//  RoamRegistorReply.h
//  Roaming
//
//  Created by chendd on 15/9/2.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoamRegisterReply : NSObject
+(instancetype)createRegistorReplyWithDict:(NSDictionary*)dict;
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, copy) NSString * msg;
@end
