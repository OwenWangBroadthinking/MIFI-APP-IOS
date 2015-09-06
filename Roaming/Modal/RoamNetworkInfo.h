//
//  RoamNetworkInfo.h
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoamNetworkInfo : NSObject
+(instancetype)createNetworkInfoWithDict:(NSDictionary*)dict;
@property (nonatomic, copy) NSString * nw_mode;
@property (nonatomic, copy) NSString * nw_sel_mode;
@property (nonatomic, copy) NSString * error;
@end
