//
//  RoamProfile.h
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoamProfile : NSObject
+(instancetype)createProfileWithDict:(NSDictionary*)dict;
@property (nonatomic, copy) NSString * profile_id;
@property (nonatomic, copy) NSString * profile_type;
@property (nonatomic, copy) NSString * profile_name;
@property (nonatomic, copy) NSString * profile_username;
@property (nonatomic, copy) NSString * profile_number;
@property (nonatomic, copy) NSString * profile_password;
@property (nonatomic, copy) NSString * profile_apn;
@property (nonatomic, copy) NSString * profile_protocol;
@property (nonatomic, copy) NSString * profile_defualt;
@end
