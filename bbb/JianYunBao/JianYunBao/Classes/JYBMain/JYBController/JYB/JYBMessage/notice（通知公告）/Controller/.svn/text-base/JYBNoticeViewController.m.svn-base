//
//  JYBNoticeViewController.m
//  JianYunBao
//
//  Created by 宋亚伟 on 16/2/24.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBNoticeViewController.h"
#import "SYWCommonRequest.h"
#import "JYBNoticeListCell.h"
#import "JYBNoticeListItem.h"
#import "JYBNoticeDetailViewController.h"

@interface JYBNoticeViewController ()

@property (weak, nonatomic) IBOutlet BDBaseTableView *table;
@property (strong, nonatomic) NSArray * dataSource;

@end

@implementation JYBNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self requestNoticeList];
}
//查询通知公告列表
- (void)requestNoticeList{
    SYWCommonRequest *api = [[SYWCommonRequest alloc] init];
    api.ReqURL = [NSString stringWithFormat:@"%@/phone/NoticeList!list.action",JYB_bcHttpUrl];
    api.ReqDictionary = @{@"enterpriseCode":JYB_enterpriseCode,
                          @"page":@(1),
                          @"title":@"",
                          @"dt":@""};
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        if (GoodResponse) {
            self.dataSource = [JYBNoticeListItem mj_objectArrayWithKeyValuesArray:APIJsonObject[@"list"]];
            if(self.dataSource.count != 0){
                [self.table reloadData];
            }else{
                [self showHint:@"暂无数据！"];
            }
        }else{
            [self showHint:BadResponseMessage];
        }
        
    } failure:^(YTKBaseRequest *request) {
    }];
}
//隐藏没数据的分割线
- (void)setTable:(BDBaseTableView *)table
{
    _table = table;
    [table hideSeparatorForNotDataSource];
}
#pragma mark -- table delegate && datasource
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [JYBNoticeListCell heightForRow];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JYBNoticeListCell * noticeCell = [JYBNoticeListCell cellWithTableView:tableView indexPath:indexPath];
    JYBNoticeListItem * item = self.dataSource[indexPath.row];
    noticeCell.stateLabel.hidden = YES;
    noticeCell.selectBtn.hidden = YES;
    [(JYBNoticeListCell *)noticeCell setNoticeEntity:item];
    return noticeCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JYBNoticeListItem * item = self.dataSource[indexPath.row];
    JYBNoticeDetailViewController * ctr = [[JYBNoticeDetailViewController alloc] init];
    ctr.title = item.title;
    ctr.newsId = item.newsId;
    ctr.url = item.url;
    ctr.agreeCount = item.agreeCount;
    [ctr setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:ctr animated:YES];
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
