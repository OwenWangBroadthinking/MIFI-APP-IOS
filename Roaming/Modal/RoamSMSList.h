//
//  RoamSMSList.h
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoamSMSList : NSObject
+(instancetype)createSMSListWithDict:(NSDictionary *)dict;
@property (nonatomic, strong) NSArray * data;
@property (nonatomic, copy) NSString * sms_count;
@property (nonatomic, copy) NSString * oper;
@property (nonatomic, copy) NSString * error;

@end
