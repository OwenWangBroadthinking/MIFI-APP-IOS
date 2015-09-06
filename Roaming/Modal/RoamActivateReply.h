//
//  RoamActivateReply.h
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoamActivateReply : NSObject
+(instancetype)createActivateReplyWithString:(NSString*)string;
@property (nonatomic, assign) int actvateState;
@property (nonatomic, copy) NSString * activateDate;
@property (nonatomic, copy) NSString * activateTime;
@end
