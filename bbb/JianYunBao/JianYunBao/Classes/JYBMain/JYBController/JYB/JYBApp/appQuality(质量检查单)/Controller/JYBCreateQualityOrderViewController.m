//
//  JYBCreateQualityOrderViewController.m
//  JianYunBao
//
//  Created by faith on 16/3/24.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBCreateQualityOrderViewController.h"
#import "JYBTextTableViewCell.h"
#import "JYBLableTableViewCell.h"
#import "SYWCommonRequest.h"
#import "JYBSelectItemViewController.h"
#import "JYBSelectFriendViewController.h"
#import "JYBSelectTaskViewController.h"
#import "DatePickerHeadView.h"
#import "DatePickerView.h"

@interface JYBCreateQualityOrderViewController ()<TouchTableDelegate>

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
@property (nonatomic ,strong)BDBaseTableView *tableview;
@property (nonatomic ,strong)JYBLableTableViewCell *selectLableTableViewCell;
@property (nonatomic, weak) UITextView *textContent;

@end

@implementation JYBCreateQualityOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  [self addNavgationBarButtonWithImage:nil title:@"保存" titleColor:[UIColor whiteColor] addTarget:self action:@selector(save) direction:JYBNavigationBarButtonDirectionRight];
  _tableview.scrollEnabled = NO;
  pickerView = [[DatePickerView alloc] initWithFrame:CGRectMake(0, Mheight - 250, Mwidth, 250)];
  headView = pickerView.headView;
  [headView addTarget:self confirmAction:@selector(confirm:)];
  [headView addTarget:self cancelAction:@selector(cancle:)];
  [self.view addSubview:pickerView];
  pickerView.hidden = YES;

    // Do any additional setup after loading the view from its nib.
}
- (void)save{
  NSArray *dataArr = [self getCellData];
  NSString *userId = [RuntimeStatus sharedInstance].userItem.userId;
  NSString *userName = [RuntimeStatus sharedInstance].userItem.userName;
  NSString *enterpriseCode = [RuntimeStatus sharedInstance].buildCloudEntity.enterpriseCode;
  DLog(@"保存 %@",self.textContent.text);
  SYWCommonRequest *api = [[SYWCommonRequest alloc] init];
  api.ReqURL = JYBBCHttpUrl(@"/phone/QualityInspect!create.action");
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
    cell.titleLabel.text = @"责任人";
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
    cell.titleLabel.text = @"问题类型";
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
    cell.titleLabel.text = @"检查部位";
    cell.selectBlock = ^{
      _selectLableTableViewCell = cell;
      
      JYBSelectFriendViewController *vc = [[JYBSelectFriendViewController alloc] init];
      vc.navigationTitle = @"选择用户";
      [self.navigationController pushViewController:vc animated:YES];
    };
    
    return cell;
  }else if(indexPath.row == 6){
    JYBLableTableViewCell *cell = [JYBLableTableViewCell cellWithTableView:tableView indexPath:indexPath];
    cell.titleLabel.text = @"检查日期";
    cell.selectBlock = ^{
      _selectLableTableViewCell = cell;
      JYBSelectTaskViewController *vc = [[JYBSelectTaskViewController alloc] init];
      vc.navigationTitle = @"选择任务来源";
      [self.navigationController pushViewController:vc animated:YES];
    };
    return cell;
  }else if(indexPath.row == 5){
    JYBTextTableViewCell *cell = [JYBTextTableViewCell cellWithTableView:tableView indexPath:indexPath];
    cell.titleLabel.text = @"描述";
    return cell;
  }if(indexPath.row == 7){
    JYBTextTableViewCell *cell = [JYBTextTableViewCell cellWithTableView:tableView indexPath:indexPath];
    cell.titleLabel.text = @"整改日期";
    return cell;
  }
  
  else{
    JYBLableTableViewCell *cell = [JYBLableTableViewCell cellWithTableView:tableView indexPath:indexPath];
    cell.titleLabel.text = @"完成日期";
    cell.selectBlock = ^{
      _selectLableTableViewCell = cell;
      [self showDatePick];
    };
    
    
    return cell;
  }
  
}

- (void)setTableview:(BDBaseTableView *)tableview{
  _tableview = tableview;
  tableview = [[BDBaseTableView alloc] initWithFrame:CGRectMake(0, 64, Mwidth, Mheight) style:UITableViewStylePlain];
  tableview.touchDelegate = self;
//  tableview.dataSource = self;
//  tableview.delegate = self;
  tableview.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
  [tableview hideSeparatorForNotDataSource];
  [self.view addSubview:tableview];
  
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
- (void)tableView:(UITableView *)tableView touchesBegin:(NSSet *)touches withEvent:(UIEvent *)event{
  [self.view endEditing:YES];
}


@end
