//
//  JYBFeedBackViewController.m
//  JianYunBao
//
//  Created by 宋亚伟 on 16/3/2.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBFeedBackViewController.h"
#import "SYWCommonRequest.h"
#import "JYBUserItem.h"
#import "JYBUserTool.h"
#import "JYBDevice.h"


@interface JYBFeedBackViewController (){
    UILabel *label;
}
@property (weak, nonatomic) IBOutlet UIButton *feedBackBtn;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (nonatomic, strong) JYBUserItem *user;

@end

@implementation JYBFeedBackViewController

-(JYBUserItem *)user{
    if (_user == nil) {
        _user = [JYBUserTool user];
    }
    return _user;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    label = [[UILabel alloc]initWithFrame:CGRectMake(3, 5, 200, 20)];
    label.enabled = NO;
    label.text = @"反馈意见";
    label.font =  [UIFont systemFontOfSize:15];
    label.textColor = [UIColor lightGrayColor];
    [self.contentTextView addSubview:label];
}

- (void)setFeedBackBtn:(UIButton *)feedBackBtn{
    _feedBackBtn = feedBackBtn;
    feedBackBtn.backgroundColor = [UIColor colorWithRed:37/255.0 green:116/255.0 blue:216/255.0 alpha:1];
}

- (IBAction)feedBackClick:(id)sender {
    [self.view endEditing:YES];
    if ([self check]) {
        [self submit];
    }
    
}

#pragma mark -TextViewDelegate

- (void) textViewDidChange:(UITextView *)textView{
    if ([textView.text length] == 0) {
        [label setHidden:NO];
    }else{
        [label setHidden:YES];
    }
}

#pragma mark - 验证信息正确性

- (BOOL)check{
    if ([self.contentTextView.text isEqualToString:@""] || self.contentTextView.text == nil) {
        return NO;
    }
    return YES;
}

#pragma mark - 网络请求方法
- (void)submit{
    
    SYWCommonRequest *api = [[SYWCommonRequest alloc] init];
    api.ReqURL = @"http://www.yuntech.com.cn/yuntech/DataService/JianyunBao.aspx";
    
    api.ReqDictionary =
    @{
      @"method":@"FeedBack",
      @"employeeId":JYB_userId,
      @"enterpriseCode":JYB_enterpriseCode,
      @"employeeName":self.user.name,
      @"note":self.contentTextView.text,
      @"userPhone":self.user.phoneNum,
      @"platFormModel":[[JYBDevice sharedDevice] deviceString]?[[JYBDevice sharedDevice] deviceString]:@"",
      @"platFormInfo":[[JYBDevice sharedDevice] systemVersion]?[[JYBDevice sharedDevice] systemVersion]:@"",
      @"userIp":[[JYBDevice sharedDevice] localIPAddress]?[[JYBDevice sharedDevice] localIPAddress]:@""
      };
    
    __weak typeof(self) weakSelf = self;
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        DLogJSON(request.responseJSONObject);
        if (GoodResponse) {
            [weakSelf showHint:@"操作成功"];
            self.contentTextView.text = @"";
            [label setHidden:NO];
        }else{
            [weakSelf showHint:BadResponseMessage];
        }
        
    } failure:^(YTKBaseRequest *request) {
    }];
}

@end
