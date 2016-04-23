//
//  JYBCreateWorkOrderViewController.m
//  JianYunBao
//
//  Created by 宋亚伟 on 16/2/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBCreateWorkOrderViewController.h"
#import "JYBTextTableViewCell.h"
#import "JYBLableTableViewCell.h"
#import "SYWCommonRequest.h"
#import "JYBSelectItemViewController.h"
#import "JYBSelectFriendViewController.h"
#import "JYBSelectTaskViewController.h"
#import "DatePickerHeadView.h"
#import "DatePickerView.h"
#import "JYBFriendItem.h"
#import "JYBWorkOrderController.h"
#import "JYBAppWorkOrderViewController.h"
@interface JYBCreateWorkOrderViewController ()<TouchTableDelegate>
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
}
@property (weak, nonatomic) IBOutlet BDBaseTableView *tableview;
@property (nonatomic, weak) UITextView *textContent;
@property (nonatomic ,strong)JYBLableTableViewCell *selectLableTableViewCell;
@end

@implementation JYBCreateWorkOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (iOS7){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

    [self addNavgationBarButtonWithImage:nil title:@"保存" titleColor:[UIColor whiteColor] addTarget:self action:@selector(save) direction:JYBNavigationBarButtonDirectionRight];
  _tableview.scrollEnabled = NO;
  pickerView = [[DatePickerView alloc] initWithFrame:CGRectMake(0, Mheight - 250, Mwidth, 250)];
  headView = pickerView.headView;
  [headView addTarget:self confirmAction:@selector(confirm:)];
  [headView addTarget:self cancelAction:@selector(cancle:)];
  [self.view addSubview:pickerView];
  pickerView.hidden = YES;

  
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
  NSString *enterpriseCode = [RuntimeStatus sharedInstance].buildCloudEntity.enterpriseCode;DLog(@"保存 %@",self.textContent.text);
    if (!_projectId)
    {
        _projectId = @"";
    }
    if (!_projectName) {
        _projectName = @"";
        showMessage(@"项目不能为空");
        return;
    }
    if (!_responsiblerId) {
        _responsiblerId=@"";
    }
    if (!_responsibler) {
        _responsibler = @"";
        showMessage(@"责任人不能为空");
        return;
    }
    if (!_typeCode)
    {
        _typeCode = @"";
        showMessage(@"任务来源不能为空");
        return;
    }
    if ([dataArr[0] isEqualToString:@""])
    {
        showMessage(@"标题不能为空");
        return;
    }
    if ([dataArr[1] isEqualToString:@""])
    {
        showMessage(@"重要程度不能为空");
        return;
    }if ([dataArr[2] isEqualToString:@""]) {
        showMessage(@"紧急程度不能为空");
        return;
    }if ([dataArr[3] isEqualToString:@""]) {
        showMessage(@"任务描述不能为空");
        return;
    }if ([dataArr[4] isEqualToString:@""]) {
        showMessage(@"完成日期不能为空");
        return;
    }
  SYWCommonRequest *api = [[SYWCommonRequest alloc] init];
  api.ReqURL = JYBBCHttpUrl(@"/phone/WorkOrder!create.action");
  api.ReqDictionary =
  @{
    @"userId":userId,
    @"po.enterpriseCode":enterpriseCode,
    @"po.titleName":dataArr[0],
    @"po.createUserId":userId,
    @"po.createUserName":userName,
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
    [self showHudInView:self.view hint:@"加载中..."];
  [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
      
    DLogJSON(request.responseJSONObject);
    if (GoodResponse) {
        NSInteger count = self.navigationController.childViewControllers.count;
        JYBAppWorkOrderViewController *vc = self.navigationController.childViewControllers[count - 2];
        [vc reloadTableData];
        [self.navigationController popToViewController:vc animated:YES];
//      weakSelf.config = [JYBConfigItem mj_objectWithKeyValues:APIJsonObject];
//      [JYBConfigTool saveConfig:weakSelf.config];
//      [weakSelf toLogin];
        [self hideHud];
    }else{
      NSLog(@"fail:%@",BadResponseMessage);
      [self showHint:BadResponseMessage];
    }
    
  } failure:^(YTKBaseRequest *request) {
      
  }];

}
- (NSArray *)getCellData
{
  JYBTextTableViewCell *titleCell = [_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
  JYBTextTableViewCell *taskDescribeCell = [_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
  NSString *titleStr = titleCell.textContentView.text;
  NSString *taskDescribeString = taskDescribeCell.textContentView.text;
  JYBLableTableViewCell *importanceCell = [_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
  NSString *importance = importanceCell.contentLabel.text;
  if([importance isEqualToString:@"不重要"])
  {
    importance = @"0";
  }else
  {
    importance = @"1";
  }
  JYBLableTableViewCell *emergencyCell = [_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
  NSString *emergency = emergencyCell.contentLabel.text;
  if([emergency isEqualToString:@"不紧急"])
  {
    emergency = @"0";
  }
  else
  {
    emergency = @"1";
  }
  JYBLableTableViewCell *dateCell = [_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:0]];
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
    JYBFriendItem * item = (JYBFriendItem *)notification.object;
  _responsiblerId = item.friendId;
  _responsibler = item.name;
  _selectLableTableViewCell.contentLabel.text = _responsibler;
}
- (void)selctedTaskNotifiaction:(NSNotification *)notification
{
  _typeCode = notification.object[1];
  _taskName = notification.object[0];
  _selectLableTableViewCell.contentLabel.text = _taskName;
}
- (void)setTableview:(BDBaseTableView *)tableview{
    _tableview = tableview;
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
        return cell;
    }else if(indexPath.row == 1){
        JYBLableTableViewCell *cell = [JYBLableTableViewCell cellWithTableView:tableView indexPath:indexPath];
        cell.titleLabel.text = @"项目";
        cell.contentLabel.text = @"";
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
        cell.contentLabel.text = @"";
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
        cell.contentLabel.text = @"";
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
        return cell;
    }else{
        JYBLableTableViewCell *cell = [JYBLableTableViewCell cellWithTableView:tableView indexPath:indexPath];
        cell.titleLabel.text = @"完成日期";
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


@end
