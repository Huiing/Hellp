//
//  JYBAppSafeViewController.m
//  JianYunBao
//
//  Created by 宋亚伟 on 16/2/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBAppSafeViewController.h"
#import "JYBCreateSafeOrderViewController.h"
#import "JYBSafeCalendarSearchViewController.h"
#import "SelectView.h"
#import "SYWCommonRequest.h"
#import "JYBSafeSubtaskItem.h"
#import "JYBQualityOrderListCell.h"
#import "JYBSafeOrderMainViewController.h"
@interface JYBAppSafeViewController ()<SelectIndexDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *dataSource;
    NSString *titleName;
    NSString *startDate;
    NSString *endDate;
    NSInteger type;
    NSInteger toastTpye;
}

@end

@implementation JYBAppSafeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavgationBarButtonWithImage1:@"日期查询" image2:@"搜索查询" image3:@"创建添加" addTarget:self action1:@selector(CalendarSearch) action2:@selector(addItem) action3:@selector(addItem) direction:JYBNavigationBarButtonDirectionRight];
    SelectView *selectView = [[SelectView alloc] initWithFrame:CGRectMake(0, 66, Mwidth, 50)];
    selectView.titleArr = @[@"创建的",@"参与的",@"主责的"];
    selectView.type = 1;
    selectView.delegate = self;
    [selectView initSubView];
    [self.view addSubview:selectView];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 116, Mwidth, 14)];
    view.backgroundColor= RGB(239, 239, 246);
    [self.view addSubview:view];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 130, Mwidth, Mheight - 130)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    [self getQualityOrdersWithTpye:@0];
}
- (void)didSelectedAtIndex:(NSInteger)index
{
    startDate = @"";
    endDate = @"";
    titleName = @"";
    type = index;
    NSLog(@"index:%ld",(long)index);
    NSInteger typeInt;
    if(index ==0)
    {
        typeInt = 2;
        toastTpye = 1;
    }
    else if(index ==1)
    {
        typeInt = 0;
        toastTpye = 0;
    }
    else
    {
        typeInt = 1;
        toastTpye = 2;
    }
    type = typeInt;
    NSNumber *typeNumber = [NSNumber numberWithInteger:typeInt];
    
    [self getQualityOrdersWithTpye:typeNumber];
    //  createUserName = @"";
    //  responUser = @"";
    //  startDate = @"";
    //  endDate = @"";
    //  titleName = @"";
    //  type = index;
    //  NSLog(@"index:%ld",(long)index);
    //  NSInteger typeInt;
    //  if(index ==0)
    //  {
    //    typeInt = 2;
    //    toastTpye = 1;
    //  }
    //  else if(index ==1)
    //  {
    //    typeInt = 0;
    //    toastTpye = 0;
    //  }
    //  else
    //  {
    //    typeInt = 1;
    //    toastTpye = 2;
    //  }
    //  type = typeInt;
    //  NSNumber *typeNumber = [NSNumber numberWithInteger:typeInt];
    //  [self getOrdersWithTpye:typeNumber];
}
#pragma mark - 网络请求
- (void)getQualityOrdersWithTpye:(NSNumber *)type1
{
    if(!titleName)
    {
        titleName = @"";
    }
    if(!startDate)
    {
        startDate = @"";
    }
    if(!endDate)
    {
        endDate = @"";
    }
    NSString *userId = [RuntimeStatus sharedInstance].userItem.userId;
    SYWCommonRequest *api = [[SYWCommonRequest alloc] init];
    api.ReqURL = JYBBCHttpUrl(@"/phone/SafetyInspectList!list.action");
    api.ReqDictionary =
    @{
      @"userId":userId,
      @"name":titleName,
      @"type":type1,
      @"page":@1,
      @"startDt":startDate,
      @"endDt":endDate};
    
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        DLogJSON(request.responseJSONObject);
        if (GoodResponse) {
            dataSource = [JYBQualityOrderItem mj_objectArrayWithKeyValuesArray:APIJsonObject[@"list"]];
            [_tableView reloadData];
        }else{
            NSLog(@"fail:%@",BadResponseMessage);
            [self showHint:BadResponseMessage];
        }
        
    } failure:^(YTKBaseRequest *request) {
    }];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYBQualityOrderListCell *cell = [JYBQualityOrderListCell cellWithTableView:tableView indexPath:indexPath];
    JYBQualityOrderItem *item = dataSource[indexPath.row];
    cell.stateLabel.hidden = YES;
    cell.selectBtn.hidden = YES;
    [cell setQualityOrderItem:item];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    JYBQualityOrderItem *item = dataSource[indexPath.row];
    NSString *qualityOrderId = item.qualityOrderId;
    JYBSafeOrderMainViewController *vc = [[JYBSafeOrderMainViewController alloc] init];
    vc.safeOrderId = qualityOrderId;
    vc.navigationTitle = item.titleName;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)CalendarSearch{
    JYBSafeCalendarSearchViewController *ctr = [[JYBSafeCalendarSearchViewController alloc] init];
    ctr.navigationTitle = @"主责安全检查单按日查询";
    [self.navigationController pushViewController:ctr animated:YES];
}

- (void)addItem{
    
    DLog(@"宋亚伟");
    JYBCreateSafeOrderViewController *ctr = [[JYBCreateSafeOrderViewController alloc] init];
    ctr.navigationTitle = @"创建安全检查单";
    [self.navigationController pushViewController:ctr animated:YES];
}
//返回扫描
- (void)backBarBtnItemClick{
    if(self.delegate && [self.delegate respondsToSelector:@selector(backContinue)]){
        [self.delegate backContinue];
    }
    [self.navigationController popViewControllerAnimated:YES];
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
