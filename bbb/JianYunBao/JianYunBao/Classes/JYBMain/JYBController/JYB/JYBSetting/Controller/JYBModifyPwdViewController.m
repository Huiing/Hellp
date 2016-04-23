//
//  JYBModifyPwdViewController.m
//  JianYunBao
//
//  Created by 冰点 on 16/1/27.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBModifyPwdViewController.h"
#import "SYWCommonRequest.h"
#import "JYBTextField.h"

@interface JYBModifyPwdViewController ()
@property (weak, nonatomic) IBOutlet UITextField *oldPwd;
@property (weak, nonatomic) IBOutlet UITextField *pwd;
@property (weak, nonatomic) IBOutlet UITextField *pwd1;

@end

@implementation JYBModifyPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backgroundColor = [UIColor whiteColor];
    self.navigationTitle = @"更改密码";
    [self addNavgationBarButtonWithImage:nil title:@"确定" titleColor:JYBWhiteColor addTarget:self action:@selector(confirmButtonClick) direction:JYBNavigationBarButtonDirectionRight];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark -
//MARK: Init

//MARK: setter & getter

//MARK: loadData

//MARK: Action
- (void)confirmButtonClick
{
    [self.view endEditing:YES];
    if ([self check]) {
       [self updataReq];
    }
}

//MARK: delegate

//MARK: Other
#pragma mark - 网络请求方法
- (void)updataReq{
    
    SYWCommonRequest *api = [[SYWCommonRequest alloc] init];
    api.ReqURL = [NSString stringWithFormat:@"%@/JianyunBao.aspx?",JYB_erpHttpUrl];

    api.ReqDictionary =
        @{
          @"method":@"UpdatePassword",
          @"employeeId":JYB_userId,
          @"enterpriseCode":JYB_enterpriseCode,
          @"oldPass":self.oldPwd.text,
          @"newPass":self.pwd.text
          };

    __weak typeof(self) weakSelf = self;
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        DLogJSON(request.responseJSONObject);
        if (GoodResponse) {
            [weakSelf showHint:@"操作成功"];
            [weakSelf backBarBtnItemClick];
        }else{
            [weakSelf showHint:BadResponseMessage];
        }
        
    } failure:^(YTKBaseRequest *request) {
    }];
}

#pragma mark - 验证信息正确性

- (BOOL)check{
    if ([self.oldPwd.text isEqualToString:@""] || self.oldPwd.text == nil) {
        [self showHint:@"旧密码不能为空"];
        return NO;
    }else if ([self.pwd.text isEqualToString:@""] || self.pwd.text == nil){
        [self showHint:@"新密码不能为空"];
        return NO;
    }else if (![_pwd.text isEqualToString:_pwd1.text]){
        [self showHint:@"新密码不一致"];
        return NO;
    }
    
    return YES;
}
@end
