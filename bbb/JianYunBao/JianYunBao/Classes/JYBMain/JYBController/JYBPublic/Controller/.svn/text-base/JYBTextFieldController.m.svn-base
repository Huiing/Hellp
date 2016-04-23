//
//  JYBTextFieldController.m
//  JianYunBao
//
//  Created by 冰点 on 16/1/28.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBTextFieldController.h"
#import "JYBTextField.h"
#import "RegularJudge.h"


@interface JYBTextFieldController ()
@property (weak, nonatomic) IBOutlet JYBTextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *warmTextField;
@end

@implementation JYBTextFieldController
@synthesize placeholder;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNavgationBarButtonWithImage:nil title:@"确定" titleColor:[UIColor whiteColor] addTarget:self action:@selector(updata) direction:JYBNavigationBarButtonDirectionRight];
    self.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
    _textField.textField.text = self.content;
    _warmTextField.text = self.warm;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
//MARK: Init

//MARK: setter & getter
- (void)setTextField:(JYBTextField *)textField
{
    _textField = textField;
    textField.placeholder = placeholder;
}

//MARK: loadData

//MARK: Action

//MARK: delegate

//MARK: Other
#pragma mark - 确定方法

- (void)updata{
    [self.view endEditing:YES];
    if (_indexPath.row == 1) {
        if (![RegularJudge validateEmail:self.textField.textField.text]) {
            [self showHint:@"请输入正确的邮箱"];
            return;
        }
        
    }else if (_indexPath.row == 2){
        if (![RegularJudge validateMobile:self.textField.textField.text]) {
            [self showHint:@"请输入正确的手机号"];
            return;
        }
    }
    if ([self.delegate respondsToSelector:@selector(updataContent:)]) {
        [self backBarBtnItemClick];
        [self.delegate updataContent:self.textField.textField.text];
    }
}

@end
