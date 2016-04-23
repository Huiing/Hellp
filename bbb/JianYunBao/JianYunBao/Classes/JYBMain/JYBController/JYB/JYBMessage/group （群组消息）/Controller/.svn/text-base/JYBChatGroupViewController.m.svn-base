//
//  JYBChatGroupViewController.h
//  JianYunBao
//
//  Created by 宋亚伟 on 16/2/24.
//  Copyright © 2016年 冰点. All rights reserved.
//


#import "JYBChatGroupViewController.h"
#import "JYBChatSettingViewController.h"

@interface JYBChatGroupViewController ()

@end

@implementation JYBChatGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavgationBarButtonWithImage:@"icon_group_setting" addTarget:self action:@selector(goGroupDetail) direction:JYBNavigationBarButtonDirectionRight];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goGroupDetail
{
    JYBChatSettingViewController * setting = [[JYBChatSettingViewController alloc] init];
    setting.navigationTitle = @"聊天设置";
    setting.groupModel = self.groupModel;
    [self.navigationController pushViewController:setting animated:YES];
}

@end
