//
//  RoamBindState.h
//  Roaming
//
//  Created by chendd on 15/8/26.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoamBindState : NSObject
+(instancetype)createBindStateWithData:(NSData*)data;
+(instancetype)createBindStateWithString:(NSString *)String;
@property (nonatomic, assign) BOOL isBinded;
@property (nonatomic, assign) int bindType;
@property (nonatomic, assign) int bindDataLength;
@property (nonatomic, copy) NSString * bindData;
@end
