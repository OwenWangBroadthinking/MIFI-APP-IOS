//
//  WaitConnectViewController.m
//  Roaming
//
//  Created by 陈丁丁 on 15/9/1.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "WaitConnectViewController.h"
#import "MatchPhoneViewController.h"
#import "RoamUdpBusi.h"
#import "RoamRAC.h"
#import "AppDefines.h"
#import "DDString.h"
@interface WaitConnectViewController()<RoamRACDelegate>
@property (weak, nonatomic) IBOutlet UILabel *referMessage;
@property (weak, nonatomic) IBOutlet UIButton *btn_register;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@end
@implementation WaitConnectViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    [self checkIfConnectMifi];
}

-(void)checkIfConnectMifi{
    //发送一个查询绑定状态的UDP报文
    //等待10秒
    [RoamUdpBusi getBindState:self];
    
}
#pragma mark RoamRACDelegate
-(void)roamRAC:(id)roamRAC bindState:(RoamBindState *)bindState{
    dispatch_async(dispatch_get_main_queue(), ^{
    //已经连接Mifi,判断绑定状态
    if(bindState.isBinded){
        //判断本地存储的手机号是否是
        NSString * bindPhone=[[NSUserDefaults standardUserDefaults]objectForKey:KEY_BINDPHONENUMBER];
        //暂时认为所有的绑定信息是手机号
        NSString * servBindPhone=[DDString stringFromHexString:bindState.bindData];
        if ([bindPhone isEqualToString:servBindPhone]) {
            NSLog(@"绑定手机号与本地保存一致");
            [self dismissViewControllerAnimated:NO completion:^{
                [[RoamRAC sharedRoamRAC].mainViewController startRunLoop];
            }];
        }else{
            NSLog(@"绑定手机号与本地保存不一致，跳转到校验手机号页面");
            
                [self dismissViewControllerAnimated:NO completion:^{
                    [[RoamRAC sharedRoamRAC].mainViewController performSegueWithIdentifier:@"matchPhoneSegue" sender:servBindPhone];
                }];
            
        }
    }else{
        //未绑定的话，则提示一下，请先注册手机号
        Toast(appD.window, @"Mifi未绑定，请先注册手机号") ;
    }
        });
    
}
- (IBAction)registerNow:(id)sender {
    [self dismissViewControllerAnimated:NO completion:^{
        [[RoamRAC sharedRoamRAC].mainViewController performSegueWithIdentifier:@"registerSegue" sender:nil];
    }];
}

-(void)roamRAC:(id)roamRAC udpError:(NSString *)udpError{
    //继续检测是否是Mifi
    [RoamUdpBusi getBindState:self];
    
}
@end
