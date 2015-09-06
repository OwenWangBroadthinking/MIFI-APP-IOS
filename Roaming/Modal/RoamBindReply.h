//
//  RoamBindReply.h
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoamBindReply : NSObject
+(instancetype)createBindReplyWithString:(NSString*)string;
@property (nonatomic, assign) BOOL bindSuccess;
@property (nonatomic, copy) NSString * macAddress;
@end
