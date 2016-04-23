//
//  JYBSafeOrderController.m
//  JianYunBao
//
//  Created by 宋亚伟 on 16/2/24.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBSafeOrderController.h"
#import "JYBCreateSafeOrderViewController.h"

@interface JYBSafeOrderController ()

@end

@implementation JYBSafeOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavgationBarButtonWithImage:@"创建添加" addTarget:self action:@selector(addItem) direction:JYBNavigationBarButtonDirectionRight];
}

- (void)addItem{
    
    DLog(@"宋亚伟");
    JYBCreateSafeOrderViewController *ctr = [[JYBCreateSafeOrderViewController alloc] init];
    ctr.navigationTitle = @"创建安全检查单";
    [self.navigationController pushViewController:ctr animated:YES];
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
