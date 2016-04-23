//
//  JYBScanCodeResultViewController.m
//  JianYunBao
//
//  Created by 正 on 16/3/19.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBScanCodeResultViewController.h"
#import "KZLinkLabel.h"
#import "Masonry.h"
#import "EasyAlert.h"
#import "JYBGroupMessageViewController.h"
#import "JYBScanUploadFileViewController.h"
#import "JYBAddTeamViewController.h"

@interface JYBScanCodeResultViewController ()<UIAlertViewDelegate>

@property (strong, nonatomic) KZLinkLabel * contentLab;
@property (strong, nonatomic) UITextField * groupInput;

@end

@implementation JYBScanCodeResultViewController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.groupInput resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self comfireCodeType];
}
- (void)comfireCodeType{
    switch ([self.codeType intValue]) {
        case 3002://专题讨论
        {
            [self alertCreatGroup];
        }
            break;
        case 3003://上传和讨论合集
        {
            [self alertUploadFileOrCreatGroup];
        }
            break;
            
        default://默认展示扫描内容
        {
            [self initContentLab];
        }
            break;
    }
}
//提示创建讨论组
- (void)alertCreatGroup{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"请输入专题讨论组名称" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 3002;
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    self.groupInput = [alert textFieldAtIndex:0];
    [alert show];
}
//提示上传附件或者创建讨论组
- (void)alertUploadFileOrCreatGroup{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"扫描类型" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"上传附件",@"创建讨论组", nil];
    alert.tag = 3003;
    [alert show];
}
//alert delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (alertView.tag) {
        case 3002:
        {
            if (buttonIndex == 0){
                [self backBarBtnItemClick];
            }else{
                //跳到创建群聊页面
                JYBGroupMessageViewController * groupMsg = [[JYBGroupMessageViewController alloc] init];
                groupMsg.navigationTitle = @"群聊";
                [self.navigationController pushViewController:groupMsg animated:YES];
            }
        }
            break;
        case 3003:
        {
            switch (buttonIndex) {
                case 0://上传附件
                {
                    JYBScanUploadFileViewController * uploadFileVC = [[JYBScanUploadFileViewController alloc] init];
                    uploadFileVC.navigationTitle = @"上传附件";
                    uploadFileVC.codeContent = self.codeResult;
                    uploadFileVC.codeType = self.codeType;
                    [self.navigationController pushViewController:uploadFileVC animated:YES];
                }
                    break;
                case 1://创建讨论组
                {
                    JYBAddTeamViewController * addTeam = [[JYBAddTeamViewController alloc] init];
                    addTeam.navigationTitle = @"创建专题讨论组";
                    [self.navigationController pushViewController:addTeam animated:YES];
                }
                    
                default:
                    break;
            }
        }
            
        default:
            break;
    }
}
//扫码结果展示
- (void)initContentLab{
    self.contentLab = [[KZLinkLabel alloc] init];
    self.contentLab.font = [UIFont systemFontOfSize:15];
    self.contentLab.numberOfLines = 0;
    self.contentLab.lineBreakMode = NSLineBreakByCharWrapping;
    self.contentLab.translatesAutoresizingMaskIntoConstraints = NO;
    self.contentLab.text = self.codeResult;
    self.contentLab.linkTapHandler = ^(KZLinkType linkType, NSString *string, NSRange range) {
        switch (linkType) {
            case KZLinkTypeURL:
            {
                [self openUrlLink:string];
            }
                break;
            case KZLinkTypePhoneNumber:
            {
                [self dialPhoneNumber:string];
            }
                break;
                
            default:
                break;
        }
    };
    [self.view addSubview:self.contentLab];
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(70, 5, 5, 5));
        make.center.equalTo(self.view);
    }];
    
}
//打开链接
- (void)openUrlLink:(NSString *)string{
    [EasyAlert confirm:^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
    } question:@"是否在浏览器里打开该网址？"];
}
//呼叫手机号
- (void)dialPhoneNumber:(NSString*)phoneNumber{
    static UIWebView *__phoneCallWebView;
    if (__phoneCallWebView == nil) {
        __phoneCallWebView = [[UIWebView alloc] init];
    }
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNumber]];
    [__phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
}
//返回扫描
- (void)backBarBtnItemClick{
    if(self.delegate && [self.delegate respondsToSelector:@selector(backContinue)]){
        [self.delegate backContinue];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
