//
//  JYBSyncGroupController.m
//  JianYunBao
//
//  Created by 冰点 on 16/3/15.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBSyncGroupController.h"
#import "JYBSyncGroupCell.h"
#import "JYBSyncIChatGroupApi.h"
#import "JYBSyncGroupModel.h"
#import "BDIMDatabaseUtil.h"
#import "JYBGetGroupUserApi.h"


@interface JYBSyncGroupController ()<UITableViewDelegate, UITableViewDataSource>
{
    BOOL allSel;//全选标记
    
}

@property (nonatomic, strong) NSArray *groups;
@property (nonatomic, strong) NSMutableArray *selectedGroups;
@property (nonatomic, strong) NSMutableDictionary *selectTagDic;//状态存储

@end

@implementation JYBSyncGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationTitle = @"群组(专题讨论组)";
    
    [self addNavgationBarButtonWithImageName:@"搜索查询" otherTitles:@"同步", @"全选", nil];
    [self.view addSubview:self.table];
    
    allSel = NO;
    
    [self loadGroupDataFromService];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
//MARK: Init

//MARK: setter & getter
- (BDBaseTableView *)table
{
    if (!_table) {
        _table = [[BDBaseTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        [_table hideTableViewCellSeparator];
    }
    return _table;
}

- (NSMutableArray *)selectedGroups
{
    if (!_selectedGroups) {
        _selectedGroups = [NSMutableArray array];
    }
    return _selectedGroups;
}

- (NSMutableDictionary *)selectTagDic
{
    if (!_selectTagDic) {
        _selectTagDic = [NSMutableDictionary dictionary];
    }
    return _selectTagDic;
}

//MARK: loadData
- (void)loadGroupDataFromService
{
    JYBSyncIChatGroupApi *api = [[JYBSyncIChatGroupApi alloc] initSyncIChatGroupWithType:JYBIChatTypeGroup groupName:@"" startDt:@"" endDt:@"" page:1];
    
    [self showHudInView:self.view hint:nil];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        DLogJSON(request.responseJSONObject);
        [self hideHud];
        if ([request.responseJSONObject[@"result"] boolValue]) {
            self.groups = [JYBSyncGroupModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject[@"list"]];
            [self asyncLoadGroupUserWithGroups:self.groups];
            [self.table reloadData];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [self hideHud];
        [self showHint:@"网络异常！"];
    }];
}

- (void)asyncLoadGroupUserWithGroups:(NSArray *)groups
{
    for (JYBSyncGroupModel *model in groups) {
        JYBGetGroupUserApi *groupUserApi = [[JYBGetGroupUserApi alloc] initWithGroupId:model.sid];
        [groupUserApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
            DLogJSON(request.responseJSONObject);
            if ([APIJsonObject[@"result"] boolValue] && ![APIJsonObject[@"deleted"] boolValue]) {
                model.userIds  = APIJsonObject[@"po"][@"userIds"];
            }
        } failure:^(__kindof YTKBaseRequest *request) {
            
        }];
    }
}

//MARK: Action

//MARK: UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [self.groups count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    JYBSyncGroupCell *syncGroupCell = [JYBSyncGroupCell cellWithTableView:tableView indexPath:indexPath];
    [syncGroupCell setSyncGroupCellModel:self.groups[indexPath.row]];
    [syncGroupCell setCheckBoxStatus:allSel];
    
    if (!allSel){
        [self.selectTagDic removeObjectForKey:@(indexPath.row)];
        BOOL ret = [self.selectTagDic[@(indexPath.row)] boolValue];
        [syncGroupCell setCheckBoxStatus:ret];
    }else{
        [self.selectTagDic safeSetObject:[NSNumber numberWithBool:YES] forKey:@(indexPath.row)];
    }
    
    return syncGroupCell;
}

//MARK: UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYBSyncGroupCell *currentCell = (JYBSyncGroupCell *)[tableView cellForRowAtIndexPath:indexPath];
     JYBSyncGroupModel *model = self.groups[indexPath.row];
    
    if ([self.selectTagDic[@(indexPath.row)] boolValue]) {
        [self.selectTagDic removeObjectForKey:@(indexPath.row)];
        [self.selectedGroups removeObject:model];
        [currentCell setCheckBoxStatus:NO];
    } else {
        [self.selectTagDic safeSetObject:[NSNumber numberWithBool:YES] forKey:@(indexPath.row)];
        [self.selectedGroups addObject:model];
        [currentCell setCheckBoxStatus:YES];
    }
    allSel = self.selectedGroups.count == self.groups.count ? YES : NO;
    NSLog(@"全选：%d",allSel);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return [JYBSyncGroupCell heightForRow];
}

- (void)navigationItemBtn:(UIButton *)btn clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0://TODO: 搜索
            showMessage(@"弹出下拉框！");
            break;
        case 1://TODO: 同步
        {
            if (self.selectedGroups.count == 0){
                showMessage(@"请选择需要同步的数据！");
                return;
            }
            //存到DB中
            BOOL ret = [[BDIMDatabaseUtil sharedInstance] insertGroup:self.selectedGroups];
            if (ret) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
            break;
        case 2://TODO: 全选
            allSel = !allSel;
            [self.selectedGroups removeAllObjects];
            if (allSel){
                [self.selectedGroups addObjectsFromArray:self.groups];
            }
            [self.table reloadData];
            break;
        default:
            break;
    }
}

//MARK: Other


@end
