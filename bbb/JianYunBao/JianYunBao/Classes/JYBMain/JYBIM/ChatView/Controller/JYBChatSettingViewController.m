
//
//  JYBChatSettingViewController.m
//  JianYunBao
//
//  Created by 正 on 16/3/28.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBChatSettingViewController.h"
#import "JYBMultiContainerView.h"
#import "JYBSelectFriendViewController.h"
#import "JYBFriendItem.h"
#import "JYBChatGroupNameView.h"
#import "JYBChatGroupClearCashView.h"
#import "SYWCommonRequest.h"
#import "JYBGetGroupUserApi.h"
#import "JYBPersonalInformationViewController.h"
#import "BDIMDatabaseUtil.h"
#import "EasyAlert.h"

@interface JYBChatSettingViewController ()<JYBMultiContainerViewDelegate,JYBChatGroupNameViewDelegate,JYBChatGroupClearCashViewDelegate,JYBSelectFriendViewControllerDelegate,UIAlertViewDelegate>{
    JYBMultiContainerView * multiContainer;
    JYBChatGroupNameView * groupName;
    UIScrollView * backScrollView;
    UIButton * quitButton;
    UITextField * groupNameInput;
}
@property (nonatomic, strong) NSMutableArray * friends;
@property (nonatomic, strong) NSMutableArray * membersIds;
@property (nonatomic, strong) NSMutableArray * addMembersIds;
@property (nonatomic, strong) NSMutableArray * deleteMembersIds;//暂无用
@property (nonatomic, strong) NSArray * callBackArray;

@end

@implementation JYBChatSettingViewController

- (NSMutableArray *)friends{
    if (!_friends){
        _friends = [NSMutableArray array];
    }
    return _friends;
}
- (NSMutableArray *)membersIds{
    if (!_membersIds){
        _membersIds = [NSMutableArray array];
    }
    return _membersIds;
}
- (NSMutableArray *)addMembersIds{
    if (!_addMembersIds){
        _addMembersIds = [NSMutableArray array];
    }
    return _addMembersIds;
}
-(NSMutableArray *)deleteMembersIds{
    if (!_deleteMembersIds){
        _deleteMembersIds = [NSMutableArray array];
    }
    return _deleteMembersIds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    backScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    backScrollView.contentSize = CGSizeMake(SCR_WIDTH, SCR_HEIGHT - 100);
    [self.view addSubview:backScrollView];
    
    //获取人员信息
    [self loadMembersInfo];
}
- (void)loadMembersInfo{
    [self.friends removeAllObjects];
    for (NSString * userId in self.groupModel.userIds){
        SYWCommonRequest *api = [[SYWCommonRequest alloc] init];
        api.ReqURL = JYBErpHttpUrl(@"jianyunbao.aspx");
        api.ReqDictionary = @{@"method":@"getUserInfo",
                              @"enterpriseCode":[RuntimeStatus sharedInstance].buildCloudEntity.enterpriseCode,
                              @"id":userId};
        [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
            if (GoodResponse){
                [self.friends addObject:APIJsonObject];
            }
        } failure:^(__kindof YTKBaseRequest *request) {
        }];
    }
    [self performSelector:@selector(showGroupMember) withObject:self afterDelay:1.0];
}
- (void)showGroupMember{
    multiContainer = [[JYBMultiContainerView alloc] initWithFrame:CGRectMake(5, 5, SCR_WIDTH - 10, 60)];
    multiContainer.delegate = self;
    //只有创建人可以删除
    if ([self.groupModel.userId isEqualToString:JYB_userId]){
        multiContainer.isRemoveable = YES;
    }
    [backScrollView addSubview:multiContainer];
    
    groupName = [[JYBChatGroupNameView alloc] initWithFrame:CGRectMake(5,15 + multiContainer.frame.size.height, SCR_WIDTH - 10, 50)];
    groupName.delegate = self;
    groupName.groupNameLab.text = self.groupModel.name;
    [backScrollView addSubview:groupName];
    
    JYBChatGroupClearCashView * clearCash = [[JYBChatGroupClearCashView alloc] initWithFrame:CGRectMake(5, groupName.frame.size.height + groupName.frame.origin.y + 10, SCR_WIDTH - 10, 50)];
    clearCash.delegate = self;
    [backScrollView addSubview:clearCash];
    
    quitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [quitButton setFrame:CGRectMake(5, clearCash.frame.size.height + clearCash.frame.origin.y + 20, SCR_WIDTH - 10, 40)];
    if ([self.groupModel.userId isEqualToString:JYB_userId]){
        [quitButton setTitle:@"删除并退出" forState:UIControlStateNormal];
    }else{
        [quitButton setTitle:@"退出群聊" forState:UIControlStateNormal];
    }
    [quitButton setBackgroundColor:[UIColor colorWithRed:0.9020 green:0.0980 blue:0.1686 alpha:1.0]];
    [quitButton addTarget:self action:@selector(quitGroup) forControlEvents:UIControlEventTouchUpInside];
    [backScrollView addSubview:quitButton];
    //展示人员
    [multiContainer addPersons:self.friends];
}
//添加人员
- (void)multiplayerContainerViewActionForAddPerson:(JYBMultiContainerView *)multiplayerContainerView{
    [self selectedFriends];
}
- (void)multiplayerContainerView:(JYBMultiContainerView *)multiplayerContainerView actionForSelectedPerson:(NSDictionary *)person{
    JYBPersonalInformationViewController *ctr = [[JYBPersonalInformationViewController alloc] init];
    ctr.navigationTitle = @"详细资料";
    NSArray *ary = [JYBFriendItem mj_objectArrayWithKeyValuesArray:@[person]];
    ctr.friendItem = ary[0];
    [self.navigationController pushViewController:ctr animated:YES];
}
//删除人员
- (void)multiplayerContainerView:(JYBMultiContainerView *)multiplayerContainerView actionForRemovePerson:(NSDictionary *)person{
    //请求删除人员
    [self deleteUsersWithPerson:person];
}
//选人
- (void)selectedFriends{
    for (NSDictionary * member in self.friends){
        [self.membersIds addObject:member[@"id"]];
    }
    JYBSelectFriendViewController * senderVC = [[JYBSelectFriendViewController alloc] init];
    senderVC.title = @"发起人";
    senderVC.delegate = self;
    senderVC.selectedMembersIds = self.membersIds;
    senderVC.isFromAddPerson = YES;
    [self.navigationController pushViewController:senderVC animated:YES];
}
//选人回调
- (void)selectedFriendWithItems:(NSArray *)friends{
    [self.addMembersIds removeAllObjects];
    self.callBackArray = [NSArray arrayWithArray:friends];
    for (JYBFriendItem * item in friends){
        [self.addMembersIds addObject:item.friendId];
    }
    //请求添加接口
    [self addUsers];
}
//添加人员请求
- (void)addUsers{
    NSString * ids = [self.addMembersIds componentsJoinedByString:@"&po.userIds="];
    NSString * params = [NSString stringWithFormat:@"po.id=%@&po.userId=%@&po.userIds=%@",self.groupModel.sid,JYB_userId,ids];
    NSString * urlString = [NSString stringWithFormat:@"%@/phone/Group!addUsers.action",JYB_bcHttpUrl];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setTimeoutInterval:20.0];
    [request setHTTPMethod:@"POST"];
    [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection * connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (connection == nil){
       NSLog(@"add field!");
    }
}
// 收到回应
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"receive the response");
    
}
// 接收数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    if ([dic[@"result"] boolValue]){
        //展示
        for (JYBFriendItem * item in self.callBackArray){
            [multiContainer addPerson:[item mj_keyValues]];
            [self.membersIds addObject:item.friendId];
        }
        //插入数据
        [EasyAlert say:^{
            NSDictionary * po = dic[@"po"];
            NSDictionary * group = @{@"createDate":po[@"dt"],
                                     @"enterpriseCode":po[@"enterpriseCode"],
                                     @"id":po[@"id"],
                                     @"name":po[@"name"],
                                     @"userId":po[@"userId"],
                                     @"userName":po[@"userName"],
                                     @"version":po[@"version"]};
            JYBSyncGroupModel * model = [JYBSyncGroupModel mj_objectWithKeyValues:group];
            [self asyncLoadGroupUserWithGroups:model];
        } message:@"新增成功！"];
    }else{
        [EasyAlert say:@"新增失败！"];
    }
}
- (void)asyncLoadGroupUserWithGroups:(JYBSyncGroupModel *)model
{
    JYBGetGroupUserApi *groupUserApi = [[JYBGetGroupUserApi alloc] initWithGroupId:model.sid];
    [groupUserApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        if ([APIJsonObject[@"result"] boolValue] && ![APIJsonObject[@"deleted"] boolValue]) {
            model.userIds  = APIJsonObject[@"po"][@"userIds"];
            [[BDIMDatabaseUtil sharedInstance] insertGroup:@[model]];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
}
// 数据接收完毕
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    NSLog(@"finishLoading");
}
// 返回错误
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    NSLog(@"Connection failed: %@", error);
}
//删除人员请求
- (void)deleteUsersWithPerson:(NSDictionary *)person{
    SYWCommonRequest * api = [[SYWCommonRequest alloc] init];
    api.ReqURL = [NSString stringWithFormat:@"%@/phone/Group!removeUsers.action",JYB_bcHttpUrl];
    api.ReqDictionary = @{@"po.id":self.groupModel.sid,
                          @"po.userId":JYB_userId,
                          @"po.userName":JYB_userName,
                          @"po.userIds":person[@"id"]};
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        if (GoodResponse){
            if ([APIJsonObject[@"result"] boolValue]){
                [EasyAlert say:^{
                    [multiContainer removePerson:person];
                    NSDictionary * po = APIJsonObject[@"po"];
                    NSDictionary * group = @{@"createDate":po[@"dt"],
                                             @"enterpriseCode":po[@"enterpriseCode"],
                                             @"id":po[@"id"],
                                             @"name":po[@"name"],
                                             @"userId":po[@"userId"],
                                             @"userName":po[@"userName"],
                                             @"version":po[@"version"]};
                    JYBSyncGroupModel * model = [JYBSyncGroupModel mj_objectWithKeyValues:group];
                    [self asyncLoadGroupUserWithGroups:model];
                } message:@"删除人员成功！"];
            }else{
                [EasyAlert say:@"删除失败！"];
            }
        }else{
            [EasyAlert say:BadResponseMessage];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
}
//选中群组名称
- (void)selecteGroupName{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"请输入新的群组名称" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    groupNameInput = [alert textFieldAtIndex:0];
    groupNameInput.text = self.groupModel.name;
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1){
        if (![groupNameInput.text isEqualToString:self.groupModel.name]){
            //修改群组信息
            [self editGroup];
        }
    }
}
//修改群组
- (void)editGroup{
    SYWCommonRequest * api = [[SYWCommonRequest alloc] init];
    api.ReqURL = [NSString stringWithFormat:@"%@/phone/Group!edit.action",JYB_bcHttpUrl];
    api.ReqDictionary = @{@"po.id":self.groupModel.sid,
                          @"po.userId":JYB_userId,
                          @"po.name":groupNameInput.text};
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        if (GoodResponse){
            if ([APIJsonObject[@"result"] boolValue]){
                [EasyAlert say:^{
                    groupName.groupNameLab.text = groupNameInput.text;
                    NSDictionary * po = APIJsonObject[@"po"];
                    NSDictionary * group = @{@"createDate":po[@"dt"],
                                             @"enterpriseCode":po[@"enterpriseCode"],
                                             @"id":po[@"id"],
                                             @"name":po[@"name"],
                                             @"userId":po[@"userId"],
                                             @"userName":po[@"userName"],
                                             @"version":po[@"version"]};
                    JYBSyncGroupModel * model = [JYBSyncGroupModel mj_objectWithKeyValues:group];
                    [self asyncLoadGroupUserWithGroups:model];
                } message:@"修改成功！"];
                
            }else{
                [EasyAlert say:@"修改失败！"];
            }
        }else{
            [EasyAlert say:BadResponseMessage];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
}
//清空记录
- (void)selectClearCash{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ClearCacheNotification" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
//退出群聊
- (void)quitGroup{
    SYWCommonRequest * api = [[SYWCommonRequest alloc] init];
    NSString * method;
    NSDictionary * params = @{@"po.id":self.groupModel.sid,
                              @"po.userId":JYB_userId,
                              @"po.userName":JYB_userName};
    BOOL deleteHandle = NO;
    //删除
    if ([self.groupModel.userId isEqualToString:JYB_userId]){
        deleteHandle = YES;
        method = @"/phone/Group!delete.action";
    }
    //退出
    else{
        deleteHandle = NO;
        method = @"/phone/Group!outGroup.action";
    }
    api.ReqURL = [NSString stringWithFormat:@"%@%@",JYB_bcHttpUrl,method];
    api.ReqDictionary = params;
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        if (GoodResponse){
            if ([APIJsonObject[@"result"] boolValue]){
                NSString * alertStr = @"确定退出群聊？";
                if (deleteHandle){
                    alertStr = @"确定删除群聊?";
                }
                [EasyAlert confirm:^{
                    [[BDIMDatabaseUtil sharedInstance] deleteGroupWithSid:self.groupModel.sid];
                    [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
                } question:alertStr];
            }else{
                [EasyAlert say:APIJsonObject[@"message"]];
            }
        }else {
            [EasyAlert say:BadResponseMessage];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
