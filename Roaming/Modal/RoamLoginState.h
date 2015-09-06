//
//  RoamLoginState.h
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoamLoginState : NSObject
+(instancetype)createLoginStateWithDict:(NSDictionary*)dict;
@property (nonatomic, copy) NSString * loginStatus;
@property (nonatomic, copy) NSString * error;
@end
