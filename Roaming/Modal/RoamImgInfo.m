//
//  RoamImgInfo.m
//  Roaming
//
//  Created by chendd on 15/8/27.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "RoamImgInfo.h"
#import "Tool.h"
@implementation RoamImgInfo
+(instancetype)createImgInfoWithDict:(NSDictionary*)dict{
    RoamImgInfo * imgInfo=[[RoamImgInfo alloc]init];
    [Tool reflectPropertyValueFromDict:imgInfo dict:dict];
    return imgInfo;
}
@end
