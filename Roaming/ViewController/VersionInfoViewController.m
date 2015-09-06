//
//  VersionInfoViewController.m
//  Roaming
//
//  Created by chendd on 15/9/1.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "VersionInfoViewController.h"
#import "RoamUdpBusi.h"
#import "RoamRAC.h"
#import "DDString.h"
@interface VersionInfoViewController()<RoamRACDelegate>
@property (weak, nonatomic) IBOutlet UILabel *MifiVersion;
@property (weak, nonatomic) IBOutlet UILabel *AppVersion;
@end
@implementation VersionInfoViewController
- (IBAction)backClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewDidLoad{
    [super viewDidLoad];
    NSString* version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    _AppVersion.text=version;
    _MifiVersion.text=@"";
    [RoamUdpBusi getMifiVersion:self];
}
-(void)roamRAC:(id)roamRAC MifiVersion:(NSString *)MifiVersion{
    _MifiVersion.text=[DDString stringFromHexString:MifiVersion];
}
@end
