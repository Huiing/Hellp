//
//  JYBAppSettingViewController.m
//  JianYunBao
//
//  Created by 冰点 on 16/1/28.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBAppSettingViewController.h"
#import "JYBFeedBackViewController.h"
#import "JYBAppSettingCell.h"
#import "AppDelegate.h"
#import "JYBDataSynchronizationVC.h"
@interface JYBAppSettingViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *dataSource;
    NSArray *appSettingEntitys;
    UIView *view;
}

@property (weak, nonatomic) IBOutlet BDBaseTableView *table;


@end

@implementation JYBAppSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataSource = @[
                   @{@"item":@0, @"list":@[@"声音", @"震动"]},
                   @{@"item":@1, @"list":@[@"数据同步"]},
                   @{@"item":@2, @"list":@[@"反馈意见"]},
                   @{@"item":@3, @"list":@[@"关于建云宝"]},
                   @{@"item":@4, @"list":@[@"退出登录"]},
  ];
    
    appSettingEntitys = [JYBAppSettingEntity mj_objectArrayWithKeyValuesArray:dataSource];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
//MARK: Init

//MARK: setter & getter

//MARK: loadData

//MARK: Action

//MARK: UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [appSettingEntitys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [[appSettingEntitys[section] list] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    JYBAppSettingCell *cell = [JYBAppSettingCell cellWithTableView:tableView indexPath:indexPath];
    [cell setAppSettingTitle:[[appSettingEntitys[indexPath.section] list] objectAtIndex:indexPath.row]];
    return cell;
}

//MARK: UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1)
    {
        [self loadViewOfDataSynchronization];
    }
    else if (indexPath.section == 2) {
        JYBFeedBackViewController *ctr = [[JYBFeedBackViewController alloc] init];
        ctr.navigationTitle = @"设置";
        [self.navigationController pushViewController:ctr animated:YES];
    }else if (indexPath.section == 4) {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"JYBNotificationUserLogout" object:nil];  
        [[AppDelegate thisAppDelegate] setupLoginController];
    }
    
}

- (void)loadViewOfDataSynchronization
{
    view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, Mwidth, Mheight);
    view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    UIView *smallView = [[UIView alloc] init];
    smallView.clipsToBounds = YES;
    smallView.layer.cornerRadius = 7;
//    smallView.layer.borderColor = RGB(240, 240, 240).CGColor;
//    smallView.layer.borderWidth = 1;
    smallView.center = view.center;
    smallView.bounds = CGRectMake(0, 0, 300, 300);
    UILabel *label = [UILabel new];
    float height = smallView.bounds.size.height/8;
    label.frame = CGRectMake(0, 0, smallView.bounds.size.width, height);
    label.text = @" 选择数据同步类别";
    label.layer.borderColor = RGB(240, 240, 240).CGColor;
    label.layer.borderWidth = 1;
    label.font = [UIFont systemFontOfSize:15];
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = [UIColor blackColor];
    [smallView addSubview:label];
    NSArray *array = @[@" 工单",@" 质量检查单",@" 安全检查单",@" 群组（专题谈论组）",@" 通知公告",@" 签到"];
    for (int i=0; i<7; i++)
    {
        if (i<6)
        {
            UILabel *label = [UILabel new];
            label.frame = CGRectMake(0, (i+1)*(height),smallView.bounds.size.width, height);
            label.textColor =[UIColor grayColor];
            label.text = array[i];
            label.layer.borderWidth = 1;
            label.layer.borderColor = RGB(240, 240, 240).CGColor;
            label.font = [UIFont systemFontOfSize:15];
            [smallView addSubview:label];
        }
       
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, (i+1)*height, smallView.bounds.size.width, height);
        if (i>=6)
        {
            [btn setTitle:@"取消" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        btn.tag = i;
        btn.layer.borderColor = RGB(240, 240, 240).CGColor;
        btn.layer.borderWidth = 1;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [smallView addSubview:btn];
        [smallView sendSubviewToBack:btn];
    }
    [view addSubview:smallView];
    [self.view addSubview:view];
}

- (void)btnClick:(UIButton *)sender
{
    switch (sender.tag)
    {
        case 0:
        {
            [self dismissView];
            JYBDataSynchronizationVC *vc = [[JYBDataSynchronizationVC alloc] init];
            vc.senderTag = sender.tag;
            vc.navigationTitle = @"工单";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            [self dismissView];
            JYBDataSynchronizationVC *vc = [[JYBDataSynchronizationVC alloc] init];
            vc.navigationTitle = @"质量检查单";
            vc.senderTag = sender.tag;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            [self dismissView];
            JYBDataSynchronizationVC *vc = [[JYBDataSynchronizationVC alloc] init];
            vc.navigationTitle = @"安全检查单";
            vc.senderTag = sender.tag;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            [self dismissView];
            JYBDataSynchronizationVC *vc = [[JYBDataSynchronizationVC alloc] init];
            vc.navigationTitle = @"群组(专题谈论组)";
            vc.senderTag = sender.tag;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            [self dismissView];
            JYBDataSynchronizationVC *vc = [[JYBDataSynchronizationVC alloc] init];
            vc.navigationTitle = @"通知公告";
            vc.senderTag = sender.tag;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:
        {
            [self dismissView];
            JYBDataSynchronizationVC *vc = [[JYBDataSynchronizationVC alloc] init];
            vc.navigationTitle = @"签到";
            vc.senderTag = sender.tag;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 6:
        {
            [self dismissView];
        }
            break;
            
        default:
            break;
    }
}
- (void)dismissView
{
    [view removeFromSuperview];
}
//MARK: Other

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissView];
}

@end

@implementation JYBAppSettingEntity


@end