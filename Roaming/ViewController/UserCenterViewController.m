//
//  UserCenterViewController.m
//  Roaming
//
//  Created by chendd on 15/9/1.
//  Copyright (c) 2015年 icfcc. All rights reserved.
//

#import "UserCenterViewController.h"
#import "AppDefines.h"
#import "RoamRAC.h"
#import "RoamUdpBusi.h"
#import "DDString.h"
#import <MBProgressHUD.h>
#import "DDFile.h"
#import "DDNetWorkUtils.h"

@interface UserCenterViewController()<UITableViewDataSource,UITableViewDelegate,RoamRACDelegate>
@property (weak, nonatomic) IBOutlet UITableView *function;
@property (nonatomic, strong) NSArray * functionArray;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *deviceno;
@property (nonatomic, strong) NSArray * imageArray;

@end
@implementation UserCenterViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    _functionArray=[NSArray arrayWithObjects:@"设置",@"版本信息",@"关于我们",@"提交报告",nil];
    _imageArray=[NSArray arrayWithObjects:@"setting",@"version",@"about_me",@"report", nil];
    _function.tableFooterView = [[UIView alloc] init];
    _function.separatorStyle=UITableViewCellSeparatorStyleNone;
    _username.text=[[NSUserDefaults standardUserDefaults] objectForKey:KEY_BINDPHONENUMBER];
    _deviceno.text=@" ";
    SHOWHUD(@"请稍后");
    [RoamUdpBusi getMifiMac:self];
    
}
- (IBAction)backClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark RoamRACDelegate
-(void)roamRAC:(id)roamRAC MifiMac:(NSString *)MifiMac{
    HIDEHUD;
    _deviceno.text=[DDString stringFromHexString:MifiMac];
}
#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _functionArray.count;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier=@"usercenterCell";
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor=TBV_BKCOLOR;
        cell.textLabel.textColor=APP_BKCOLOR;
        cell.textLabel.font=[UIFont boldSystemFontOfSize:16];
        UIImage * right_arrow=[UIImage imageNamed:@"right_arrow"];
        UIImageView * right=[[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - 50,\
                                                                        12, 18, 20)];
        right.image=right_arrow;
        [cell.contentView addSubview:right];
    }
    cell.textLabel.text=[_functionArray objectAtIndex:indexPath.section];
    cell.imageView.image=[UIImage imageNamed:[_imageArray objectAtIndex:indexPath.section ]];
    
    return cell;
    
}

#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0://设置
            [self performSegueWithIdentifier:@"settingSegue" sender:tableView];
            break;
        case 1://版本信息
            [self performSegueWithIdentifier:@"versionInfoSegue" sender:tableView];
            break;
        case 2://关于我们
            [self performSegueWithIdentifier:@"aboutMeSegue" sender:tableView];
            break;
        case 3:
            [self sendLogs];
            break;
        default:
            break;
    }
}
-(void)sendLogs{
    SHOWHUD(@"请稍后");
    NSString * version=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSString * subject=[NSString stringWithFormat:@"iOS Feedback [%@ %@]",[[NSUserDefaults standardUserDefaults] objectForKey:KEY_BINDPHONENUMBER],version];
    NSString * zipFile=nil;
    NSLog(@"日志目录：%@",kLogDirectory);
    NSArray *files = [DDFile GetFileList:kLogDirectory];
    if (files!=nil&&[files count]!=0) {
        NSLog(@"日志文件总数:%lu",(unsigned long)[files count]);
        NSLog(@"压缩目录：%@",kLogDirectory);
        zipFile=[DDFile ArchiveToZip:kLogDirectory];
    }
    //添加发送错误日志邮件对象
    if (zipFile==nil) {
        [DDNetWorkUtils sendTsmMail:self successSEL:@selector(messageSent) failSEL:@selector(messageFailed) email_host:APP_EMAILUSER  subject:subject  message:@""];
    }else{
        [DDNetWorkUtils sendTsmMail:self successSEL:@selector(messageSent) failSEL:@selector(messageFailed) email_host:APP_EMAILUSER  subject:subject  message:@"" attachfile:[[NSArray alloc]initWithObjects:zipFile, nil]];
    }
}
#pragma mark - SKPSMTPMessageDelegate
- (void)messageSent
{
    NSLog(@"%@ 发送成功",CORE_DMP_FILE);
    [DDFile RemoveFromDocumentPath:CORE_DMP_FILE];
    HIDEHUD;
}

- (void)messageFailed
{
    NSLog(@"%@ 发送失败",CORE_DMP_FILE);
    HIDEHUD;
}

@end
