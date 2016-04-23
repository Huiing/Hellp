//
//  JYBRefreshTableViewController.h
//  JianYunBao
//
//  Created by 冰点 on 16/3/10.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBBaseViewController.h"

@interface JYBRefreshTableViewController : JYBBaseViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) BDBaseTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic) BOOL showRefreshHeader;//是否支持下拉刷新
@property (nonatomic) BOOL showRefreshFooter;//是否支持上拉加载

- (instancetype)initWithStyle:(UITableViewStyle)style;

- (void)tableViewDidTriggerHeaderRefresh;//下拉刷新事件
- (void)tableViewDidTriggerFooterRefresh;//上拉加载事件

- (void)tableViewDidFinishTriggerHeader:(BOOL)isHeader reload:(BOOL)reload;
@end
