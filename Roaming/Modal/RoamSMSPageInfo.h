//
//  RoamSMSPageInfo.h
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoamSMSPageInfo : NSObject
+(instancetype)createSMSPageInfoWithDict:(NSDictionary*)dict;
@property (nonatomic, strong) NSString * total_page_count;
@property (nonatomic, strong) NSString * curr_sms_count;
@property (nonatomic, strong) NSString * error;
@end
