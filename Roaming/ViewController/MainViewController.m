//
//  MainViewController.m
//  Roaming
//
//  Created by chendd on 15/8/31.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "MainViewController.h"
#import "Tool.h"
#import "RoamRAC.h"
#import "RoamUdpBusi.h"
#import "AppDefines.h"
#import "DDString.h"
#import "RoamHttpBusi.h"
#define kAnimationImages @[@"splash_0", @"splash_1", @"splash_2", @"splash_3", @"splash_4", @"splash_5"]
@interface MainViewController ()<RoamRACDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *cellular;

@property (weak, nonatomic) IBOutlet UIImageView *power;
@property (weak, nonatomic) IBOutlet UILabel *speed;
@property (weak, nonatomic) IBOutlet UILabel *flow;
@property (weak, nonatomic) IBOutlet UIButton *jihuoBut;
@property (weak, nonatomic) IBOutlet UIButton *liuliangBut;
@property (nonatomic, assign) BOOL isConnectedMifi;
@property (nonatomic, strong) UIImageView *animationImageView;
@property (nonatomic, assign) unsigned long lastUsedFlow;
@end

@implementation MainViewController
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=YES;
    [RoamRAC sharedRoamRAC].mainViewController=self;
    self.isConnectedMifi=NO;
    [self createAnimationImageView];
    _flow.text=@"0MB";
    _speed.text=@"0KB/S";
    _lastUsedFlow=0xffffffff;
}
- (void) createAnimationImageView {
    
    // 1. 创建 ImageView
    self.animationImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    self.animationImageView.backgroundColor = [UIColor whiteColor];
    
    // 2. 为 ImageView 创建图片数组
    NSArray * array =@ [@"splash_0",@"splash_1",@"splash_2",@"splash_3",@"splash_4",@"splash_5"];
    
    // 3. 为 ImageView 设置图片数组
    NSMutableArray *images = [[NSMutableArray alloc]init];
    
    for (NSString *image in array) {
        
        [images addObject:[UIImage imageNamed:image]];
        
    }
    self.animationImageView.animationImages = images;
    
    // 4. 为 ImageView 设置动画时长
    self.animationImageView.animationDuration = 1.0f;
    
    // 5. 为 ImageView 设置动画重复次数
    self.animationImageView.animationRepeatCount = 1;
    // 6. 将 ImageView 添加到 self.view 上
    [self.view addSubview:self.animationImageView];
    
    // 7. 开始动画
    [self.animationImageView startAnimating];
    
    [UIView animateWithDuration:0.7 delay:1.0f options: UIViewAnimationOptionCurveLinear  animations:^{
        self.animationImageView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.animationImageView removeFromSuperview];
        if (!self.isConnectedMifi) {
            [self performSegueWithIdentifier:@"waitConnectSegue" sender:nil];
            //启动后台提交错误报告任务
            
        }
    }];
}

-(void)iconTouch{
    [Tool showAlertWithMessage:@"点击个人中心"];
}
- (void)UI{
    
    [self setButtonState:self.jihuoBut];
    [self setButtonState:self.liuliangBut];
    
}

- (void) setButtonState:(UIView *)view{
    
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 4.0f;
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOpacity = 0.3f;
    view.layer.shadowOffset = CGSizeMake(1, 1);
    view.layer.shadowRadius = 1;
    
}
- (IBAction)clickAiction:(id)sender {
    
//    BKAlertView *view = [[BKAlertView alloc] init];
//    [self.view addSubview: view];
    
    
}
- (IBAction)activate:(id)sender {
    SHOWHUD(@"请稍后");
    NSString * phonenumber=[[NSUserDefaults standardUserDefaults] objectForKey:KEY_BINDPHONENUMBER];
    [RoamUdpBusi activate:self phonenumber:phonenumber];
}
#pragma mark RoamRACDelegate
-(void)roamRAC:(id)roamRAC activateReply:(RoamActivateReply *)activateReply{
    HIDEHUD;
    switch (activateReply.actvateState) {
        case 0:
            Toast(appD.window, @"激活失败");
            break;
        case 1:
            Toast(appD.window, @"激活成功");
            NSLog(@"激活日期时间[%@%@]",activateReply.activateDate,activateReply.activateTime);
            //激活成功后可以上外网，此时实时显示速度，电量
            [self startRunLoopReqSpeedAndPower];
            break;
        case 2:
            [Tool showAlertWithMessage:@"Mifi未绑定"];
            break;
        default:
            [Tool showAlertWithMessage:[NSString stringWithFormat:@"激活失败，错误码[%d]",activateReply.actvateState]];
            break;
    }
    
}
-(void)roamRAC:(id)roamRAC flowReply:(RoamFlowReply *)flowReply{
    unsigned long totalFlow=0,usedFlow=0;
    NSData * total_c=[DDString dataFromHexString:flowReply.totalFlow] ;
    NSData * total_cr=[DDString reverse:total_c];
    [total_cr getBytes:&totalFlow length:sizeof(totalFlow)];
    NSData * usedflow_c=[DDString dataFromHexString:flowReply.usedFlow];
    NSData * usedflow_cr=[DDString reverse:usedflow_c];
    [usedflow_cr getBytes:&usedFlow length:sizeof(usedFlow)];
    
    float total_f=totalFlow/1024.00/1024.00;
    NSString * total_text=nil;
    if (total_f>1024.00) {
        total_text=[NSString stringWithFormat:@"%.2fGB",total_f/1024.00];
    }else{
        total_text=[NSString stringWithFormat:@"%.2fMB",total_f];
    }
    _flow.text=total_text;
    float speed_f=0;
    if (_lastUsedFlow!=0xffffffff) {
        speed_f= (usedFlow-_lastUsedFlow)/1024.00/10.00;
    }
    
    _lastUsedFlow=usedFlow;
    _flow.text=[NSString stringWithFormat:@"%.2fKB/S",speed_f];
    [self performSelector:@selector(getUsedFlow) withObject:nil afterDelay:5];
}
-(void)roamRAC:(id)roamRAC imgInfo:(RoamImgInfo *)imgInfo{
    NSString * bat_level=imgInfo.bat_level;
    NSString * level_container=@"01234";
    if ([level_container containsString:bat_level]) {
        _power.image=[UIImage imageNamed:[NSString stringWithFormat:@"battery_%@",bat_level]];
    }else{
        _power.image=[UIImage imageNamed:@"battery_0"];
    }
    [self performSelector:@selector(getImgInfo) withObject:nil afterDelay:5];
}
-(void)roamRAC:(id)roamRAC wlanInfo:(RoamWlanInfo *)wlanInfo{
    NSString * wlan_state=wlanInfo.wifi_state;
    NSString * wlan_container=@"012345";
    if ([wlan_container containsString:wlan_state]) {
        _cellular.image=[UIImage imageNamed:[NSString stringWithFormat:@"cellular_%@",wlan_state]];
    }else{
        _cellular.image=[UIImage imageNamed:@"cellular_0"];
    }
    [self performSelector:@selector(getWlanInfo) withObject:nil afterDelay:5];
}
-(void)roamRAC:(id)roamRAC httpError:(NSString *)httpError{
    if ([httpError hasPrefix:@"getImgInfo"]) {//获取电量失败
        //将电量置为0电量
        _power.image=[UIImage imageNamed:@"battery_0"];
        [self performSelector:@selector(getImgInfo) withObject:nil afterDelay:5];
    }else if([httpError hasPrefix:@"getWlanInfo"]){//获取Wifi信号失败
        _cellular.image=[UIImage imageNamed:@"cellular_0"];
        [self performSelector:@selector(getWlanInfo) withObject:nil afterDelay:5];
    }
}
-(void)getUsedFlow{
    [RoamUdpBusi getUsedFlow:self];
}
-(void)getImgInfo{
    [RoamHttpBusi getImgInfo:self];
}
-(void)getWlanInfo{
    [RoamHttpBusi getWlanInfo:self];
}
-(void)startRunLoopReqSpeedAndPower{
    [self getUsedFlow];
    [self getImgInfo];
    [self getWlanInfo];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController * send= segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"matchPhoneSegue"]) {
        if ([send respondsToSelector:@selector(setServBindPhone:)]) {
            [send setValue:sender forKey:@"servBindPhone"];
        }
    }else if([segue.identifier isEqualToString:@"registerSuccessSegue"]){
        if ([send respondsToSelector:@selector(setRegisterPhone:)]) {
            [send setValue:sender forKey:@"registerPhone"];
        }

    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
