//
//  JYBSelectItemViewController.m
//  JianYunBao
//
//  Created by faith on 16/3/15.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBSelectItemViewController.h"
#import "SYWCommonRequest.h"
#import "JYBProjectItem.h"


@interface JYBSelectItemViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
{
  UISearchBar *_searchBar;
  NSMutableArray *_nameArr;
  UITableView *_tableView;
  NSArray *_projectItems;
}
@end



@implementation JYBSelectItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  _nameArr = [NSMutableArray array];
  _projectItems = [NSMutableArray array];
  [self addNavgationBarButtonWithImage:nil title:@"刷新" titleColor:[UIColor whiteColor] addTarget:self action:@selector(refresh) direction:JYBNavigationBarButtonDirectionRight];
  _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, Mwidth, 40)];
  _searchBar.placeholder = @"搜索";
  _searchBar.delegate = self;
  [self.view addSubview:_searchBar];
  _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 104, Mwidth, Mheight-104) style:UITableViewStylePlain];
  _tableView.dataSource = self;
  _tableView.delegate = self;
  [self.view addSubview:_tableView];
  [self loadData];
  
}
- (void)loadData
{
  NSString *enterpriseCode = [RuntimeStatus sharedInstance].buildCloudEntity.enterpriseCode;
  SYWCommonRequest *api = [[SYWCommonRequest alloc] init];
  api.ReqURL = JYBBCHttpUrl(@"/phone/SysAttr!someProject.action");
  api.ReqDictionary =
  @{
    @"enterpriseCode":enterpriseCode};
//  __weak typeof(self) weakSelf = self;
  [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
    DLogJSON(request.responseJSONObject);
    if (GoodResponse) {
      _projectItems = [JYBProjectItem mj_objectArrayWithKeyValuesArray:APIJsonObject[@"list"]];
      for(JYBProjectItem *item in _projectItems)
      {
        NSString *name = item.name;
        [_nameArr addObject:name];
      }
      [_tableView reloadData];
    }else{
      [self showHint:BadResponseMessage];
    }
    
  } failure:^(YTKBaseRequest *request) {
  }];

}
- (void)refresh
{
  
}
- (NSArray*)filterWithKeyword:(NSString*)keyword {
  NSArray* array = [NSArray array];
  if (keyword != nil &&![self isWhiteSpace:keyword]) {
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",keyword];
    NSArray* rows = [NSArray arrayWithArray:_nameArr];
    if (rows == nil || [rows isEqual:[NSNull null]]) {
      return rows;
    }
    array = [rows filteredArrayUsingPredicate:pred];
  }
  if([self isWhiteSpace:keyword])
  {
    return _nameArr;
  }
  return array;
}
- (BOOL)isWhiteSpace:(NSString *)str
{
  if([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]length] == 0)
  {
    return YES;
  }
  
  return NO;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  NSArray *rows = [self filterWithKeyword:_searchBar.text];
  return rows.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *identify = @"cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
  if(!cell)
  {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
  }
  NSArray *rows = [self filterWithKeyword:_searchBar.text];
  cell.textLabel.text = rows[indexPath.row];
  return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSArray *rows = [self filterWithKeyword:_searchBar.text];
  NSString *name = rows[indexPath.row];
  NSString *projectId;
  for(JYBProjectItem *item in _projectItems)
  {
    if([item.name isEqualToString:name])
    {
      projectId = item.projectId;
    }
  }
   
  [[NSNotificationCenter defaultCenter] postNotificationName:@"SelctedNameNotifiaction" object:@[name,projectId] userInfo:nil];
  [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UISearchBar
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
  [self filterWithKeyword:_searchBar.text];
  [_tableView reloadData];
}


@end
