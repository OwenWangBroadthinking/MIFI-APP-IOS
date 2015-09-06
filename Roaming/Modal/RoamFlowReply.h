//
//  RoamFlowReply.h
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoamFlowReply : NSObject
+(instancetype)createFlowReplyWithString:(NSString*)string;
@property (nonatomic, copy) NSString * totalFlow;
@property (nonatomic, copy) NSString * usedFlow;
@end
