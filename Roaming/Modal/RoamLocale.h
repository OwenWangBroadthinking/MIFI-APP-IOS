//
//  RoamLocale.h
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoamLocale : NSObject
+(instancetype)createLocaleWithDict:(NSDictionary*)dict;
@property (nonatomic, copy) NSString * language;
@property (nonatomic, copy) NSString * error;
@end
