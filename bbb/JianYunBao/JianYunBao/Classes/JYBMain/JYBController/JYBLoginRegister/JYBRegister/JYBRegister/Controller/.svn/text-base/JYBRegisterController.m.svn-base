//
//  JYBRegisterController.m
//  JianYunBao
//
//  Created by 宋亚伟 on 16/2/23.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBRegisterController.h"
#import "SYWCommonRequest.h"

@interface JYBRegisterController ()
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *line2;
@property (weak, nonatomic) IBOutlet UIView *line3;
@property (weak, nonatomic) IBOutlet UIView *line4;
@property (weak, nonatomic) IBOutlet UIView *line5;
@property (weak, nonatomic) IBOutlet UITextField *enterpriseCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *checkNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *checkBtnWidth;
@property (nonatomic, weak) NSTimer *countDownTimer;

@end

@implementation JYBRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationTitle = @"注册";
    self.view.backgroundColor = [UIColor whiteColor];
    self.line1.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];
    self.line2.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];
    self.line3.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];
    self.line4.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];
    self.line5.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];
}

- (void)setCheckBtn:(UIButton *)checkBtn{
    _checkBtn = checkBtn;
    [checkBtn setTitleColor:[UIColor hexFloatColor:@"299be8"] forState:UIControlStateDisabled];
    checkBtn.layer.cornerRadius = 5;
    checkBtn.layer.masksToBounds = YES;
    checkBtn.layer.borderWidth = 1;
    checkBtn.layer.borderColor = [UIColor hexFloatColor:@"299be8"].CGColor;
}


- (void)setRegisterBtn:(UIButton *)registerBtn{
    _registerBtn = registerBtn;
    registerBtn.backgroundColor = [UIColor hexFloatColor:@"299be8"];
}

- (void)setBackView:(UIView *)backView{
    _backView = backView;
    backView.layer.borderWidth = 1;
    backView.layer.borderColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1].CGColor;
}

- (IBAction)getCheckNum:(id)sender {
    [self.view endEditing:YES];
    if ([self checkGetCheckNum]) {
        self.checkBtnWidth.constant = 30;
        self.checkBtn.enabled = NO;
        [self timerDown];
        [self getCheckNumReq];
    }
}

static int seconds = 60;
- (void)timerDown{
    [self.checkBtn setTitle:[NSString stringWithFormat:@"%d“",seconds] forState:UIControlStateDisabled];
    NSTimer *countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerDownMethod) userInfo:nil repeats:YES];
    self.countDownTimer = countDownTimer;
}

- (void)timerDownMethod{
    
    seconds -- ;
    
    if (seconds == 0) {
        seconds = 60;
        self.checkBtnWidth.constant = 75;
        self.checkBtn.enabled = YES;
        [self.checkBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.countDownTimer invalidate];
    }else{
        [self.checkBtn setTitle:[NSString stringWithFormat:@"%d“",seconds] forState:UIControlStateDisabled];
    }
    
}

- (IBAction)registerClick:(id)sender {
    [self.view endEditing:YES];
    if ([self check]) {
        [self registerReq];
    }
}

- (BOOL)checkGetCheckNum{

    if(self.enterpriseCodeTextField.text == nil || [self.enterpriseCodeTextField.text isEqualToString:@""]) {
        [self showHint:@"企业号不能为空"];
        return NO;
    }else if (self.phoneNumTextField.text == nil || [self.phoneNumTextField.text isEqualToString:@""]){
        [self showHint:@"手机号不能为空"];
        return NO;
    }
    return YES;
}

- (BOOL)check{
    if(self.enterpriseCodeTextField.text == nil || [self.enterpriseCodeTextField.text isEqualToString:@""]) {
        [self showHint:@"企业号不能为空"];
        return NO;
    }else if(self.nameTextField.text == nil || [self.nameTextField.text isEqualToString:@""]){
        [self showHint:@"姓名不能为空"];
        return NO;
    }else if(![self checkGetCheckNum]){
        return NO;
    }else if(self.checkNumTextField.text == nil || [self.checkNumTextField.text isEqualToString:@""]){
        [self showHint:@"验证码不能为空"];
        return NO;
    }else if(self.passwordTextField.text == nil || [self.passwordTextField.text isEqualToString:@""]){
        [self showHint:@"密码不能为空"];
        return NO;
    }
    
    return YES;
}

- (void)getCheckNumReq{
    
    SYWCommonRequest *api = [[SYWCommonRequest alloc] init];
    api.ReqURL = @"http://www.yuntech.com.cn/yuntech/DataService/JianyunBao.aspx?";
    api.ReqDictionary =
    @{
      @"method":@"sendcode",
      @"phoneCode":self.phoneNumTextField.text,
      @"enterpriseCode":self.enterpriseCodeTextField.text};
    //    __weak typeof(self) weakSelf = self;
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        DLogJSON(request.responseJSONObject);
        if (GoodResponse) {
            
        }else{
            [self showHint:BadResponseMessage];
        }
        
    } failure:^(YTKBaseRequest *request) {
    }];
}

- (void)registerReq{
    
    SYWCommonRequest *api = [[SYWCommonRequest alloc] init];
    api.ReqURL = [NSString stringWithFormat:@"%@/JianyunBao.aspx?",JYB_erpHttpUrl];
    api.ReqDictionary =
    @{
      @"method":@"Regist",
      @"phoneCode":self.phoneNumTextField.text,
      @"smCode":self.checkNumTextField.text,
      @"password":self.passwordTextField.text,
      @"name":self.nameTextField.text,
      @"unit":self.companyNameTextField.text,
      @"enterpriseCode":self.enterpriseCodeTextField.text};
    //    __weak typeof(self) weakSelf = self;
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        DLogJSON(request.responseJSONObject);
        if (GoodResponse) {
            [self showHint:@"注册已受理，管理员审核通过后方可登录" afterDelay:5];
            [self backBarBtnItemClick];
        }else{
            [self showHint:BadResponseMessage];
        }
        
    } failure:^(YTKBaseRequest *request) {
    }];
}


@end
