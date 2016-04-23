//
//  JYBContactsViewController.m
//  JianYunBao
//
//  Created by 冰点 on 16/1/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBContactsViewController.h"
#import "JYBPersonalInformationViewController.h"
#import "JYBGroupMessageViewController.h"
#import "BDIndexTableView.h"
#import "JYBContactsCell.h"
#import "SYWCommonRequest.h"
#import "JYBFriendItem.h"
#import "JYBFriendItemTool.h"
#import "JYBFriendsGroupItem.h"
#import "NSString+PinYin.h"


@interface JYBContactsViewController () <BDIndexTableViewDelegate>
{
    BOOL  _isShowData;
    BOOL  _isUpdateContact;
    BOOL  _isUpdateHeadImg;
}
@property (nonatomic, strong) BDIndexTableView *table;
@property (nonatomic, strong) NSMutableArray * firstSectionData;
@property (nonatomic, strong) NSMutableArray * dataSource;
@property (nonatomic, strong) NSMutableArray *allDataSource;
@property (nonatomic, strong) NSMutableArray *frequentDataSource;

@end

@implementation JYBContactsViewController

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
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTable:) name:@"ChangeUserHeadNotification" object:nil];
}
- (void)updateTable:(NSNotification *)notification{
    _isUpdateHeadImg = YES;
    [self update];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isUpdateHeadImg = NO;
    [self addNavgationBarButtonWithImage:nil title:@"刷新" titleColor:[UIColor whiteColor] addTarget:self action:@selector(update) direction:JYBNavigationBarButtonDirectionRight];
    self.backgroundColor = [UIColor jyb_whiteColor];
    [self.firstSectionData addObjectsFromArray:@[@"群聊", @"常用联系人"]];
//    [self getContactsReq];
//    self.allDataSource = @[
//                        @{@"indexTitle": @"A",@"data":@[@"adam", @"alfred", @"ain", @"abdul", @"anastazja", @"angelica"]},
//                        @{@"indexTitle": @"D",@"data":@[@"dennis" , @"deamon", @"destiny", @"dragon", @"dry", @"debug", @"drums"]},
//                        @{@"indexTitle": @"F",@"data":@[@"Fredric", @"France", @"friends", @"family", @"fatish", @"funeral"]},
//                        @{@"indexTitle": @"M",@"data":@[@"Mark", @"Madeline"]},@{@"indexTitle": @"N",@"data":@[@"Nemesis", @"nemo", @"name"]},
//                        @{@"indexTitle": @"O",@"data":@[@"Obama", @"Oprah", @"Omen", @"OMG OMG OMG", @"O-Zone", @"Ontario"]},
//                        @{@"indexTitle": @"Z",@"data":@[@"Zeus", @"Zebra", @"zed"]},
//                        @{@"indexTitle": @"#",@"data":@[@"Zeus", @"Zebra", @"zed"]}
//                        ];
//    [self.dataSource addObjectsFromArray:self.allDataSource];

    [self.view addSubview:self.table];

}

- (void)update{
    DLog(@"刷新");
    _isUpdateContact = YES;
    [self.firstSectionData removeAllObjects];
    [self.firstSectionData addObjectsFromArray:@[@"群聊", @"常用联系人"]];
    [self getContactsReq];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (BDIndexTableView *)table
{
    if (!_table) {
        _table = [[BDIndexTableView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HEIGHT)];
        _table.delegate = self;
    }
    return _table;
}
//MARK: loadData

//MARK: Action

//MARK: BDIndexTableViewDelegate
- (NSArray *) sectionIndexTitlesForABELTableView:(BDIndexTableView *)tableView {
    return @[
             @"search",
             @"A",@"B",@"C",@"D",@"E",
             @"F",@"G",@"H",@"I",@"J",
             @"K",@"L",@"M",@"N",@"O",
             @"P",@"Q",@"R",@"S",@"T",
             @"U",@"V",@"W",@"X",@"Y",
             @"Z",@"#"
             ];
}

- (NSString *)titleString:(NSInteger)section {
    if (section) {
        JYBFriendsGroupItem *item = self.dataSource[section - 1];
        return item.firstLetter;
    } else {
        return nil;
    }
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    if (!section) {
//        return nil;
//    } else {
//        return self.dataSource[section-1][@"indexTitle"];
//    }
//}

//MARK: UITableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count+1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!section) {
        return 2;
    } else {
        JYBFriendsGroupItem *item = self.dataSource[section - 1];
        return [item.content count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JYBContactsCell *cell = [JYBContactsCell cellWithTableView:tableView indexPath:indexPath];
    
    if (!indexPath.section) {
        [cell setOtherContactEntity:_firstSectionData[indexPath.row]];
    } else {
        JYBFriendsGroupItem *item = self.dataSource[indexPath.section - 1];
        [cell setFriendItem:item.content[indexPath.row]];
    }
    return cell;
}

//MARK: UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [JYBContactsCell heightForRow];
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
    if (indexPath.section == 0 && indexPath.row == 0) {
        JYBGroupMessageViewController *ctr = [[JYBGroupMessageViewController alloc] init];
        [ctr setHidesBottomBarWhenPushed:YES];
        ctr.navigationTitle = @"群聊";
        [self.navigationController pushViewController:ctr animated:YES];
    }else if(indexPath.section == 0 && indexPath.row == 1){
        if (_isShowData) {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:self.allDataSource];
            [self.firstSectionData removeAllObjects];
            [self.firstSectionData addObjectsFromArray:@[@"群聊", @"常用联系人"]];
            _isShowData = NO;
        }else{
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:self.frequentDataSource];
            [self.firstSectionData removeAllObjects];
            [self.firstSectionData addObjectsFromArray:@[@"群聊", @"全部联系人"]];
            _isShowData = YES;
        }
        
        [self.table reloadData];
    }else{
        JYBPersonalInformationViewController *ctr = [[JYBPersonalInformationViewController alloc] init];
        __weak typeof(self) weakSelf = self;
        ctr.updataBlock = ^(){
            [weakSelf update];
        };
        ctr.navigationTitle = @"详细资料";
        JYBFriendsGroupItem *group = self.dataSource[indexPath.section - 1];
        JYBFriendItem *friendItem = group.content[indexPath.row];
        ctr.friendItem = friendItem;
        [ctr setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:ctr animated:YES];
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
            NSArray *tempArr = APIJsonObject[@"list"];
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
            if (_isUpdateContact){
                if (!_isUpdateHeadImg){
                    [self showHint:@"通讯录已更新"];
                }
            }
        }else{
            [self showHint:BadResponseMessage];
        }
        
    } failure:^(YTKBaseRequest *request) {
    }];
}

//MARK: Other


@end
