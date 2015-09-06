//
//  MKRegex.m
//  TSMClientUtils
//
//  Created by chendd on 14/7/8.
//  Copyright (c) 2014年 chendd. All rights reserved.
//

#import "DDRegex.h"

@implementation DDRegex
+(BOOL)isValidateRegularExpression:str byExpression:regex
{
    NSPredicate *regextest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [regextest evaluateWithObject:str];
}

+(BOOL)isValidateEmail:(NSString *)email{
    NSString *strRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,5}";
    return [self isValidateRegularExpression:email byExpression:strRegex];
}
//手机号
+(BOOL)isValidateTelNumber:(NSString*)number{
    NSString *strRegex = @"[0-9]{11,15}";
    return [self isValidateRegularExpression:number byExpression:strRegex];
}
//手机号
+(BOOL)isValidateCardNo:(NSString*)number{
    NSString *strRegex = @"[0-9]{16,19}";
    return [self isValidateRegularExpression:number byExpression:strRegex];
}
//银行卡密码
+(BOOL)isValidateCardPass:(NSString *)password{
    NSString * strRegex=@"[0-9]{6}";
    return [self isValidateRegularExpression:password byExpression:strRegex];
    
}
+(BOOL)isValidatePassword:(NSString *)password{
    NSString *strRegex = @"^[A-Za-z0-9]{6,20}";
    if(![self isValidateRegularExpression:password byExpression:strRegex])return NO;
    if([self isValidateRegularExpression:password byExpression:@"[0-9]+"]
    ||[self isValidateRegularExpression:password byExpression:@"[A-Za-z]+"])return NO;
    return YES;
}
+(BOOL)isValidateMoney:(NSString*)money maxlength:(int)maxlength maxmoney:(float)maxmoney{
    NSString *strRegex =[NSString stringWithFormat:@"^[0-9]*(\\.[0-9]{0,2}$|$)"];
    if (![self isValidateRegularExpression:money byExpression:strRegex]) {
        return NO;
    }
    if ([money floatValue]>maxmoney) {
        return NO;
    }
    return YES;
}
@end
