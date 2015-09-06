//
//  MatchPhoneViewController.m
//  Roaming
//
//  Created by 陈丁丁 on 15/9/2.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "MatchPhoneViewController.h"
#import "Tool.h"
#import "DDRegex.h"
#import "AppDefines.h"
@interface MatchPhoneViewController()
@property (weak, nonatomic) IBOutlet UITextField *tf_phone;
@property (weak, nonatomic) IBOutlet UILabel *refer1;
@property (weak, nonatomic) IBOutlet UILabel *refer2;
@property (strong, nonatomic) IBOutlet UIView *bkView;
@property (nonatomic, copy) NSString * servBindPhone;
@end
@implementation MatchPhoneViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    UITapGestureRecognizer * gusture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bkView_click:)];
    [_bkView addGestureRecognizer:gusture];
}
- (IBAction)match:(id)sender {
    [_tf_phone resignFirstResponder];
    NSString * phonenumber=_tf_phone.text;
    if (phonenumber.length==0) {
        [Tool showAlertWithMessage:@"手机号为空"];
        return;
    }
    if( ![DDRegex isValidateTelNumber:phonenumber]){
        [Tool showAlertWithMessage:@"输入的非有效手机号"];
        return;
    }
    if (![phonenumber isEqualToString:_servBindPhone]) {
        _refer1.text=[NSString stringWithFormat:@"手机号码不匹配[%@]",_servBindPhone ];
        _refer2.text=@"";
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:_servBindPhone forKey:KEY_BINDPHONENUMBER];
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}
-(void)bkView_click:(id)sender{
    [_tf_phone resignFirstResponder];
}
@end
