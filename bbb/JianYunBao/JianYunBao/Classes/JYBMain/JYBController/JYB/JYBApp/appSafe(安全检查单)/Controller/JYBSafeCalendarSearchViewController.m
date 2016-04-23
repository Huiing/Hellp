//
//  JYBBaseCalendarViewController.m
//  JianYunBao
//
//  Created by 宋亚伟 on 16/3/10.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBSafeCalendarSearchViewController.h"
#import "YHBaseCalendarView.h"
#import "YHBaseDateModel.h"

@interface JYBSafeCalendarSearchViewController ()<YHBaseCalendarViewDelegate,TouchTableDelegate>

@property (weak, nonatomic) IBOutlet UIView *dateView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) YHBaseCalendarView *calendarView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (nonatomic, strong) YHBaseDateModel *model;
@property (nonatomic, strong) NSMutableArray *markArray;
@property (weak, nonatomic) IBOutlet UIView *showNoDataView;
@property (weak, nonatomic) IBOutlet BDBaseTableView *table;

@end

@implementation JYBSafeCalendarSearchViewController

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
}

-(void)YHBaseCalendarViewScrollEndToDate:(YHBaseDateModel *)dateModel{
    NSLog(@"songyawei=========%@年%@月%@日",dateModel.year,dateModel.month,dateModel.day);
    self.dateLabel.text = [NSString stringWithFormat:@"%@年%@月",dateModel.year,dateModel.month];
}

#pragma mark - tableview 相关
- (void)setTable:(BDBaseTableView *)table{
    _table = table;
    table.hidden = YES;
    table.touchDelegate = self;
    table.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    [table hideSeparatorForNotDataSource];
}

//MARK: UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView touchesBegin:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


@end
