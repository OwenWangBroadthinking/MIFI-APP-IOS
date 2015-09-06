//
//  ViewController.m
//  Roaming
//
//  Created by chendd on 15/8/24.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "InterfaceViewController.h"
#import "AppDefines.h"
#import "RoamHttpBusi.h"
#import <SIAlertView.h>
#import "RoamUdpBusi.h"
#import "RoamUdpPackage.h"
#import "DDUdpClient.h"
#import "DDString.h"
#import "RoamRAC.h"
#import "Tool.h"
@interface InterfaceViewController ()<UITableViewDataSource,UITableViewDelegate,RoamRACDelegate>
@property (weak, nonatomic) IBOutlet UITableView *interfaceList;
@property (nonatomic, copy) NSArray * interfaceArray;
@property (nonatomic, copy) NSArray * commandArray;
@end

@implementation InterfaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //并增加超时处理
    self.title=@"接口测试";
    _interfaceArray=[NSArray arrayWithObjects:
                     @"读取OTA",
                     @"发送反馈",
                     @"注册",
                     @"获取Wlan信息(HTTP)",
                     @"获取Wan信息(HTTP)",
                     @"获取固件信息(HTTP)",
                     @"获取SIM卡信息(HTTP)",
                     @"获取登陆状态(HTTP)",
                     @"获取MIFI当前语言(HTTP)",
                     @"登陆(HTTP)",
                     @"获取DeviceSlot模式(HTTP)",
                     @"获取Profile列表(HTTP)",
                     @"获取当前Profile(HTTP)",
                     @"设置Wlan信息(HTTP)",
                     @"注销(HTTP)",
                     @"获取路由信息(HTTP)",
                     @"设置路由信息(HTTP)",
                     @"获取系统信息(HTTP)",
                     @"设置后台用户名密码(HTTP)",
                     @"获取短信存储状态(HTTP)",
                     @"获取SMS Page信息(HTTP)",
                     @"获取SMS列表(HTTP)",
                     @"获取网络信息(HTTP)",
                     @"获取MAC过滤列表(HTTP)",
                     @"设置MAC过滤列表(HTTP)",
                     @"查询绑定状态(UDP)",
                     @"绑定(UDP)",
                     @"解绑(UDP)",
                     @"激活(UDP)",
                     @"获取Mac地址(UDP)",
                     @"获取Mifi程序版本(UDP)",
                     @"获取当天已用流量(UDP)",
                     nil];
    _commandArray=[NSArray arrayWithObjects:
                   @"readOTA",
                   @"sendFeedBack",
                   @"registerUser",
                   @"getWlanInfo",
                   @"getWanInfo",
                   @"getImgInfo",
                   @"getSimInfo",
                   @"getLoginState",
                   @"getLocale",
                   @"login",
                   @"getDeviceSlotMode",
                   @"getProfileList",
                   @"getCurrentProfile",
                   @"setWlanInfo",
                   @"logout",
                   @"getRouterInfo",
                   @"setRouterInfo",
                   @"getSystemInfo",
                   @"setUsernameAndPW",
                   @"getSMSStoreState",
                   @"getSMSPageInfo",
                   @"getSMSList",
                   @"getNetworkInfo",
                   @"getMACFilterInfo",
                   @"setMACFilterInfo",
                   @"getBindState",
                   @"bind",
                   @"disbind",
                   @"activate",
                   @"getMac",
                   @"getMifiVersion",
                   @"getUsedFlow",
                   nil];
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _interfaceArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier=@"interfaceCell";
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier ];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.font=[UIFont systemFontOfSize:16];
    cell.textLabel.text=[_interfaceArray objectAtIndex:indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 25.0f;
}
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSString * command=[_commandArray objectAtIndex:indexPath.row];
    if (![self respondsToSelector:NSSelectorFromString(command)]) {
        [Tool showAlertWithMessage:[NSString stringWithFormat:@"方法%@尚未实现",command]];
    }else{
        RoamPerformSelectorLeakWarning(
        [self performSelector:NSSelectorFromString(command) withObject:nil];
                                       );
    }
}
- (void)readOTA {
    [RoamHttpBusi getOTA:self];
}

- (void)sendFeedBack{
    [RoamHttpBusi sendFeedBack:self feedback:@"测试一下吧"];
    
}
-(void)registerUser{
    [RoamHttpBusi register:self username:@"18210053056" password:@"123456"];
}
-(void)getBindState{
    [RoamUdpBusi getBindState:self];
}
-(void)bind{
    [RoamUdpBusi bind:self phonenumber:@"18210053055"];
}
-(void)disbind{
    [RoamUdpBusi disbind:self phonenumber:@"18210053055"];
}
-(void)activate{
    [RoamUdpBusi activate:self phonenumber:@"18210053055"];
}
- (void)getMac {
    [RoamUdpBusi getMifiMac:self];
}
-(void)getMifiVersion{
    [RoamUdpBusi getMifiVersion:self];
}
-(void)getUsedFlow{
    [RoamUdpBusi getUsedFlow:self];
}

-(void)getWlanInfo{
    [RoamHttpBusi getWlanInfo:self];
}
-(void)getWanInfo{
    [RoamHttpBusi getWanInfo:self];
}
-(void)getImgInfo{
    [RoamHttpBusi getImgInfo:self];
}
-(void)getSimInfo{
    [RoamHttpBusi getSimInfo:self];
}
-(void)getLoginState{
    [RoamHttpBusi getLoginState:self];
}
-(void)getLocale{
    [RoamHttpBusi getLocale:self];
}
-(void)login{
    [RoamHttpBusi login:self username:@"admin" password:@"123456"];
}
-(void)getDeviceSlotMode{
    [RoamHttpBusi getDeviceSlotMode:self];
}
-(void)getProfileList{
    [RoamHttpBusi getProfileList:self];
}
-(void)getCurrentProfile{
    [RoamHttpBusi getCurrentProfile:self];
}
-(void)setWlanInfo{
    [RoamHttpBusi setWlanInfo:self wmode:@"2" wifi_state:@"1" ssdi:@"MY+WIFI+435C" hidden_ssid:@"0" channel:@"0" max_numsta:@"10" security_mode:@"3" wep_sec:@"0" wep_key:@"1234567890" wpa_sec:@"2" wpa_passphrase:@"MYWIFI2112" ap_status:@"0" ssid_5g:@"MY+WIFI+435C_5G" wifi_country_code:@"CN" max_numsta_5g:@"10" wlan_mode:@"0" wmode_5g:@"5" channel_5g:@"0" hidden_ssid_5g:@"0"];
}
-(void)logout{
    [RoamHttpBusi logout:self];
}
-(void)getRouterInfo{
    [RoamHttpBusi getRouterInfo:self];
}
-(void)setRouterInfo{
    [RoamHttpBusi setRouterInfo:self host_name:@"ee.mobilebroadband" a5_ip_addr:@"192.168.1.1" sub_net_mask:@"255.255.255.0" enable_dhcp:@"1" dhcp_start_addr:@"192.168.1.100" dhcp_end_addr:@"192.168.1.200" dhcp_release_time:@"12h"];
}
-(void)getSystemInfo{
    [RoamHttpBusi getSystemInfo:self];
}
-(void)setUsernameAndPW{
    [RoamHttpBusi setLogin:self username:@"admin" password:@"123456"];
}
-(void)getSMSStoreState{
    [RoamHttpBusi getSMSStoreState:self];
}
-(void)getSMSPageInfo{
    [RoamHttpBusi getSMSPageInfo:self];
}
-(void)getSMSList{
    [RoamHttpBusi getSMSList:self pageNum:@"0"];
}
-(void)getNetworkInfo{
    [RoamHttpBusi getNetworkInfo:self];
}
-(void)getMACFilterInfo{
    [RoamHttpBusi getMacFilterInfo:self];
}
-(void)setMACFilterInfo{
    [RoamHttpBusi setMacFilterInfo:self filter_policy:@"1" address0:@"00:1D:0F:10:2D:D9" mac_address_num:@"1"];
}

#pragma mark RoamRACDelegate
-(void)roamRAC:(id)roamRAC OTAInfo:(NSDictionary *)OTAInfo{
    [Tool showAlertWithMessage:[OTAInfo objectForKey:@"msg"]];
}
-(void)roamRAC:(id)roamRAC wlanInfo:(RoamWlanInfo *)wlanInfo{
    [Tool showAlertWithMessage:[NSString stringWithFormat:@"wifi_state=%@",wlanInfo.wifi_state ]];
}
-(void)roamRAC:(id)roamRAC wanInfo:(RoamWanInfo *)wanInfo{
    [Tool showAlertWithMessage:[NSString stringWithFormat:@"wan_ip=%@",wanInfo.wan_ip]];
}
-(void)roamRAC:(id)roamRAC imgInfo:(RoamImgInfo *)imgInfo{
    [Tool showAlertWithMessage:[NSString stringWithFormat:@"chg_state=%@",imgInfo.chg_state]];
}
-(void)roamRAC:(id)roamRAC simInfo:(RoamSimInfo *)simInfo{
    [Tool showAlertWithMessage:[NSString stringWithFormat:@"sim_state=%@",simInfo.sim_state]];
}
-(void)roamRAC:(id)roamRAC loginState:(RoamLoginState *)loginState{
    [Tool showAlertWithMessage:[NSString stringWithFormat:@"loginStatus=%@",loginState.loginStatus]];
}
-(void)roamRAC:(id)roamRAC locale:(RoamLocale *)locale{
    [Tool showAlertWithMessage:[NSString stringWithFormat:@"language=%@",locale.language]];
}
-(void)roamRAC:(id)roamRAC loginReply:(RoamLoginReply *)loginReply{
    [Tool showAlertWithMessage:[NSString stringWithFormat:@"login_result=%@",loginReply.login_result]];
}
-(void)roamRAC:(id)roamRAC deviceSlotMode:(RoamDeviceSlotMode *)deviceSlotMode{
    [Tool showAlertWithMessage:[NSString stringWithFormat:@"device_slot_mode=%@",deviceSlotMode.device_slot_mode]];
}
-(void)roamRAC:(id)roamRAC profileList:(RoamProfileList *)profileList{
    NSMutableString * profiles=[[NSMutableString alloc]init];
    for (RoamProfile * profile in profileList.data) {
        [profiles appendString:profile.profile_name];
        [profiles appendString:@"\n"];
    }
    [Tool showAlertWithMessage:profiles];
}
-(void)roamRAC:(id)roamRAC currentProfile:(RoamCurrentProfile *)currentProfile{
    [Tool showAlertWithMessage:[NSString stringWithFormat:@"profile_id=%@",currentProfile.profile_id]];
}
-(void)roamRAC:(id)roamRAC setWlanInfoState:(NSNumber *)setWlanInfoState{
    [Tool showAlertWithMessage:[NSString stringWithFormat:@"error=%u",[setWlanInfoState intValue]]];
}
-(void)roamRAC:(id)roamRAC logoutState:(NSNumber *)logoutState{
    [Tool showAlertWithMessage:[NSString stringWithFormat:@"error=%u",[logoutState intValue]]];
}
-(void)roamRAC:(id)roamRAC routerInfo:(RoamRouterInfo *)routerInfo{
    [Tool showAlertWithMessage:[NSString stringWithFormat:@"hostname=%@",routerInfo.host_name]];
}
-(void)roamRAC:(id)roamRAC setRouterInfoState:(NSNumber *)setRouterInfoState{
    [Tool showAlertWithMessage:[NSString stringWithFormat:@"error=%u",setRouterInfoState.intValue]];
    
}
-(void)roamRAC:(id)roamRAC systemInfo:(RoamSystemInfo *)systemInfo{
    [Tool showAlertWithMessage:[NSString stringWithFormat:@"dev_mac=%@",systemInfo.dev_mac]];
}
-(void)roamRAC:(id)roamRAC setUsernameAndPWState:(NSNumber *)setUsernameAndPWState{
    [Tool showAlertWithMessage:[NSString stringWithFormat:@"error=%u",setUsernameAndPWState.intValue]];
}
-(void)roamRAC:(id)roamRAC smsStoreState:(RoamSMSStoreState *)smsStoreState{
    [Tool showAlertWithMessage:[NSString stringWithFormat:@"sms_center_num=%@",smsStoreState.sms_center_num]];
}
-(void)roamRAC:(id)roamRAC smsPageInfo:(RoamSMSPageInfo *)smsPageInfo{
    [Tool showAlertWithMessage:[NSString stringWithFormat:@"curr_sms_count=%@",smsPageInfo.curr_sms_count]];
}
-(void)roamRAC:(id)roamRAC smsList:(RoamSMSList *)smsList{
    NSMutableString * smss=[[NSMutableString alloc]init];
    for (RoamSMS * sms in smsList.data) {
        [smss appendString:sms.sms_content];
        [smss appendString:@"\n"];
    }
    [Tool showAlertWithMessage:smss];
}
-(void)roamRAC:(id)roamRAC networkInfo:(RoamNetworkInfo *)networkInfo{
    [Tool showAlertWithMessage:[NSString stringWithFormat:@"nw_mode=%@",networkInfo.nw_mode]];
}
-(void)roamRAC:(id)roamRAC macFilterInfo:(RoamMacFilterInfo *)macFilterInfo{
    [Tool showAlertWithMessage:[NSString stringWithFormat:@"mac_address_num=%@",macFilterInfo.mac_address_num]];
}
-(void)roamRAC:(id)roamRAC setMacFilterInfoState:(NSNumber *)setMacFilterInfoState{
    [Tool showAlertWithMessage:[NSString stringWithFormat:@"error=%u",setMacFilterInfoState.intValue]];
}
-(void)roamRAC:(id)roamRAC MifiMac:(NSString *)MifiMac{
    NSString * Mac=[DDString stringFromHexString:[DDString substr:MifiMac start:2]];
    [Tool showAlertWithMessage:Mac];
}
-(void)roamRAC:(id)roamRAC bindState:(RoamBindState *)bindState{
    [Tool showAlertWithMessage:[DDString stringFromHexString:bindState.bindData]];
}
-(void)roamRAC:(id)roamRAC bindReply:(RoamBindReply *)bindReply{
    [Tool showAlertWithMessage:bindReply.macAddress];
}
-(void)roamRAC:(id)roamRAC disbindReply:(NSNumber *)disbindReply{
    [Tool showAlertWithMessage:[NSString stringWithFormat:@"%u",disbindReply.intValue]];
}
-(void)roamRAC:(id)roamRAC activateReply:(RoamActivateReply *)activateReply{
    [Tool showAlertWithMessage:activateReply.activateDate];
}
-(void)roamRAC:(id)roamRAC MifiVersion:(NSString *)MifiVersion{
    [Tool showAlertWithMessage:MifiVersion];
}
-(void)roamRAC:(id)roamRAC flowReply:(RoamFlowReply *)flowReply{
    long total=0,usedflow=0;
    NSData * total_c=[DDString dataFromHexString:flowReply.totalFlow] ;
    NSData * total_cr=[DDString reverse:total_c];
    [total_cr getBytes:&total length:sizeof(total)];
    NSData * usedflow_c=[DDString dataFromHexString:flowReply.usedFlow];
    NSData * usedflow_cr=[DDString reverse:usedflow_c];
    [usedflow_cr getBytes:&usedflow length:sizeof(usedflow)];
    [Tool showAlertWithMessage:[NSString stringWithFormat:@"套餐流量[%ld],已使用流量[%ld]",total/1024/1024/1024,usedflow/1024/1024/1024]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
