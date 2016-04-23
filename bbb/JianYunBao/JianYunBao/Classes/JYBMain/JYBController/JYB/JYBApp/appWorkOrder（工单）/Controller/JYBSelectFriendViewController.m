//
//  JYBSelectFriendViewController.m
//  JianYunBao
//
//  Created by faith on 16/3/16.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBSelectFriendViewController.h"
#import "SYWCommonRequest.h"
#import "JYBFriendItem.h"
#import "JYBFriendItemTool.h"
#import "JYBFriendsGroupItem.h"
#import "NSString+PinYin.h"
#import "JYBSelectFriendCell.h"
#import "JYBSyncIChatGroupApi.h"
#import "JYBSyncGroupModel.h"
#import "BDIMDatabaseUtil.h"
#import "EasyAlert.h"
#import "JYBGetGroupUserApi.h"
#import "JYBChatGroupViewController.h"

@interface JYBSelectFriendViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UISearchBar *_searchBar;
    UITextField * _groupNameTF;
    BOOL  _isShowData;
    NSIndexPath *selectedIndexPath;
}
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSMutableArray * firstSectionData;
@property (nonatomic, strong) NSMutableArray * dataSource;
@property (nonatomic, strong) NSMutableArray *allDataSource;
@property (nonatomic, strong) NSMutableArray *frequentDataSource;

@property (nonatomic, strong) NSMutableArray * selctedFriends;

@end

@implementation JYBSelectFriendViewController

- (NSMutableArray *)selctedFriends{
    if (_selctedFriends == nil){
        _selctedFriends = [NSMutableArray array];
    }
    return _selctedFriends;
}
- (NSMutableArray *)firstSectionData{
    if (_firstSectionData == nil) {
        _firstSectionData = [NSMutableArray array];
    }
    return _firstSectionData;
}

- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)allDataSource{
    if (_allDataSource == nil) {
        _allDataSource = [NSMutableArray array];
    }
    return _allDataSource;
}

- (NSMutableArray *)frequentDataSource{
    if (_frequentDataSource == nil) {
        _frequentDataSource = [NSMutableArray array];
    }
    return _frequentDataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (iOS7){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    selectedIndexPath = [NSIndexPath indexPathForItem:-1 inSection:-1];
    [self addNavgationBarButtonWithImage:nil title:@"确定" titleColor:[UIColor whiteColor] addTarget:self action:@selector(confirm) direction:JYBNavigationBarButtonDirectionRight];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, Mwidth, 40)];
    _searchBar.placeholder = @"搜索";
    _searchBar.delegate = self;
    [self.view addSubview:_searchBar];
    [self.firstSectionData addObjectsFromArray:@[ @"常用联系人"]];
    [self.view addSubview:self.table];
    
    //获取人员信息
    if (self.isFromCreatGroup && self.isFromAddPerson){
        [self loadMembersInfo];
    }
}
- (void)loadMembersInfo{
    for (NSString * userId in self.selectedMembersIds){
        SYWCommonRequest *api = [[SYWCommonRequest alloc] init];
        api.ReqURL = JYBErpHttpUrl(@"jianyunbao.aspx");
        api.ReqDictionary = @{@"method":@"getUserInfo",
                              @"enterpriseCode":[RuntimeStatus sharedInstance].buildCloudEntity.enterpriseCode,
                              @"id":userId};
        [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
            if (GoodResponse){
                JYBFriendItem * item = [JYBFriendItem mj_objectWithKeyValues:APIJsonObject];
                [self.selctedFriends addObject:item];
            }
        } failure:^(__kindof YTKBaseRequest *request) {
        }];
    }
}
#pragma mark -
//MARK: Init
- (instancetype)init{
    
    if (self =[super init]) {
        [self getContactsReq];
    }
    return self;
}
//MARK: setter & getter
- (UITableView *)table
{
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, Mwidth, Mheight -40)];
        _table.delegate = self;
        _table.dataSource = self;
    }
    return _table;
}
//MARK: UITableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count+1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!section) {
        return 1;
    } else {
        JYBFriendsGroupItem *item = self.dataSource[section - 1];
        return [item.content count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JYBSelectFriendCell *cell = [JYBSelectFriendCell cellWithTableView:tableView indexPath:indexPath];
    cell.selectFriendBlock = ^(JYBSelectFriendCell *cell){
        NSIndexPath *indexPath = [_table indexPathForCell:cell];
        [self tableView:_table didSelectRowAtIndexPath:indexPath];
    };
    if (!indexPath.section) {
        cell.selectButton.hidden = YES;
        [cell setOtherContactEntity:_firstSectionData[indexPath.row]];
    } else {
        JYBFriendsGroupItem *item = self.dataSource[indexPath.section - 1];
        JYBFriendItem * friendItem = item.content[indexPath.row];
        [cell setFriendItem:friendItem];
        //是否选中
        if ([self isFromAddPerson] || ([self isFromCreatGroup] && [self isFromAddPerson])){
            if ([self.selectedMembersIds containsObject:friendItem.friendId]){
                [cell setCheckImg:YES];
                cell.selectButton.enabled = NO;
                cell.selectButton.selected = YES;
            }else{
                [cell setCheckImg:NO];
                cell.selectButton.enabled = YES;
                cell.selectButton.selected = NO;
            }
        }
    }
    return cell;
}

//MARK: UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [JYBSelectFriendCell heightForRow];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = nil;
    if (section) {
        headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, Compose_Scale(36.0/2.0))];
        headerView.backgroundColor = [UIColor jyb_backgroundColor];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(11, 0, SCR_WIDTH - 11 * 2, headerView.height)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor hexFloatColor:@"808080"];
        JYBFriendsGroupItem *item = self.dataSource[section-1];
        titleLabel.text = item.firstLetter;
        titleLabel.font = [UIFont boldSystemFontOfSize:Compose_Scale(14.0)];
        [headerView addSubview:titleLabel];
    }
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section) {
        return Compose_Scale(36.0/2.0);
    } else {
        return 0.0;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section ==0)
    {
        if (_isShowData) {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:self.allDataSource];
            [self.firstSectionData removeAllObjects];
            [self.firstSectionData addObjectsFromArray:@[@"常用联系人"]];
            _isShowData = NO;
        }else{
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:self.frequentDataSource];
            [self.firstSectionData removeAllObjects];
            [self.firstSectionData addObjectsFromArray:@[@"全部联系人"]];
            _isShowData = YES;
        }
        
        
        [self.table reloadData];
        
    }
    else
    {
        if (self.isFromCreatGroup || self.isFromAddPerson){
            JYBSelectFriendCell * cell = (JYBSelectFriendCell *)[tableView cellForRowAtIndexPath:indexPath];
            cell.selectButton.selected = !cell.selectButton.selected;
            JYBFriendsGroupItem *groupItem = self.dataSource[indexPath.section-1];
            JYBFriendItem * item = groupItem.content[indexPath.row];
            
            if (cell.selectButton.selected){
                [self.selctedFriends addObject:item];
            }else {
                [self.selctedFriends removeObject:item];
            }
        }else{
            if(selectedIndexPath == indexPath)
            {
                return;
            }
            else
            {
                JYBSelectFriendCell *oldCell = (JYBSelectFriendCell *) [tableView cellForRowAtIndexPath:selectedIndexPath];
                oldCell.selectButton.selected = NO;
                JYBSelectFriendCell *newCell = (JYBSelectFriendCell *) [tableView cellForRowAtIndexPath:indexPath];
                newCell.selectButton.selected = YES;
            }
            selectedIndexPath = indexPath;
        }
    }
}

#pragma mark - 网络请求
- (void)getContactsReq{
    
    SYWCommonRequest *api = [[SYWCommonRequest alloc] init];
    api.ReqURL = [NSString stringWithFormat:@"%@/JianyunBao.aspx?",JYB_erpHttpUrl];
    api.ReqDictionary =
    @{
      @"method":@"getAddressList",
      @"id":JYB_userId,
      @"pageIndex":@1,
      @"enterpriseCode":JYB_enterpriseCode
      };
    //    __weak typeof(self) weakSelf = self;
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        DLogJSON(request.responseJSONObject);
        if (GoodResponse) {
            [self.allDataSource removeAllObjects];
            [self.frequentDataSource removeAllObjects];
            [self.dataSource removeAllObjects];
            NSArray *saveArr = [JYBFriendItem mj_objectArrayWithKeyValuesArray:APIJsonObject[@"list"]];
            [JYBFriendItemTool addFriends:saveArr];
            NSArray * tempArr = APIJsonObject[@"list"];
            NSMutableArray *frequentArr = [NSMutableArray array];
            if ([tempArr count]) {
                for (NSDictionary *dic in [[tempArr arrayWithPinYinFirstLetterFormat]mutableCopy]) {
                    JYBFriendsGroupItem *item = [JYBFriendsGroupItem mj_objectWithKeyValues:dic];
                    NSArray *friends = [JYBFriendItem mj_objectArrayWithKeyValuesArray:dic[@"content"]];
                    item.content = friends;
                    [self.allDataSource addObject:item];
                }
                for(int i = 0; i < tempArr.count; i++){
                    NSDictionary *dic = tempArr[i];
                    if ([dic[@"isContact"] integerValue] > 0) {
                        [frequentArr addObject:dic];
                    }
                }
                for (NSDictionary *dic in [[frequentArr arrayWithPinYinFirstLetterFormat]mutableCopy]) {
                    JYBFriendsGroupItem *item = [JYBFriendsGroupItem mj_objectWithKeyValues:dic];
                    NSArray *friends = [JYBFriendItem mj_objectArrayWithKeyValuesArray:dic[@"content"]];
                    item.content = friends;
                    [self.frequentDataSource addObject:item];
                }
            }
            
            [self.dataSource addObjectsFromArray:self.allDataSource];
            [self.table reloadData];
        }else{
            [self showHint:BadResponseMessage];
        }
        
    } failure:^(YTKBaseRequest *request) {
    }];
}

- (void)confirm
{
    if (self.isFromCreatGroup || self.isFromAddPerson){
        if (self.isFromCreatGroup || (self.isFromAddPerson && self.isFromCreatGroup)){
            if (self.selctedFriends.count == 0){
                showMessage(@"请选择人员！");
                return;
            }
            if (self.isFromAddPerson && self.isFromCreatGroup){//2人以上为群组
                if (self.selctedFriends.count == 2){
                    showMessage(@"请选择人员！");
                    return;
                }
            }
            [self alertInputGroupName];
        }else {
            if (self.selctedFriends.count == 0){
                showMessage(@"请选择需要添加的人员!");
                return;
            }
            if (self.delegate && [self.delegate respondsToSelector:@selector(selectedFriendWithItems:)]){
                [self.delegate selectedFriendWithItems:self.selctedFriends];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }else{
        if (selectedIndexPath.row == -1){
            showMessage(@"请选择人员！");
            return;
        }
        
        JYBFriendsGroupItem *groupItem = self.dataSource[selectedIndexPath.section-1];
        JYBFriendItem * item = groupItem.content[selectedIndexPath.row];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SelctedFriendNotifiaction" object:item userInfo:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)alertInputGroupName{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"请输入群聊名称" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    _groupNameTF = [alert textFieldAtIndex:0];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1){
        if (_groupNameTF.text.length != 0){
            [self creatGroup];
        }else{
            showMessage(@"群聊名称不能为空！");
        }
    }
}
//创建群聊 type：0为群聊 1为讨论组
- (void)creatGroup{
    NSInteger groupType = 0;
    NSMutableArray * users = [[NSMutableArray alloc] initWithCapacity:0];
    for (JYBFriendItem * item in self.selctedFriends){
        [users addObject:item.friendId];
    }
    
    //设置请求体
    NSString * ids = [users componentsJoinedByString:@"&po.userIds="];
    NSString * params = [NSString stringWithFormat:@"po.enterpriseCode=%@&po.userId=%@&po.userName=%@&po.name=%@&po.type=%@&po.userIds=%@",JYB_enterpriseCode,JYB_userId,JYB_userName,_groupNameTF.text,@(groupType),ids];
    NSString *urlString = [NSString stringWithFormat:@"%@/phone/Group!create.action",JYB_bcHttpUrl];
    NSMutableURLRequest  *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    [request setTimeoutInterval:20.0];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (connection == nil) {
        [EasyAlert say:@"创建失败！"];
        return;
    }
}

#pragma mark NSURLConnection Delegate

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
        } message:@"创建成功！"];
    }else{
        [EasyAlert say:@"创建失败！"];
    }
}
//获得该群所有用户
- (void)asyncLoadGroupUserWithGroups:(JYBSyncGroupModel *)model
{
    JYBGetGroupUserApi *groupUserApi = [[JYBGetGroupUserApi alloc] initWithGroupId:model.sid];
    [groupUserApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        if ([APIJsonObject[@"result"] boolValue] && ![APIJsonObject[@"deleted"] boolValue]) {
            model.userIds  = APIJsonObject[@"po"][@"userIds"];
            //插入数据
            [[BDIMDatabaseUtil sharedInstance] insertGroup:@[model]];
            //进入群聊
            JYBChatGroupViewController *chatView = [[JYBChatGroupViewController alloc] initWithChatter:model.sid type:JYBConversationTypeGroup];
            chatView.navigationTitle = model.name;
            chatView.groupModel = model;
            [self.navigationController pushViewController:chatView animated:YES];
            
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

@end
