//
//  JYBSingleChatSettingViewController.m
//  JianYunBao
//
//  Created by 正 on 16/4/1.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBSingleChatSettingViewController.h"
#import "JYBMultiContainerView.h"
#import "SYWCommonRequest.h"
#import "JYBPersonalInformationViewController.h"
#import "JYBSelectFriendViewController.h"
#import "JYBGetGroupUserApi.h"
#import "JYBSyncGroupModel.h"
#import "BDIMDatabaseUtil.h"
#import "JYBSingleChatClearCashView.h"

@interface JYBSingleChatSettingViewController ()<JYBMultiContainerViewDelegate,JYBSelectFriendViewControllerDelegate,JYBSingleChatClearCashViewDelegate>{
    JYBMultiContainerView * container;
}
@property (strong, nonatomic) NSMutableArray * membersIds;
@end

@implementation JYBSingleChatSettingViewController

- (NSMutableArray *)membersIds{
    if (!_membersIds){
        _membersIds = [NSMutableArray array];
    }
    return _membersIds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //获取人员详情
    [self loadUserInfo];
    container = [[JYBMultiContainerView alloc] initWithFrame:CGRectMake(5, 5, SCR_WIDTH - 10, 60)];
    container.delegate = self;
    [self.view addSubview:container];
    //清缓存
    JYBSingleChatClearCashView * clearCash = [[JYBSingleChatClearCashView alloc] initWithFrame:CGRectMake(5, container.frame.size.height + container.frame.origin.y + 10, SCR_WIDTH - 10, 50)];
    clearCash.delegate = self;
    [self.view addSubview:clearCash];
}
- (void)selectSingleSettingClearCash{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ClearCacheNotification" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)loadUserInfo{
    SYWCommonRequest * api = [[SYWCommonRequest alloc] init];
    api.ReqURL = JYBErpHttpUrl(@"jianyunbao.aspx");
    api.ReqDictionary = @{@"method":@"getUserInfo",
                          @"enterpriseCode":[RuntimeStatus sharedInstance].buildCloudEntity.enterpriseCode,
                          @"id":self.friendId};
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        if (GoodResponse){
            [container addPerson:APIJsonObject];
            [self.membersIds addObject:APIJsonObject[@"id"]];
            [self.membersIds addObject:JYB_userId];
        }else{
            showMessage(@"获取人员信息失败！");
            [self.navigationController popViewControllerAnimated:YES];
            return ;
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
}

- (void)multiplayerContainerView:(JYBMultiContainerView *)multiplayerContainerView actionForRemovePerson:(NSDictionary *)person{

}
- (void)multiplayerContainerView:(JYBMultiContainerView *)multiplayerContainerView actionForSelectedPerson:(NSDictionary *)person{
    JYBPersonalInformationViewController *ctr = [[JYBPersonalInformationViewController alloc] init];
    ctr.navigationTitle = @"详细资料";
    NSArray *ary = [JYBFriendItem mj_objectArrayWithKeyValuesArray:@[person]];
    ctr.friendItem = ary[0];
    [self.navigationController pushViewController:ctr animated:YES];
}
- (void)multiplayerContainerViewActionForAddPerson:(JYBMultiContainerView *)multiplayerContainerView{
    [self selectedFriends];
}
- (void)selectedFriends{
    JYBSelectFriendViewController * senderVC = [[JYBSelectFriendViewController alloc] init];
    senderVC.title = @"发起人";
    senderVC.delegate = self;
    senderVC.selectedMembersIds = self.membersIds;
    senderVC.isFromCreatGroup = YES;
    senderVC.isFromAddPerson = YES;
    [self.navigationController pushViewController:senderVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
