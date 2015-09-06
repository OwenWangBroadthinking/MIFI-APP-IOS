//
//  RoamLoginParameter.h
//  Roaming
//
//  Created by 陈丁丁 on 15/8/29.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoamLoginParameter : NSObject
+(instancetype)createLoginParameterWithUserName:(NSString*)username
                                    andPassword:(NSString*)password;
@property (nonatomic, copy) NSString * username;
@property (nonatomic, copy) NSString * password;
@property (nonatomic, strong) NSDictionary * dict;
@end
