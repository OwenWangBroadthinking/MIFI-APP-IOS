//
//  RoamCurrentProfile.h
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoamCurrentProfile : NSObject
+(instancetype)createCurrentProfileWithDict:(NSDictionary *)dict;
@property (nonatomic, copy) NSString * profile_id;
@property (nonatomic, copy) NSString * error;
@end
