//
//  RegisterSuccessViewController.m
//  Roaming
//
//  Created by chendd on 15/9/2.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "RegisterSuccessViewController.h"
#import "RoamUdpBusi.h"
#import "RoamRAC.h"
#import "Tool.h"
#import "AppDefines.h"
#import "DDString.h"
@interface RegisterSuccessViewController()<RoamRACDelegate>
@property (weak, nonatomic) IBOutlet UILabel *phonenumber;
@property (weak, nonatomic) IBOutlet UILabel *deviceno;
@property (weak, nonatomic) IBOutlet UILabel *referMessage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (nonatomic, copy) NSString * registerPhone;
@end
@implementation RegisterSuccessViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    _phonenumber.text=_registerPhone;
    _deviceno.text=@" ";
    [self checkIfConnectMifi];
}
-(void)checkIfConnectMifi{
    //发送一个查询绑定状态的UDP报文
    //等待10秒
    [RoamUdpBusi getBindState:self];
    
}
- (IBAction)bind:(id)sender {
    if (_deviceno.text.length==12) {
        SHOWHUD(@"正在绑定");
        [RoamUdpBusi bind:self phonenumber:_registerPhone];
    }else{
        [Tool showAlertWithMessage:@"Mifi物理地址未得到"];
    }
}
#pragma mark RoamRACDelegate
-(void)roamRAC:(id)roamRAC bindState:(RoamBindState *)bindState{
    if (bindState.isBinded){
        [Tool showAlertWithMessage:@"Mifi已经绑定，请重新打开客户端"];
    }else{
        _referMessage.text=@"已连接Mifi";
        SHOWHUD(@"获取Mifi设备编号");
        [RoamUdpBusi getMifiMac:self];
    }
    
}
-(void)roamRAC:(id)roamRAC udpError:(NSString *)udpError{
    //继续检测是否是Mifi
    [RoamUdpBusi getBindState:self];
}
-(void)roamRAC:(id)roamRAC MifiMac:(NSString *)MifiMac{
    _deviceno.text=[DDString stringFromHexString:MifiMac];
    HIDEHUD;
}
-(void)roamRAC:(id)roamRAC bindReply:(RoamBindReply *)bindReply{
    HIDEHUD;
    if(bindReply.bindSuccess){
        Toast(appD.window, @"绑定成功");
        [[NSUserDefaults standardUserDefaults] setObject:_registerPhone forKey:KEY_BINDPHONENUMBER];
        [self dismissViewControllerAnimated:NO completion:nil];
        
    }else{
        [Tool showAlertWithMessage:@"绑定失败"];
    }
}

@end
