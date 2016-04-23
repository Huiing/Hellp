//
//  JYBBaseCalendarViewController.m
//  JianYunBao
//
//  Created by 宋亚伟 on 16/3/10.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBWorkOrderCalendarSearchViewController.h"
#import "YHBaseCalendarView.h"
#import "YHBaseDateModel.h"
#import "SYWCommonRequest.h"
#import "JYBOrderItem.h"
#import "JYBOrderListCell.h"

@interface JYBWorkOrderCalendarSearchViewController ()<YHBaseCalendarViewDelegate,TouchTableDelegate>
{
    NSArray *dataSource;
}
@property (weak, nonatomic) IBOutlet UIView *dateView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) YHBaseCalendarView *calendarView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (nonatomic, strong) YHBaseDateModel *model;
@property (nonatomic, strong) NSMutableArray *markArray;
@property (weak, nonatomic) IBOutlet UIView *showNoDataView;
@property (weak, nonatomic) IBOutlet BDBaseTableView *table;

@end

@implementation JYBWorkOrderCalendarSearchViewController

- (NSMutableArray *)markArray{
    if (_markArray == nil) {
        _markArray = [NSMutableArray array];
    }
    for (int i = 0; i < 10; i++) {
        YHBaseDateModel *model = [[YHBaseDateModel alloc] init];
        model.year = @"2016";
        model.month = @"3";
        model.day = [NSString stringWithFormat:@"%d",i + 1];
        model.num = [NSString stringWithFormat:@"%d",i + 1];
        [_markArray addObject:model];
    }
    return _markArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    YHBaseCalendarView *view = [[YHBaseCalendarView alloc] initWithFrame:CGRectMake(5, 0 , Mwidth - 10 , (Mwidth - 10)/7*6)];
    view.userInteractionEnabled = YES;
    self.calendarView = view;
    view.currentDate = [NSDate date];
    
    view.delegate = self;
    [self.backView addSubview:view];
    view.markArray = self.markArray;
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormat stringFromDate:today];
    NSString *subString = [dateString substringWithRange:NSMakeRange(0, 7)];
    NSString *str = [subString stringByReplacingOccurrencesOfString:@"-" withString:@"年"];
    str = [NSString stringWithFormat:@"%@月",str];
    _dateLabel.text = str;
    [self getOrdersWithDateModel:dateString];
}
#pragma mark - 日历按钮点击和代理方法
- (IBAction)leftBtnClick:(id)sender {
    [self.calendarView scrollDate:YES];
}

- (IBAction)rightBtnClick:(id)sender {
    [self.calendarView scrollDate:NO];
}

-(void)YHBaseCalendarViewSelectAtDateModel:(YHBaseDateModel *)dateModel{
    
    NSLog(@"songyawei--------%@年%@月%@日",dateModel.year,dateModel.month,dateModel.day);
    NSString *monthString = dateModel.month;
    NSString *dayString = dateModel.day;
    if(monthString.length ==1)
    {
        monthString = [NSString stringWithFormat:@"0%@",monthString];
    }
    if(dayString.length ==1)
    {
        dayString = [NSString stringWithFormat:@"0%@",dayString];
    }

    NSString *dateString = [NSString stringWithFormat:@"%@-%@-%@",dateModel.year,monthString,dayString];
    [self getOrdersWithDateModel:dateString];
}

-(void)YHBaseCalendarViewScrollEndToDate:(YHBaseDateModel *)dateModel{
    NSLog(@"songyawei=========%@年%@月%@日",dateModel.year,dateModel.month,dateModel.day);
    self.dateLabel.text = [NSString stringWithFormat:@"%@年%@月",dateModel.year,dateModel.month];
}
- (void)getOrdersWithDateModel:(NSString *)dateString
{
    NSString *userId = [RuntimeStatus sharedInstance].userItem.userId;
    SYWCommonRequest *api = [[SYWCommonRequest alloc] init];
    api.ReqURL = JYBBCHttpUrl(@"/phone/WorkOrderList!list.action");
    api.ReqDictionary =
    @{
      @"userId":userId,
      @"type":@2,
      @"page":@1,
      @"startDt":dateString,
      @"endDt":dateString
      
      
      };
    [self showHudInView:self.view hint:@"加载中..."];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        DLogJSON(request.responseJSONObject);
        if (GoodResponse) {
            dataSource = [JYBOrderItem mj_objectArrayWithKeyValuesArray:APIJsonObject[@"list"]];
            dataSource = [[dataSource reverseObjectEnumerator] allObjects];
            if(dataSource.count ==0)
            {
                _table.hidden = YES;
            }
            else
            {
                _table.hidden = NO;
                [_table reloadData];
            }
            [self hideHud];
            
        }else{
            NSLog(@"fail:%@",BadResponseMessage);
            [self showHint:BadResponseMessage];
        }
    } failure:^(YTKBaseRequest *request) {
        
    }];
    
    
}


#pragma mark - tableview 相关
- (void)setTable:(BDBaseTableView *)table{
    _table = table;
//    table.hidden = YES;
    table.touchDelegate = self;
    table.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    [table hideSeparatorForNotDataSource];
}

//MARK: UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    JYBOrderListCell *cell = [JYBOrderListCell cellWithTableView:tableView indexPath:indexPath];
    JYBOrderItem *item = dataSource[indexPath.row];
    cell.stateLabel.hidden = YES;
    cell.selectBtn.hidden = YES;
    [cell setOrderItem:item];
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 94;
}

- (void)tableView:(UITableView *)tableView touchesBegin:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


@end
