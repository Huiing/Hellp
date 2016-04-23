//
//  JYBDataSynchronizationVC.m
//  JianYunBao
//
//  Created by sks on 24/03/16.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBDataSynchronizationVC.h"
#import "SYWCommonRequest.h"
#import "JYBOrderItem.h"
#import "JYBSearchView.h"
#import "JYBSearchGroupView.h"
#import "JYBAnnouncementView.h"
#import "JYBSignInView.h"
#import "JYBOrderListCell.h"
#import "JYBQualityOrderListCell.h"
#import "JYBNoticeListCell.h"
#import "JYBSyncGroupCell.h"
#import "JYBGetGroupUserApi.h"
#import "JYBSignInTableViewCell.h"
#import "JYBSignInItem.h"
#import "JYBSelectFriendViewController.h"
#import "DatePickerHeadView.h"
#import "DatePickerView.h"
#import "JYBFriendItem.h"



@interface JYBDataSynchronizationVC ()<SuperNavBtnDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSString    *startDate;
    NSString    *endDate;
    NSArray     *dataSource;
    NSArray *netArray;
    
    JYBSearchView *view;
    JYBSearchGroupView *groupView;
    JYBAnnouncementView *announcementView;
    JYBSignInView *signInView;
    NSString    *type;
    NSString    *name;
    BOOL    allSel;
    NSString    *year;
    NSArray     *allData;
    UIButton    *selectBtn;
    DatePickerHeadView *headView;
    DatePickerView *pickerView;
    NSString        *date;
    NSString        *dateType;
    NSString    *senderId;
    UIView      *groupStyleView;
    
}


@property (nonatomic, strong) NSMutableDictionary *selectTagDic;

@end



@implementation JYBDataSynchronizationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNavgationBarButtonWithImageName:@"搜索查询" otherTitles:@"同步",@"全选", nil];
    netArray = @[@"WorkOrderList",@"QualityInspectList",@"SafetyInspectList",@"GroupList",@"NoticeList",@"SignList"];
    pickerView = [[DatePickerView alloc] initWithFrame:CGRectMake(0, Mheight - 250, Mwidth, 250)];
    headView = pickerView.headView;
    [headView addTarget:self cancelAction:@selector(cancle:)];
    [headView addTarget:self confirmAction:@selector(confirm:)];
    
    
    [self loadData];
    [self tableV];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SelctedFriendNotifiaction:) name:@"SelctedFriendNotifiaction" object:nil];
    
}

- (void)groupTypeView
{
    groupStyleView = [[UIView alloc] initWithFrame:CGRectMake(Mwidth-240, 60, 200, 250)];
    groupStyleView.backgroundColor = [UIColor whiteColor];
    NSArray *array = @[@"聊天群",@"专题讨论群"];
    for (int i= 0; i<2; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 44*i, groupView.bounds.size.width, 44);
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = [UIColor grayColor].CGColor;
        [btn addTarget:self action:@selector(groupType:) forControlEvents:UIControlEventTouchUpInside];
        [groupStyleView addSubview:btn];
    }
    groupStyleView.layer.borderColor = [UIColor blackColor].CGColor;
    groupStyleView.layer.borderWidth = 1;
    [self.view addSubview:groupStyleView];
}

- (void)groupType:(UIButton *)sender
{
    NSArray *array = @[@"聊天群",@"专题讨论群"];
    [selectBtn setTitle:array[sender.tag] forState:UIControlStateNormal];
    if (sender.tag==0)
    {
        type = @"0";
    }
    else
    {
        type = @"1";
    }
    [groupStyleView removeFromSuperview];
}
- (void)SelctedFriendNotifiaction:(NSNotification *)notification{
    JYBFriendItem * item = (JYBFriendItem*)notification.object;
    senderId = item.friendId;
    [selectBtn setTitle:item.name forState:UIControlStateNormal];
    
}
- (void)confirm:(UIButton *)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-CN"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
    date = pickerView.resultStr;
    if (date == nil) {
        date = dateStr;
    }
    if ([dateType isEqualToString:@"start"])
    {
        startDate = date;
        [selectBtn setTitle:date forState:UIControlStateNormal];
    }
    else if ([dateType isEqualToString:@"month"])
    {
        NSString *str = pickerView.resultStr;
        NSDate *dat = [dateFormatter dateFromString:str];
        
        [dateFormatter setDateFormat:@"yyyy-MM"];
        NSString *dateS= [dateFormatter stringFromDate:[NSDate date]];
        date = [dateFormatter stringFromDate:dat];
        if (date == nil) {
            date = dateS;
        }
        NSLog(@"777-------%@",date);
        [selectBtn setTitle:date forState:UIControlStateNormal];
    }
    else if ([dateType isEqualToString:@"year"])
    {
        NSString *str = pickerView.resultStr;
        NSDate *dat = [dateFormatter dateFromString:str];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy"];
        NSString *dateS = [formatter stringFromDate:[NSDate date]];
        year = [formatter stringFromDate:dat];
        if (year==nil)
        {
            year = dateS;
        }
        NSLog(@"44-----%@",year);
        [selectBtn setTitle:year forState:UIControlStateNormal];
    }
    else
    {
        endDate = date;
        [selectBtn setTitle:date forState:UIControlStateNormal];
    }
    
    
    pickerView.hidden = YES;
}
- (void)cancle:(UIButton *)sender
{
    pickerView.hidden = YES;
}

- (UITableView *)tableV
{
    if (!_tableV)
    {
        _tableV = [[UITableView alloc] init];
        _tableV.frame = CGRectMake(0, 0, Mwidth, Mheight);
        _tableV.delegate = self;
        _tableV.dataSource = self;
        [self.view addSubview:_tableV];
        return _tableV;
    }
    else
    {
        return nil;
    }
}

- (NSMutableDictionary *)selectTagDic
{
    if (!_selectTagDic) {
        _selectTagDic = [NSMutableDictionary dictionary];
    }
    return _selectTagDic;
}


- (void)navigationItemBtn:(UIButton *)btn clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        //查询按钮
        if (self.senderTag==3)
        {
            if (!groupView)
            {
                groupView = [[[NSBundle mainBundle] loadNibNamed:@"JYBSearchGroupView" owner:nil options:nil] lastObject];
                groupView.frame = CGRectMake(Mwidth-240, 60, 200, 250);
                
                groupView.clearBlock = ^{
                    dataSource = allData;
                    name = @"";
                    startDate = @"";
                    endDate = @"";
                    type = @"";
                    groupView.nameTextView.text = @"";
                    [groupView.startDateBtn setTitle:@"" forState:UIControlStateNormal];
                    [groupView.endDateBtn setTitle:@"" forState:UIControlStateNormal];
                    [groupView.styleBtn setTitle:@"" forState:UIControlStateNormal];
                    [_tableV reloadData];
                    [groupView removeFromSuperview];
                };
                groupView.searchBlock = ^{
                    name = groupView.nameTextView.text;
                    [self loadData];
                    [groupView removeFromSuperview];
                };
                groupView.startBlock = ^{
                    [self.view addSubview:pickerView];
                    selectBtn = groupView.startDateBtn;
                    dateType = @"start";
                    pickerView.hidden = NO;
                };
                groupView.endBlock = ^{
                    [self.view addSubview:pickerView];
                    selectBtn = groupView.endDateBtn;
                    dateType = @"end";
                    pickerView.hidden = NO;
                };
                groupView.styleBlock = ^{
                    [self groupTypeView];
                    selectBtn = groupView.styleBtn;
                    
                    
                };
            }
            [self.view addSubview:groupView];
        }
        else if (self.senderTag==4)
        {
            if (!announcementView)
            {
                announcementView = [[[NSBundle mainBundle] loadNibNamed:@"JYBAnnouncementView" owner:nil options:nil] lastObject];
                announcementView.frame = CGRectMake(Mwidth-240, 60, 200, 150);
                
                announcementView.monthBlock = ^{
                    [self.view addSubview:pickerView];
                    selectBtn = announcementView.monthBtn;
                    dateType = @"month";
                    pickerView.hidden = NO;
                };
                announcementView.clearchBlock = ^{
                    dataSource = allData;
                    announcementView.titleTextView.text = @"";
                    [announcementView.monthBtn setTitle:@"" forState:UIControlStateNormal];
                    [_tableV reloadData];
                    [announcementView removeFromSuperview];
                };
                announcementView.searchBlock = ^{
                    name = announcementView.titleTextView.text;
                    [self loadData];
                    [announcementView removeFromSuperview];
                };
                
            }
            [self.view addSubview:announcementView];
        }
        else if (self.senderTag==5)
        {
            if (!signInView)
            {
                signInView = [[[NSBundle mainBundle] loadNibNamed:@"JYBSignInView" owner:nil options:nil] lastObject];
                signInView.frame = CGRectMake(Mwidth-240, 60, 200, 100);
                signInView.yearBlock = ^{
                    selectBtn = signInView.yearBtn;
                    [self.view addSubview:pickerView];
                    dateType = @"year";
                    pickerView.hidden = NO;
                    signInView.clearBlock = ^{
                        dataSource = allData;
                        [signInView.yearBtn setTitle:@"" forState:UIControlStateNormal];
                        [_tableV reloadData];
                        [signInView removeFromSuperview];
                    };
                    signInView.searchBlock = ^{
                        [self loadData];
                        [signInView removeFromSuperview];
                    };
                };
            }
            [self.view addSubview:signInView];
            
        }
        else
        {
            if (!view)
            {
                view = [[[NSBundle mainBundle] loadNibNamed:@"JYBSearchView" owner:nil options:nil] lastObject];
                view.frame = CGRectMake(Mwidth-240, 60, 200, 300);
                view.clearBlock = ^{
                    
                    dataSource = allData;
                    view.titleTextView.text = @"";
                    name = @"";
                    startDate = @"";
                    endDate = @"";
                    type = @"";
                    [view.startDateButton setTitle:@"" forState:UIControlStateNormal];
                    [view.endDateButton setTitle:@"" forState:UIControlStateNormal];
                    [view.responsibleButton setTitle:@"" forState:UIControlStateNormal];
                    [view.creatButton setTitle:@"" forState:UIControlStateNormal];
                    [_tableV reloadData];
                    [view removeFromSuperview];
                };
                view.searchBlock = ^{
                    name = view.titleTextView.text;
                    [self loadData];
                    [view removeFromSuperview];
                };
                view.responsblePeopleBlock = ^{
                    selectBtn = view.responsibleButton;
                    JYBSelectFriendViewController *vc = [[JYBSelectFriendViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                };
                view.creatPeopleBlock = ^{
                    selectBtn = view.creatButton;
                    JYBSelectFriendViewController *vc= [[JYBSelectFriendViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                };
                view.startDateBlock = ^{
                    [self.view addSubview:pickerView];
                    selectBtn = view.startDateButton;
                    dateType = @"start";
                    pickerView.hidden = NO;
                    
                };
                view.endDateBlock = ^{
                    [self.view addSubview:pickerView];
                    selectBtn = view.endDateButton;
                    dateType = @"end";
                    pickerView.hidden = NO;
                };
            }
            [self.view addSubview:view];
        }
        
    }
    else if (buttonIndex==1)
    {
        //同步
        [view removeFromSuperview];
        [groupView removeFromSuperview];
        [announcementView removeFromSuperview];
        [signInView removeFromSuperview];
        
        
    }
    else
    {
        //全选
    }
}

- (void)loadData
{
    if (!type)
    {
        type = @"";
    }
    if (!name)
    {
        name = @"";
    }
    if (!startDate)
    {
        startDate = @"";
    }
    if (!endDate)
    {
        endDate = @"";
    }
    if (!year)
    {
        year = @"";
    }
    if (!date)
    {
        date = @"";
    }
    SYWCommonRequest *api = [[SYWCommonRequest alloc] init];
    NSString *userId = [RuntimeStatus sharedInstance].userItem.userId;
    NSString *str = [NSString stringWithFormat:@"/phone/%@!list.action",netArray[self.senderTag]];
    
    if (self.senderTag==4)
    {
        api.ReqURL = [NSString stringWithFormat:@"%@/phone/NoticeList!list.action",JYB_bcHttpUrl];
        api.ReqDictionary = @{@"enterpriseCode":JYB_enterpriseCode,
                              @"page":@(1),
                              @"title":name,
                              @"dt":date};
    }
    else if (self.senderTag==3)
    {
//        0为查询一般聊天群
//        1为查询专题讨论群
        api.ReqURL = JYBBCHttpUrl(str);
        api.ReqDictionary = @{@"userId":userId,
                              @"type":type,
                              @"name":name,
                              @"startDt":startDate,
                              @"endDt":endDate,
                              @"page":@1};
        
    }
    else if (self.senderTag==5)
    {
        api.ReqURL = [NSString stringWithFormat:@"%@/phone/SignList!list.action",JYB_bcHttpUrl];
        api.ReqDictionary =
        @{
          @"userId":JYB_userId,
          @"year":year};
    }
    else
    {
         api.ReqURL = JYBBCHttpUrl(str);
        api.ReqDictionary = @{@"userId":userId,
                              @"type":type,
                              @"name":name,
                              @"startDt":startDate,
                              @"endDt":endDate,
                              @"page":@1};
    }
   
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        DLogJSON(request.responseJSONObject);
        if (self.senderTag==0)
        {
            if (GoodResponse)
            {
                dataSource = [JYBOrderItem mj_objectArrayWithKeyValuesArray:APIJsonObject[@"list"]];
                NSLog(@"444-----%@",dataSource);
                [_tableV reloadData];
            }
            else
            {
                [self showHint:BadResponseMessage];
            }
        }
        else if (self.senderTag==1||self.senderTag==2)
        {
            if (GoodResponse)
            {
                dataSource = [JYBQualityOrderItem mj_objectArrayWithKeyValuesArray:APIJsonObject[@"list"]];
                [_tableV reloadData];
            }
            else
            {
                [self showHint:BadResponseMessage];
            }
        }
        else if (self.senderTag==3)
        {
            if (GoodResponse)
            {
                dataSource = [JYBSyncGroupModel mj_objectArrayWithKeyValuesArray:APIJsonObject[@"list"]];
                [self asyncLoadGroupUserWithGroups:dataSource];
                [_tableV reloadData];
            }
            else
            {
                [self showHint:BadResponseMessage];
            }
        }
        else if (self.senderTag==4)
        {
            if (GoodResponse)
            {
                dataSource = [JYBNoticeListItem mj_objectArrayWithKeyValuesArray:APIJsonObject[@"list"]];
                [_tableV reloadData];
            }
            else
            {
                [self showHint:BadResponseMessage];
            }
        }
        else
        {
            if (GoodResponse)
            {
                dataSource = [JYBSignInItem mj_objectArrayWithKeyValuesArray:APIJsonObject[@"list"]];
                [_tableV reloadData];
            }
        }
        allData = dataSource;
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
}
- (void)asyncLoadGroupUserWithGroups:(NSArray *)groups
{
    for (JYBSyncGroupModel *model in groups) {
        JYBGetGroupUserApi *groupUserApi = [[JYBGetGroupUserApi alloc] initWithGroupId:model.sid];
        [groupUserApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
            DLogJSON(request.responseJSONObject);
            if ([APIJsonObject[@"result"] boolValue] && ![APIJsonObject[@"deleted"] boolValue]) {
                model.userIds  = APIJsonObject[@"po"][@"userIds"];
            }
        } failure:^(__kindof YTKBaseRequest *request) {
            
        }];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.senderTag==0) {
        return 94;
    }
    else if (self.senderTag==1||self.senderTag==2)
    {
        return 115;
    }
    else if (self.senderTag==3||self.senderTag==4)
    {
        return 90;
    }
    else
    {
        return 44;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.senderTag==0)
    {
        JYBOrderListCell *cell = [JYBOrderListCell cellWithTableView:tableView indexPath:indexPath];
        JYBOrderItem *item = dataSource[indexPath.row];
        [cell setOrderItem:item];
        return cell;
    }
    else if (self.senderTag==1||self.senderTag==2)
    {
        JYBQualityOrderListCell *cell = [JYBQualityOrderListCell cellWithTableView:tableView indexPath:indexPath];
        JYBQualityOrderItem *item = dataSource[indexPath.row];
        cell.stateLabel.hidden = NO;
        cell.selectBtn.hidden = NO;
        [cell setQualityOrderItem:item];
        return cell;
    }
    else if (self.senderTag==3)
    {
        JYBSyncGroupCell *cell = [JYBSyncGroupCell cellWithTableView:tableView indexPath:indexPath];
        [cell setSyncGroupCellModel:dataSource[indexPath.row]];
        [cell setCheckBoxStatus:allSel];
        BOOL ret = [self.selectTagDic[@(indexPath.row)] boolValue];
        [cell setCheckBoxStatus:ret];
        return cell;
    }
    else if (self.senderTag==4)
    {
        JYBNoticeListCell *cell = [JYBNoticeListCell cellWithTableView:tableView indexPath:indexPath];
        JYBNoticeListItem *item = dataSource[indexPath.row];
        cell.stateLabel.hidden = NO;
        cell.selectBtn.hidden = NO;
        [cell setNoticeEntity:item];
        return cell;
    }
    else
    {
        JYBSignInItem *item = dataSource[indexPath.row];
        JYBSignInTableViewCell *cell = [JYBSignInTableViewCell cellWithTableView:tableView indexPath:indexPath];
        cell.timeLabel.text = item.createDate;
        cell.addressLabel.text = item.lable;
        return cell;
    }
//    else if (self.senderTag==1||self.senderTag==2){
//        JYBQualityOrderListCell *cell = [JYBQualityOrderListCell cellWithTableView:tableView indexPath:indexPath];
//        JYBQualityOrderItem *item = dataSource[indexPath.row];
//        [cell setQualityOrderItem:item];
//        return cell;
//    }
//   else
//   {
//       JYBOrderListCell *cell = [JYBOrderListCell cellWithTableView:tableView indexPath:indexPath];
//       JYBOrderItem *item = dataSource[indexPath.row];
//       [cell setOrderItem:item];
//       return cell;
//   }
    
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
