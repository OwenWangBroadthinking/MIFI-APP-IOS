//
//  RoamProfileList.h
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoamProfileList : NSObject
+(instancetype)createProfileListWithDict:(NSDictionary*)dict;
@property (nonatomic, strong) NSArray * data;//Profile数组
@property (nonatomic, copy) NSString * data_len;
@property (nonatomic, copy) NSString * state;
@property (nonatomic, copy) NSString * error;
@end
