//
//  JYBVEditWorkOrderViewController.m
//  JianYunBao
//
//  Created by faith on 16/3/27.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBVEditWorkOrderViewController.h"
#import "JYBTextTableViewCell.h"
#import "JYBLableTableViewCell.h"
#import "SYWCommonRequest.h"
#import "JYBSelectItemViewController.h"
#import "JYBSelectFriendViewController.h"
#import "JYBSelectTaskViewController.h"
#import "DatePickerHeadView.h"
#import "DatePickerView.h"
#import "JYBSetOrderStatusView.h"
#import "JYBOrderDetailItem.h"
@interface JYBVEditWorkOrderViewController ()<TouchTableDelegate,SelectOrderStatusViewDelegate>
{
    UIView *_toastView;
    NSString *_projectId;
    NSString *_projectName;
    NSString *_responsibler;
    NSString *_responsiblerId;
    NSString *_taskName;
    NSString *_typeCode;
    DatePickerHeadView *headView;
    DatePickerView *pickerView;
    JYBSetOrderStatusView *_setOrderStatusView;
    NSInteger selectOrderStatus;
    JYBOrderDetailItem *currentOrderDetail;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, weak) UITextView *textContent;
@property (nonatomic ,strong)JYBLableTableViewCell *selectLableTableViewCell;
@end

@implementation JYBVEditWorkOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavgationBarButtonWithImage:nil title:@"保存" titleColor:[UIColor whiteColor] addTarget:self action:@selector(save) direction:JYBNavigationBarButtonDirectionRight];
    _tableView.scrollEnabled = NO;
    pickerView = [[DatePickerView alloc] initWithFrame:CGRectMake(0, Mheight - 250, Mwidth, 250)];
    headView = pickerView.headView;
    [headView addTarget:self confirmAction:@selector(confirm:)];
    [headView addTarget:self cancelAction:@selector(cancle:)];
    [self.view addSubview:pickerView];
    pickerView.hidden = YES;
    
    UIButton *statusView = [[UIButton alloc] initWithFrame:CGRectMake(10,0, Mwidth - 20,40)];
    statusView.backgroundColor = RGB(50, 156, 229);
    UIImageView *statusImage = [[UIImageView alloc] initWithFrame:CGRectMake((Mwidth-20)/2-15, 5, 30, 30)];
    statusImage.image = [UIImage imageNamed:@"进行中1"];
   
    [statusView addSubview:statusImage];
    NSString *statusStr = @"执行中";
    if([_item.workState isEqualToString:@"完成"])
    {
        statusImage.image = [UIImage imageNamed:@"完成"];
        statusStr = @"完成";
    }
    else if ([_item.workState isEqualToString:@"暂停"])
    {
        statusImage.image = [UIImage imageNamed:@"暂停"];
        statusStr = @"暂停";

    }
    else if ([_item.workState isEqualToString:@"取消"])
    {
        statusImage.image = [UIImage imageNamed:@"取消"];
        statusStr = @"取消";
    }

    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(Mwidth/2-15 -60, 5, 60, 30)];
    label1.text = @"当前状态";
    label1.font = [UIFont systemFontOfSize:13];
    label1.textColor = [UIColor whiteColor];
    [statusView addSubview:label1];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(Mwidth/2+10, 5, 60, 30)];
    label2.textAlignment = NSTextAlignmentLeft;
    label2.text = [NSString stringWithFormat:@"[%@]",statusStr];
    label2.textColor = [UIColor whiteColor];
    label2.font = [UIFont systemFontOfSize:13];
    [statusView addTarget:self action:@selector(setOrderStatus:) forControlEvents:UIControlEventTouchUpInside];
    [statusView addSubview:label2];
    [self.view addSubview:statusView];
    
    UIButton *deletButton = [[UIButton alloc] initWithFrame:CGRectMake(10,64, Mwidth-20, 40)];
    [deletButton setTitle:@"删除" forState:UIControlStateNormal];
    [deletButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    deletButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [deletButton setBackgroundColor:RGB(50, 156, 229)];
    [deletButton addTarget:self action:@selector(deletAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deletButton];
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mwidth, 108)];
    [footView addSubview:statusView];
    [footView addSubview:deletButton];
    _tableView.tableFooterView = footView;

    
   
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //注册通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selctedNameNotifiaction:) name:@"SelctedNameNotifiaction" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selctedFriendNotifiaction:) name:@"SelctedFriendNotifiaction" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selctedTaskNotifiaction:) name:@"SelctedTaskNotifiaction" object:nil];

}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)save{
    NSArray *dataArr = [self getCellData];
    NSString *userId = [RuntimeStatus sharedInstance].userItem.userId;
    NSString *userName = [RuntimeStatus sharedInstance].userItem.userName;
    NSString *enterpriseCode = [RuntimeStatus sharedInstance].buildCloudEntity.enterpriseCode;
    DLog(@"保存 %@",self.textContent.text);
    SYWCommonRequest *api = [[SYWCommonRequest alloc] init];
    api.ReqURL = JYBBCHttpUrl(@"/phone/WorkOrder!edit.action");
    if(!_projectId) _projectId = _item.projectId;
    if(!_projectName) _projectName = _item.projectName;
    if(!_responsiblerId) _responsiblerId = _item.responUserId;
    if(!_responsibler) _responsibler = _item.responUser;
    if(!_typeCode) _typeCode = _item.workType;
    api.ReqDictionary =
    @{
      @"userId":userId,
      @"po.id":self.orderId,
      @"po.titleName":dataArr[0],
      @"po.projectId":_projectId,
      @"po.projectName":_projectName,
      @"po.importantState":dataArr[1],
      @"po.emergencyState":dataArr[2],
      @"po.responUserId":_responsiblerId,
      @"po.responUser":_responsibler,
      @"po.workType":_typeCode,
      @"po.workState":@"0",
      @"po.worknote":dataArr[3],
      @"po.endDate":dataArr[4]
      };
    __weak typeof(self) weakSelf = self;
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        DLogJSON(request.responseJSONObject);
        if (GoodResponse) {
            //      weakSelf.config = [JYBConfigItem mj_objectWithKeyValues:APIJsonObject];
            //      [JYBConfigTool saveConfig:weakSelf.config];
            //      [weakSelf toLogin];
        }else{
            NSLog(@"fail:%@",BadResponseMessage);
            [self showHint:BadResponseMessage];
        }
        
    } failure:^(YTKBaseRequest *request) {
    }];
    
}
#pragma mark - SelectOrderStatusViewDelegate
- (void)cancleOrderStatusAction
{
    [_setOrderStatusView removeFromSuperview];
}
- (void)confirmOrderStatusAction
{
    NSString *userId = [RuntimeStatus sharedInstance].userItem.userId;
    SYWCommonRequest *api = [[SYWCommonRequest alloc] init];
    api.ReqURL = JYBBCHttpUrl(@"/phone/WorkOrder!state.action");
    api.ReqDictionary =
    @{
      @"userId":userId,
      @"po.id":self.orderId,
      @"po.workState":[NSString stringWithFormat:@"%ld",(long)selectOrderStatus]
      };
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        DLogJSON(request.responseJSONObject);
        if (GoodResponse) {
            //      [_setstatusView removeFromSuperview];
            //      [_progressRepTable reloadData];
        }
        else{
            NSLog(@"fail:%@",BadResponseMessage);
            [self showHint:BadResponseMessage];
        }
        
    } failure:^(YTKBaseRequest *request) {
        
        
    }];
    
}
- (void)passOrderStatus:(NSInteger)status
{
    selectOrderStatus = status;
}

- (NSArray *)getCellData
{
    JYBTextTableViewCell *titleCell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    JYBTextTableViewCell *taskDescribeCell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
    NSString *titleStr = titleCell.textContentView.text;
    NSString *taskDescribeString = taskDescribeCell.textContentView.text;
    JYBLableTableViewCell *importanceCell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    NSString *importance = importanceCell.contentLabel.text;
    if([importance isEqualToString:@"不重要"])
    {
        importance = @"0";
    }else
    {
        importance = @"1";
    }
    JYBLableTableViewCell *emergencyCell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    NSString *emergency = emergencyCell.contentLabel.text;
    if([emergency isEqualToString:@"不紧急"])
    {
        emergency = @"0";
    }
    else
    {
        emergency = @"1";
    }
    JYBLableTableViewCell *dateCell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:0]];
    NSString *dateString = dateCell.contentLabel.text;
    NSArray *arr = @[titleStr,importance,emergency,taskDescribeString,dateString];
    return arr;
}

- (void)selctedNameNotifiaction:(NSNotification *)notification
{
    _projectName = notification.object[0];
    _projectId = notification.object[1];
    _selectLableTableViewCell.contentLabel.text = _projectName;
}
- (void)selctedFriendNotifiaction:(NSNotification *)notification
{
    _responsiblerId = notification.object[0];
    _responsibler = notification.object[1];
    _selectLableTableViewCell.contentLabel.text = _responsibler;
}
- (void)selctedTaskNotifiaction:(NSNotification *)notification
{
    _typeCode = notification.object[1];
    _taskName = notification.object[0];
    _selectLableTableViewCell.contentLabel.text = _taskName;
}
- (void)setTableview:(BDBaseTableView *)tableview{
    _tableView = tableview;
    tableview.touchDelegate = self;
    tableview.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    [tableview hideSeparatorForNotDataSource];
    
}

//MARK: UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    if (indexPath.row == 0) {
        JYBTextTableViewCell *cell = [JYBTextTableViewCell cellWithTableView:tableView indexPath:indexPath];
        cell.titleLabel.text = @"标题";
        self.textContent = cell.textContentView;
        cell.textContentView.text = _item.titleName;
        return cell;
    }else if(indexPath.row == 1){
        JYBLableTableViewCell *cell = [JYBLableTableViewCell cellWithTableView:tableView indexPath:indexPath];
        cell.titleLabel.text = @"项目";
        cell.contentLabel.text = _item.projectName;
        cell.selectBlock = ^{
            _selectLableTableViewCell = cell;
            JYBSelectItemViewController *vc = [[JYBSelectItemViewController alloc] init];
            vc.navigationTitle = @"选择项目";
            [self.navigationController pushViewController:vc animated:YES];
        };
        
        return cell;
    }else if(indexPath.row == 2){
        JYBLableTableViewCell *cell = [JYBLableTableViewCell cellWithTableView:tableView indexPath:indexPath];
        cell.titleLabel.text = @"重要程度";
        cell.contentLabel.text = _item.importantState;
        cell.selectBlock = ^{
            _selectLableTableViewCell = cell;
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(86, cell.bottom +61, 200, 88)];
            view.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:view];
            UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
            [btn1 setTitle:@"重要" forState:UIControlStateNormal];
            [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn1.tag = 1;
            [btn1 addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:btn1];
            UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 44, 200, 44)];
            btn2.tag = 2;
            [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn2 setTitle:@"不重要" forState:UIControlStateNormal];
            [btn2 addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:btn2];
            _toastView = view;
        };
        return cell;
    }else if(indexPath.row == 3){
        JYBLableTableViewCell *cell = [JYBLableTableViewCell cellWithTableView:tableView indexPath:indexPath];
        cell.titleLabel.text = @"紧急程度";
        cell.contentLabel.text = _item.emergencyState;
        cell.selectBlock = ^{
            _selectLableTableViewCell = cell;
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(86, cell.bottom +61, 200, 88)];
            view.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:view];
            UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
            [btn1 setTitle:@"紧急" forState:UIControlStateNormal];
            [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn1.tag = 3;
            [btn1 addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:btn1];
            UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 44, 200, 44)];
            btn2.tag = 4;
            [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn2 setTitle:@"不紧急" forState:UIControlStateNormal];
            [btn2 addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:btn2];
            _toastView = view;
        };
        
        return cell;
    }else if(indexPath.row == 4){
        JYBLableTableViewCell *cell = [JYBLableTableViewCell cellWithTableView:tableView indexPath:indexPath];
        cell.titleLabel.text = @"责任人";
        cell.contentLabel.text = _item.responUser;
        cell.selectBlock = ^{
            _selectLableTableViewCell = cell;
            
            JYBSelectFriendViewController *vc = [[JYBSelectFriendViewController alloc] init];
            vc.navigationTitle = @"选择用户";
            [self.navigationController pushViewController:vc animated:YES];
        };
        
        return cell;
    }else if(indexPath.row == 5){
        JYBLableTableViewCell *cell = [JYBLableTableViewCell cellWithTableView:tableView indexPath:indexPath];
        cell.titleLabel.text = @"任务来源";
        cell.contentLabel.text = _item.workType;
        cell.selectBlock = ^{
            _selectLableTableViewCell = cell;
            JYBSelectTaskViewController *vc = [[JYBSelectTaskViewController alloc] init];
            vc.navigationTitle = @"选择任务来源";
            [self.navigationController pushViewController:vc animated:YES];
        };
        return cell;
    }else if(indexPath.row == 6){
        JYBTextTableViewCell *cell = [JYBTextTableViewCell cellWithTableView:tableView indexPath:indexPath];
        cell.titleLabel.text = @"任务描述";
        cell.textContentView.text = _item.worknote;
        return cell;
    }else{
        JYBLableTableViewCell *cell = [JYBLableTableViewCell cellWithTableView:tableView indexPath:indexPath];
        cell.titleLabel.text = @"完成日期";
        cell.contentLabel.text = _item.realEndDate;
        cell.selectBlock = ^{
            _selectLableTableViewCell = cell;
            [self showDatePick];
        };
        
        
        return cell;
    }
    
}
- (void)selectAction:(UIButton *)sender
{
    if(sender.tag ==1)
    {
        _selectLableTableViewCell.contentLabel.text = @"重要";
    }
    else if(sender.tag ==2)
    {
        _selectLableTableViewCell.contentLabel.text = @"不重要";
    }
    else if (sender.tag ==3)
    {
        _selectLableTableViewCell.contentLabel.text = @"紧急";
        
    }
    else
    {
        _selectLableTableViewCell.contentLabel.text = @"不紧急";
    }
    [_toastView removeFromSuperview];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 6) {
        return 60;
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"ppppindex:%ld",(long)indexPath.row);
}
- (void)tableView:(UITableView *)tableView touchesBegin:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)confirm:(UIButton *)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-CN"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
    NSString *r = pickerView.resultStr;
    if (r == nil) {
        r = dateStr;
    }
    _selectLableTableViewCell.contentLabel.text = r;
    pickerView.hidden = YES;
}
- (void)cancle:(UIButton *)sender {
    pickerView.hidden = YES;
}
// 显示DatePick
- (void)showDatePick {
    pickerView.hidden = NO;
    [pickerView bringSubviewToFront:pickerView.headView];
    [pickerView bringSubviewToFront:pickerView.datePickerView];
    [self.view bringSubviewToFront:pickerView];
    
}
- (void)setOrderStatus:(UIButton *)sender
{
    if(!_setOrderStatusView)
    {
        _setOrderStatusView = [[JYBSetOrderStatusView alloc] initWithFrame:CGRectMake(0, 0, Mwidth, Mheight)];
    }
    _setOrderStatusView.delegate = self;
    [self.view addSubview:_setOrderStatusView];
    
    
}
- (void)deletAction:(UIButton *)sender
{
    NSString *userId = [RuntimeStatus sharedInstance].userItem.userId;
    SYWCommonRequest *api = [[SYWCommonRequest alloc] init];
    api.ReqURL = JYBBCHttpUrl(@"/phone/WorkOrder!delete.action");
    api.ReqDictionary =
    @{
      @"userId":userId,
      @"po.id":self.orderId
      };
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        DLogJSON(request.responseJSONObject);
        if (GoodResponse) {
    
        }
        else{
            NSLog(@"fail:%@",BadResponseMessage);
            [self showHint:BadResponseMessage];
        }
        
    } failure:^(YTKBaseRequest *request) {
        
        
    }];
}


@end
