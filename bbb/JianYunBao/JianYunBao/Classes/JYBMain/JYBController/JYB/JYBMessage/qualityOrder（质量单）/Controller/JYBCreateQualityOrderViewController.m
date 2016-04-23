//
//  JYBCreateQualityOrderViewController.m
//  JianYunBao
//
//  Created by 宋亚伟 on 16/2/25.
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
#import "JYBSelectProgrameViewController.h"
@interface JYBCreateQualityOrderViewController ()<TouchTableDelegate>
{
    UIView *_toastView;
    NSString *_projectId;
    NSString *_proojectName;
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
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selctedNameNotifiaction:) name:@"SelctedNameNotifiaction" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selctedFriendNotifiaction:) name:@"SelctedFriendNotifiaction" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selctedTaskNotifiaction:) name:@"SelctedTaskNotifiaction" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selctedProgramNotifiaction:) name:@"SelctedProgramNotifiaction" object:nil];
    
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
    api.ReqURL = JYBBCHttpUrl(@"/phone/QualityInspect!create.action");
    api.ReqDictionary =
    @{
      @"userId":userId,
      @"po.enterpriseCode":enterpriseCode,
      @"po.titleName":dataArr[0],
      @"po.createUserId":userId,
      @"po.createUserName":userName,
      @"po.projectId":_projectId,
      @"po.projectName":_proojectName,
      @"po.importantState":@"",
      @"po.emergencyState":@"",
      @"po.responUserId":_responsiblerId,
      @"po.responUser":_responsibler,
//      @"po.workType":_typeCode,
      @"po.workState":@"0",
      @"po.worknote":dataArr[1],
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
- (NSArray *)getCellData
{
    JYBTextTableViewCell *titleCell = [_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    JYBTextTableViewCell *taskDescribeCell = [_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    NSString *titleStr = titleCell.textContentView.text;
    NSString *taskDescribeString = taskDescribeCell.textContentView.text;
    JYBLableTableViewCell *taskCell = [_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    JYBLableTableViewCell *inspectDateCell = [_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
    NSString *inspect = inspectDateCell.contentLabel.text;

    JYBLableTableViewCell *changeDateCell = [_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:0]];
    NSString *change = changeDateCell.contentLabel.text;

    JYBLableTableViewCell *endDateCell = [_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:8 inSection:0]];

    NSString *endDate = endDateCell.contentLabel.text;
    NSArray *arr = @[titleStr,taskDescribeString,inspect,change,endDate];
    return arr;
}

- (void)selctedNameNotifiaction:(NSNotification *)notification
{
    _proojectName = notification.object[0];
    _projectId = notification.object[1];
    _selectLableTableViewCell.contentLabel.text = _proojectName;
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

//MARK: UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 9;
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
            
            JYBSelectFriendViewController *vc = [[JYBSelectFriendViewController alloc] init];
            vc.navigationTitle = @"选择用户";
            [self.navigationController pushViewController:vc animated:YES];
        };

        return cell;
    }else if(indexPath.row == 3){
        JYBLableTableViewCell *cell = [JYBLableTableViewCell cellWithTableView:tableView indexPath:indexPath];
        cell.titleLabel.text = @"问题类型";
        cell.contentLabel.text = @"";
        cell.selectBlock = ^{
            _selectLableTableViewCell = cell;
            
            JYBSelectProgrameViewController *vc = [[JYBSelectProgrameViewController alloc] init];
            vc.navigationTitle = @"选择问题类型";
            [self.navigationController pushViewController:vc animated:YES];
        };

        return cell;
    }else if(indexPath.row == 4){
        JYBTextTableViewCell *cell = [JYBTextTableViewCell cellWithTableView:tableView indexPath:indexPath];
        cell.titleLabel.text = @"检查部位";
        
        return cell;
    }else if(indexPath.row == 5){
        JYBTextTableViewCell *cell = [JYBTextTableViewCell cellWithTableView:tableView indexPath:indexPath];
        cell.titleLabel.text = @"描述";
        
        return cell;
    }else if(indexPath.row == 6){
        JYBLableTableViewCell *cell = [JYBLableTableViewCell cellWithTableView:tableView indexPath:indexPath];
        cell.titleLabel.text = @"检查日期";
        cell.contentLabel.text = @"";
        _selectLableTableViewCell = cell;
        cell.selectBlock = ^{
            _selectLableTableViewCell = cell;
            [self showDatePick];
        };

        return cell;
    }else if(indexPath.row == 7){
        JYBLableTableViewCell *cell = [JYBLableTableViewCell cellWithTableView:tableView indexPath:indexPath];
        cell.titleLabel.text = @"整改日期";
        cell.contentLabel.text = @"";
        _selectLableTableViewCell = cell;
        cell.selectBlock = ^{
            _selectLableTableViewCell = cell;
            [self showDatePick];
        };

        return cell;
    }else{
        JYBLableTableViewCell *cell = [JYBLableTableViewCell cellWithTableView:tableView indexPath:indexPath];
        cell.titleLabel.text = @"完成日期";
        _selectLableTableViewCell = cell;
        cell.selectBlock = ^{
            _selectLableTableViewCell = cell;
            [self showDatePick];
        };

        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 5) {
        return 60;
    }
    return 44;
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
- (void)selctedProgramNotifiaction:(NSNotification *)notification
{
    _proojectName = notification.object[0];
    _projectId = notification.object[1];
    _selectLableTableViewCell.contentLabel.text = _proojectName;
}

@end
