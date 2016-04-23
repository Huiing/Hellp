//
//  JYBWorkOrderController.m
//  JianYunBao
//
//  Created by 宋亚伟 on 16/2/24.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBWorkOrderController.h"
#import "JYBCreateWorkOrderViewController.h"

@interface JYBWorkOrderController ()

@end

@implementation JYBWorkOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavgationBarButtonWithImage:@"创建添加" addTarget:self action:@selector(addItem) direction:JYBNavigationBarButtonDirectionRight];
}

- (void)addItem{

    DLog(@"创建工单");
    JYBCreateWorkOrderViewController *ctr = [[JYBCreateWorkOrderViewController alloc] init];
    ctr.navigationTitle = @"创建工单";
    [self.navigationController pushViewController:ctr animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
