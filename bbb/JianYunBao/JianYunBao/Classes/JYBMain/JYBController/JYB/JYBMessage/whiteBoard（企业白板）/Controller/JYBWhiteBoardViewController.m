//
//  JYBWhiteBoardViewController.m
//  JianYunBao
//
//  Created by 宋亚伟 on 16/2/24.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBWhiteBoardViewController.h"

@interface JYBWhiteBoardViewController ()

@end

@implementation JYBWhiteBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
//MARK: Init
- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

//MARK: setter & getter

//MARK: loadData

//MARK: Action

- (void)tableViewDidTriggerHeaderRefresh
{
    [super tableViewDidTriggerHeaderRefresh];
}

//MARK: delegate

//MARK: Other


@end
