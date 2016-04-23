//
//  JYBCreateGroupViewController.m
//  JianYunBao
//
//  Created by 宋亚伟 on 16/2/26.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBCreateGroupViewController.h"

@interface JYBCreateGroupViewController ()

@end

@implementation JYBCreateGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self addNavgationBarButtonWithImage:nil title:@"确定" titleColor: [UIColor whiteColor] addTarget:self action:@selector(down) direction:JYBNavigationBarButtonDirectionRight];
}

- (void)down{
    
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
