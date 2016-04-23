//
//  JYBNoticeDetailViewController.m
//  JianYunBao
//
//  Created by 正 on 16/3/16.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBNoticeDetailViewController.h"
#import "SYWCommonRequest.h"
#import "JYBNoticeCommentViewController.h"

@interface JYBNoticeDetailViewController ()
{
    BOOL isAgree;
}
@property (weak, nonatomic) IBOutlet UIWebView *web;
@property (weak, nonatomic) IBOutlet JYBLabel *agreeLab;

@end

@implementation JYBNoticeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.agreeLab.text = [NSString stringWithFormat:@"赞(%@)",self.agreeCount];
    [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",JYB_erpRootUrl,self.url]]]];

    [self loadNoticeAgrees];
}
//评论
- (IBAction)commentAction:(id)sender {
    JYBNoticeCommentViewController * comment = [[JYBNoticeCommentViewController alloc] initWithChatter:self.newsId type:JYBConversationTypeNoticeComment];
    comment.title = self.title;
    [self.navigationController pushViewController:comment animated:YES];
}
//点赞
- (IBAction)agreeAction:(id)sender {
    if(isAgree){
        [self showHint:@"请勿重复点赞！"];
        return;
    }
    [self loadNoticeAgreeAction];
}

//获取点赞数
- (void)loadNoticeAgrees{
    SYWCommonRequest * api = [[SYWCommonRequest alloc] init];
    api.ReqURL = [NSString stringWithFormat:@"%@/phone/NoticeAgree!loadAgrees.action",JYB_bcHttpUrl];
    api.ReqDictionary = @{@"newsId":self.newsId,
                          @"userId":JYB_userId};
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        if(GoodResponse){
            self.agreeLab.text = [NSString stringWithFormat:@"赞(%@)",APIJsonObject[@"agrees"]];
            if([APIJsonObject[@"isDone"] boolValue]){
                self.agreeLab.textColor = [UIColor redColor];
                self.agreeLab.text = [NSString stringWithFormat:@"已赞(%@)",APIJsonObject[@"agrees"]];
                isAgree = YES;
            }else{
                isAgree = NO;
            }
        }else{
            [self showHint:BadResponseMessage];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
}

//点赞操作
- (void)loadNoticeAgreeAction{
    SYWCommonRequest * api = [[SYWCommonRequest alloc] init];
    api.ReqURL = [NSString stringWithFormat:@"%@/phone/NoticeAgree!agree.action",JYB_bcHttpUrl];
    api.ReqDictionary = @{@"enterpriseCode":JYB_enterpriseCode,
                          @"userId":JYB_userId,
                          @"userName":JYB_userName,
                          @"newsId":self.newsId};
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        if(GoodResponse){
            //请求点赞数量
            [self loadNoticeAgrees];
        }else{
            [self showHint:BadResponseMessage];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
}


//获取通知详情
- (void)loadNoticeDetail{
    SYWCommonRequest * api = [[SYWCommonRequest alloc] init];
    api.ReqURL = [NSString stringWithFormat:@"%@/phone/Notice!get.action",JYB_bcHttpUrl];
    api.ReqDictionary = @{@"newsId":self.newsId};
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        if(GoodResponse){
            NSLog(@"详情：%@",APIJsonObject);
        }else{
            [self showHint:BadResponseMessage];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
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
