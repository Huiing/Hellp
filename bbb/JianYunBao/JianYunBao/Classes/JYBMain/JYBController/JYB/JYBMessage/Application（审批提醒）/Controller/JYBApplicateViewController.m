//
//  JYBApplicateViewController.m
//  JianYunBao
//
//  Created by 宋亚伟 on 16/2/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBApplicateViewController.h"
#import "JYBApplicateView.h"
#import "JYBSelectFriendViewController.h"
#import "DatePickerHeadView.h"
#import "DatePickerView.h"
#import "JYBFriendItem.h"

@interface JYBApplicateViewController ()<JYBApplicateViewDelegate>{
    NSString * senderId;
    NSString * insName;
    NSString * sendTime;
    NSString * taskName;
    
    NSString * senderName;
    JYBApplicateView * v;
    DatePickerHeadView *headView;
    DatePickerView *pickerView;
}
@property (weak, nonatomic) IBOutlet UIWebView *web;

@end

@implementation JYBApplicateViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SelctedFriendNotifiaction:) name:@"SelctedFriendNotifiaction" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavgationBarButtonWithImage:@"搜索查询" addTarget:self action:@selector(addItem) direction:JYBNavigationBarButtonDirectionRight];
    
    senderId = @"";
    insName = @"";
    sendTime = @"";
    taskName = @"";
    [self loadApplicate];
    
    //日期选择
    pickerView = [[DatePickerView alloc] initWithFrame:CGRectMake(0, Mheight - 250, Mwidth, 250)];
    headView = pickerView.headView;
    [headView addTarget:self confirmAction:@selector(confirm:)];
    [headView addTarget:self cancelAction:@selector(cancle:)];
    [self.view addSubview:pickerView];
    pickerView.hidden = YES;
}

//审批提醒
- (void)loadApplicate{
    NSString * applicateStr = [[NSString stringWithFormat:@"%@phone/phonemyworkflowlist.aspx?employeeid=%@&insName=%@&sendEmployeeid=%@&sendTime=%@&taskName=%@",JYB_erpRootUrl,JYB_userId,insName,senderId,sendTime,taskName] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * applicateUrl = [NSURL URLWithString:applicateStr];
    [self.web loadRequest:[NSURLRequest requestWithURL:applicateUrl]];
}
- (void)addItem{
    if(v == nil){
        v = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JYBApplicateView class]) owner:self options:nil] objectAtIndex:0];
        v.frame = CGRectMake(SCR_WIDTH - v.frame.size.width - 5, 70, v.frame.size.width, v.frame.size.height);
        v.delegate = self;
        [self.view addSubview:v];
    }
    [v setHidden:NO];
}

//选人
- (void)applicateViewSenderHandle{
    JYBSelectFriendViewController * senderVC = [[JYBSelectFriendViewController alloc] init];
    senderVC.title = @"发起人";
    [self.navigationController pushViewController:senderVC animated:YES];
}
- (void)SelctedFriendNotifiaction:(NSNotification *)notification{
    JYBFriendItem * item = (JYBFriendItem *)notification.object;
    senderId = item.friendId;
    senderName = item.userName;
    [v setSenderWithUserName:senderName];
}
//选时间
- (void)applicateViewSendTimeHandle{
    [self showDatePick];
}
- (void)confirm:(UIButton *)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-CN"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
    sendTime = pickerView.resultStr;
    if (sendTime == nil) {
        sendTime = dateStr;
    }
    pickerView.hidden = YES;
    [v setTimeWithDate:sendTime];
}
- (void)cancle:(UIButton *)sender {
    pickerView.hidden = YES;
}
// 显示DatePick
- (void)showDatePick {
    pickerView.hidden = NO;
    [pickerView bringSubviewToFront:pickerView.headView];
    [pickerView bringSubviewToFront:pickerView.datePickerView];
    [self.view bringSubviewToFront:pickerView];
}

//搜索
- (void)applicateViewSearchHandle{
    [v setHidden:YES];
    [pickerView setHidden:YES];
    insName = [v gProcessName];
    taskName = [v gTaskName];
    [self loadApplicate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
