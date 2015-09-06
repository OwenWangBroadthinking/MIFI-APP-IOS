//
//  SettingViewController.m
//  Roaming
//
//  Created by chendd on 15/9/1.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "SettingViewController.h"
#import "AppDefines.h"
#import "RoamRAC.h"
#import "RoamUdpBusi.h"
#import "Tool.h"
@interface SettingViewController()<UITableViewDataSource,UITableViewDelegate,RoamRACDelegate>
@property (weak, nonatomic) IBOutlet UITableView *settingFuntion;
@property (nonatomic, strong) NSArray * functionArray;
@property (nonatomic, strong) UISwitch * disbindSwich;
@end
@implementation SettingViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    _functionArray=[NSArray arrayWithObjects:@"解绑Mifi与手机", nil];
    _settingFuntion.tableFooterView = [[UIView alloc] init];
    _settingFuntion.separatorStyle=UITableViewCellSeparatorStyleNone;
    _settingFuntion.backgroundColor=[UIColor clearColor];
}
- (IBAction)backClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)bindClick:(id)sender{
//    NSLog(@"bindClick");
    SHOWHUD(@"请稍后");
    [RoamUdpBusi disbind:self phonenumber:[[NSUserDefaults standardUserDefaults] objectForKey:KEY_BINDPHONENUMBER]];
}
#pragma mark RoamRACDelegate
-(void)roamRAC:(id)roamRAC disbindReply:(NSNumber *)disbindReply{
    HIDEHUD;
    switch (disbindReply.intValue) {
        case 0:
            Toast(appD.window, @"解绑失败");
            _disbindSwich.on=!_disbindSwich.on;
            break;
        case 1:
            Toast(appD.window, @"解绑成功");
            break;
        case 2:
            [Tool showAlertWithMessage:@"未绑定"];
            _disbindSwich.on=!_disbindSwich.on;
            break;
        default:
            [Tool showAlertWithMessage:[NSString stringWithFormat:@"解绑失败，错误码[%d]",disbindReply.intValue]];
            _disbindSwich.on=!_disbindSwich.on;
            break;
    }
}
-(void)roamRAC:(id)roamRAC udpError:(NSString *)udpError{
    _disbindSwich.on=!_disbindSwich.on;
    HIDEHUD;
    Toast(appD.window, @"解绑失败，服务器无响应");
}
#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  _functionArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier=@"settingCell";
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.textLabel.textColor=APP_BKCOLOR;
        cell.textLabel.font=[UIFont boldSystemFontOfSize:16];
    }
    cell.textLabel.text=[_functionArray objectAtIndex:indexPath.row];
    if (indexPath.row==0) {
        _disbindSwich = [[UISwitch alloc] initWithFrame:CGRectMake(227, 8, 79, 27)];
        _disbindSwich.userInteractionEnabled=YES;
        _disbindSwich.onTintColor=APP_BKCOLOR;
        _disbindSwich.on=YES;
        cell.accessoryView = _disbindSwich;
        [_disbindSwich addTarget:self action:@selector(bindClick:) forControlEvents:UIControlEventValueChanged];
        
    }
    return cell;
}
#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
@end
