//
//  RoamMacFilterInfo.h
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoamMacFilterInfo : NSObject
+(instancetype)createMacFilterInfoWithDict:(NSDictionary*)dict;
@property (nonatomic, copy) NSString * filter_policy;
@property (nonatomic, copy) NSString * mac_address_num;
@property (nonatomic, strong) NSArray * data;
@property (nonatomic, copy) NSString * error;
@end
