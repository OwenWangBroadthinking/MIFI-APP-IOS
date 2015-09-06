//
//  MKRegex.h
//  TSMClientUtils
//
//  Created by chendd on 14/7/8.
//  Copyright (c) 2014年 chendd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDRegex : NSObject
+(BOOL)isValidateEmail:(NSString *)email;
+(BOOL)isValidateTelNumber:(NSString*)number;
+(BOOL)isValidateCardNo:(NSString*)number;
+(BOOL)isValidateCardPass:(NSString *)password;
+(BOOL)isValidatePassword:(NSString *)password;
+(BOOL)isValidateMoney:(NSString*)money maxlength:(int)maxlength maxmoney:(float)maxmoney;
@end
