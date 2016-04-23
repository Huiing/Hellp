//
//  JYBWarningViewController.m
//  JianYunBao
//
//  Created by 宋亚伟 on 16/2/24.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBWarningViewController.h"
#import "SYWCommonRequest.h"

@interface JYBWarningViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *web;
@property (nonatomic,strong)UISegmentedControl *segCtrol;
@end

@implementation JYBWarningViewController
- (UISegmentedControl *)segCtrol {
    if (_segCtrol == nil) {
        _segCtrol = [[UISegmentedControl alloc] initWithItems:@[@"主责预警",@"相关预警"]];
        _segCtrol.frame = CGRectMake(SCR_WIDTH/3+30, 0, SCR_WIDTH*2/3-60, 30);
        //        _segCtrol.backgroundColor = [UIColor hexFloatColor:@"9b0000"];
        _segCtrol.backgroundColor = [UIColor colorWithRed:67/255.0 green:151/255.0 blue:230/255.0 alpha:1];
        _segCtrol.layer.cornerRadius = 3;
        _segCtrol.layer.masksToBounds = YES;
        _segCtrol.layer.borderWidth = 0.5;
        _segCtrol.layer.borderColor = [UIColor whiteColor].CGColor;
        _segCtrol.tintColor = [UIColor whiteColor];
        [_segCtrol addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _segCtrol;
}

- (void)segmentClick:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex) {
        [self loadMainResponsibility];
    }else {
        [self loadAboutResponsibility];
    }
}
//主责预警 type:2
- (void)loadMainResponsibility{
    NSString * mainRspStr = [[NSString stringWithFormat:@"%@EWManager/MsgList.aspx?employeeid=%@&type=%@",JYB_erpRootUrl,JYB_userId,@"2"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * mainRspUrl = [NSURL URLWithString:mainRspStr];
    [self.web loadRequest:[NSURLRequest requestWithURL:mainRspUrl]];
}

//相关预警 type:1
- (void)loadAboutResponsibility{
    NSString * aboutRspStr = [[NSString stringWithFormat:@"%@EWManager/MsgList.aspx?employeeid=%@&type=%@",JYB_erpRootUrl,JYB_userId,@"1"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * aboutRspUrl = [NSURL URLWithString:aboutRspStr];
    [self.web loadRequest:[NSURLRequest requestWithURL:aboutRspUrl]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = self.segCtrol;
    self.segCtrol.selectedSegmentIndex = 0;
    
    [self loadMainResponsibility];
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
