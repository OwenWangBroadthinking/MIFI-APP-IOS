//
//  RigisterViewController.m
//  Roaming
//
//  Created by 陈丁丁 on 15/9/2.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "RegisterViewController.h"
#import "RoamHttpBusi.h"
#import "Tool.h"
#import "RoamRAC.h"
#import "DDRegex.h"
#import "AppDefines.h"
@interface RegisterViewController()<RoamRACDelegate>
@property (weak, nonatomic) IBOutlet UIView *bkview;
@property (weak, nonatomic) IBOutlet UITextField *tv_phone;

@end
@implementation RegisterViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    UITapGestureRecognizer * gusture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bkview_touch)];
    [_bkview addGestureRecognizer:gusture];
}
-(void)bkview_touch{
    [_tv_phone resignFirstResponder];
}
- (IBAction)registor:(id)sender {
    
    [_tv_phone resignFirstResponder];
    NSString * phonenumber=_tv_phone.text;
    if (phonenumber.length==0) {
        [Tool showAlertWithMessage:@"手机号为空"];
        return;
    }
    if( ![DDRegex isValidateTelNumber:phonenumber]){
        [Tool showAlertWithMessage:@"输入的非有效手机号"];
        return;
    }
    SHOWHUD(@"正在注册");
    [RoamHttpBusi register:self username:_tv_phone.text password:@"12345678"];
}
-(void)roamRAC:(id)roamRAC registerReply:(RoamRegisterReply *)registerReply{
    if (registerReply.code==-1) {
        [Tool showAlertWithMessage:@"服务器无响应，请检查网络"];
    }else{
        if (registerReply.code==200) {
            HIDEHUD;
            [self dismissViewControllerAnimated:NO completion:^{
                Toast(appD.window, @"注册成功");
                [[RoamRAC sharedRoamRAC].mainViewController performSegueWithIdentifier:@"registerSuccessSegue" sender:_tv_phone.text];
            }];
        }else{
            HIDEHUD;
            if (registerReply.msg!=nil&&
                [registerReply.msg hasPrefix:@"roam_user_index is duplicate"]){
                Toast(appD.window, @"该手机号已经注册");
                [self dismissViewControllerAnimated:NO completion:^{
                    [[RoamRAC sharedRoamRAC].mainViewController performSegueWithIdentifier:@"registerSuccessSegue" sender:_tv_phone.text];
                }];
            }else
                [Tool showAlertWithMessage:@"注册失败"];
            
        
        }
    }
}

#pragma mark
@end
