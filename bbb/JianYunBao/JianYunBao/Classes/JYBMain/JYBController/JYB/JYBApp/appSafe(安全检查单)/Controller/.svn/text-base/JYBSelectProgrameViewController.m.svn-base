//
//  JYBSelectProgrameViewController.m
//  JianYunBao
//
//  Created by faith on 16/3/24.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBSelectProgrameViewController.h"
#import "SYWCommonRequest.h"
#import "JYBQualityProgrameItem.h"
@interface JYBSelectProgrameViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UISearchBar *_searchBar;
    NSMutableArray *_nameArr;
    UITableView *_tableView;
    NSArray *_programItems;
    NSInteger selectedIndex;
}


@end

@implementation JYBSelectProgrameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _nameArr = [NSMutableArray array];
    _programItems = [NSMutableArray array];
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

    // Do any additional setup after loading the view from its nib.
}
- (void)loadData
{
    NSString *enterpriseCode = [RuntimeStatus sharedInstance].buildCloudEntity.enterpriseCode;
    SYWCommonRequest *api = [[SYWCommonRequest alloc] init];
    api.ReqURL = JYBBCHttpUrl(@"/phone/SysAttr!someQualityType.action");
    api.ReqDictionary =
    @{
      @"enterpriseCode":enterpriseCode};
    //  __weak typeof(self) weakSelf = self;
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        DLogJSON(request.responseJSONObject);
        if (GoodResponse) {
            _programItems = [JYBQualityProgrameItem mj_objectArrayWithKeyValuesArray:APIJsonObject[@"list"]];
            for(JYBQualityProgrameItem *item in _programItems)
            {
                NSString *name = item.typeName;
                [_nameArr addObject:name];
            }
            [_tableView reloadData];
        }else{
            [self showHint:BadResponseMessage];
        }
        
    } failure:^(YTKBaseRequest *request) {
    }];
    
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
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定选择该问题类型" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    selectedIndex = indexPath.row;
}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex ==0)
    {
        return;
    }
    else
    {
        NSArray *rows = [self filterWithKeyword:_searchBar.text];
        NSString *name = rows[selectedIndex];
        NSString *typeCode;
        for(JYBQualityProgrameItem *item in _programItems)
        {
            if([item.typeName isEqualToString:name])
            {
                typeCode = item.typeCode;
            }
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SelctedProgramNotifiaction" object:@[name,typeCode] userInfo:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark - UISearchBar
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self filterWithKeyword:_searchBar.text];
    [_tableView reloadData];
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
