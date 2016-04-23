//
//  JYBAppWorkOrderViewController.m
//  JianYunBao
//
//  Created by 宋亚伟 on 16/2/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBAppWorkOrderViewController.h"
#import "JYBCreateWorkOrderViewController.h"
#import "JYBWorkOrderCalendarSearchViewController.h"
#import "SelectView.h"
#import "JYBOrderListCell.h"
#import "JYBPersonImplementViewController.h"
#import "SYWCommonRequest.h"
#import "JYBOrderItem.h"
#import "JYBQueryToastView.h"
#import "JYBQueryTwoToastView.h"
#import "JYBSelectFriendViewController.h"
#import "JYBSelectItemViewController.h"
#import "JYBOrderItemTool.h"
#import "JYBFriendItem.h"
#import "JYBOrderDetailItem.h"


@interface JYBAppWorkOrderViewController ()<SelectIndexDelegate,UITableViewDataSource,UITableViewDelegate>
{
  UITableView *_tableView;
  NSArray *dataSource;
  JYBQueryToastView *toast;
  JYBQueryTwoToastView *toastTwo;
  BOOL _hideToast;
  NSInteger toastTpye;
  UIButton *_selectButton;
  NSString *titleName;
  NSString *startDate;
  NSString *endDate;
  NSString *createUserName;
  NSString *responUser;
  NSInteger type;
  NSArray *allData;
    JYBOrderDetailItem *currentOrderDetail;

}

@end

@implementation JYBAppWorkOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (iOS7){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    SelectView *selectView = [[SelectView alloc] initWithFrame:CGRectMake(0, 0, Mwidth, 50)];
    selectView.titleArr = @[@"创建的",@"参与的",@"主责的"];
  selectView.type = 1;
    selectView.delegate = self;
  [selectView initSubView];
    [self.view addSubview:selectView];
    [self addNavgationBarButtonWithImage1:@"日期查询" image2:@"搜索查询" image3:@"创建添加" addTarget:self action1:@selector(CalendarSearch) action2:@selector(condictionSearch) action3:@selector(addItem) direction:JYBNavigationBarButtonDirectionRight];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 50, Mwidth, 14)];
    view.backgroundColor= RGB(239, 239, 246);
    [self.view addSubview:view];
  _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Mwidth, Mheight - 64 - 64)];
  _tableView.dataSource = self;
  _tableView.delegate = self;
  [self.view addSubview:_tableView];
  [self getOrdersWithTpye:@0];
  
  

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SelctedFriendNotifiaction:) name:@"SelctedFriendNotifiaction" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selctedNameNotifiaction:) name:@"SelctedNameNotifiaction" object:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 网络请求
- (void)getOrdersWithTpye:(NSNumber *)type1
{
  if(!createUserName)
  {
    createUserName = @"";
  }
  if(!responUser)
  {
    responUser = @"";
  }
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
  api.ReqURL = JYBBCHttpUrl(@"/phone/WorkOrderList!list.action");
  api.ReqDictionary =
  @{
    @"userId":userId,
    @"name":titleName,
    @"createUserName":createUserName,
    @"responUser":responUser,
    @"type":type1,
    @"page":@1,
    @"startDt":startDate,
    @"endDt":endDate

    
    };
  [self showHudInView:self.view hint:@"加载中..."];
  [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
    DLogJSON(request.responseJSONObject);
    if (GoodResponse) {
     dataSource = [JYBOrderItem mj_objectArrayWithKeyValuesArray:APIJsonObject[@"list"]];
        dataSource = [[dataSource reverseObjectEnumerator] allObjects];

      [_tableView reloadData];
        [self hideHud];
      if([titleName isEqualToString:@""] && [createUserName isEqualToString:@""] &&[responUser isEqualToString:@""]&& [startDate isEqualToString:@""] &&[endDate isEqualToString:@""])
      {
        allData = dataSource;
        for(JYBOrderItem *item in allData)
        {
          [JYBOrderItemTool addOrder:item];
        }
        
      }
    }else{
      NSLog(@"fail:%@",BadResponseMessage);
      [self showHint:BadResponseMessage];
    }
  } failure:^(YTKBaseRequest *request) {
  }];


}
- (void)condictionSearch
{
  if(toastTpye ==0)
  {
    toastTwo.hidden = YES;
    if(!toast)
    {
      toast = [[[NSBundle mainBundle] loadNibNamed:@"JYBQueryToastView" owner:nil options:nil] lastObject];
      toast.userInteractionEnabled = YES;
      
      [toast setFrame:CGRectMake(Mwidth - 240 -10, 20, 240, 420)];
      [self.view addSubview:toast];
    }
    toast.clearBlock = ^{
      toast.hidden = YES;
      _hideToast = !_hideToast;
      dataSource = allData;
      [_tableView reloadData];
      toast.hidden = YES;
    };
    toast.searchBlock = ^{
      titleName = toast.contentTextView.text;
      [self getOrdersWithTpye:[NSNumber numberWithInteger:type]];
      toast.hidden = YES;
      
    };
    toast.selectResponsiblerBlock = ^{
      _selectButton = toast.responsibleButton;
      JYBSelectFriendViewController *vc = [[JYBSelectFriendViewController alloc] init];
      [self.navigationController pushViewController:vc animated:YES];
    };
    toast.selectCreaterBlock = ^{
      _selectButton = toast.createButton;
      
      JYBSelectFriendViewController *vc = [[JYBSelectFriendViewController alloc] init];
      [self.navigationController pushViewController:vc animated:YES];
    };
    toast.selectProjectBlock = ^{
      JYBSelectItemViewController *vc = [[JYBSelectItemViewController alloc] init];
      [self.navigationController pushViewController:vc animated:YES];
    };
    
  }
  else
  {
    [toast removeFromSuperview];
    if(!toastTwo)
    {
      toastTwo = [[[NSBundle mainBundle] loadNibNamed:@"JYBQueryTwoToastView" owner:nil options:nil] lastObject];
      toastTwo.userInteractionEnabled = YES;
      
      [toastTwo setFrame:CGRectMake(Mwidth - 240 -10, 20, 240, 380)];
      [self.view addSubview:toastTwo];
    }
    toastTwo.typeLBL.text = @"负责人";
    if(toastTpye ==2)
    {
      toastTwo.typeLBL.text = @"创建人";
    }
    toastTwo.selectProjectBlock = ^{
       _selectButton = toastTwo.projectButton;
      JYBSelectItemViewController *vc = [[JYBSelectItemViewController alloc] init];
      [self.navigationController pushViewController:vc animated:YES];    };
    toastTwo.clearBlock = ^{
      toastTwo.hidden = YES;
      _hideToast = !_hideToast;
      dataSource = allData;
      [_tableView reloadData];
      toastTwo.hidden = YES;
    };
    toastTwo.searchBlock = ^{
      titleName = toastTwo.contentTextView.text;
      if(toastTpye ==1)
      {
        createUserName = @"";
        responUser = toastTwo.createButton.titleLabel.text;
      }
      else
      {
        createUserName = toastTwo.createButton.titleLabel.text;
        responUser = @"";
      }
      [self getOrdersWithTpye:[NSNumber numberWithInteger:type]];
      toastTwo.hidden = YES;
    };
    toastTwo.selectPeopleBlock = ^{
       _selectButton = toastTwo.createButton;
      JYBSelectFriendViewController *vc = [[JYBSelectFriendViewController alloc] init];
      [self.navigationController pushViewController:vc animated:YES];
    };
    
  }
  if(_hideToast)
  {
    toast.hidden = YES;
    toastTwo.hidden = YES;
  }
  else
  {
    toast.hidden = NO;
    toastTwo.hidden = NO;
  }
  _hideToast = !_hideToast;
}

- (void)addItem{
    
    DLog(@"宋亚伟");
    JYBCreateWorkOrderViewController *ctr = [[JYBCreateWorkOrderViewController alloc] init];
    ctr.navigationTitle = @"创建工单";
    [self.navigationController pushViewController:ctr animated:YES];
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
  return 94;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  JYBOrderListCell *cell = [JYBOrderListCell cellWithTableView:tableView indexPath:indexPath];
  JYBOrderItem *item = dataSource[indexPath.row];
    cell.stateLabel.hidden = YES;
    cell.selectBtn.hidden = YES;
  [cell setOrderItem:item];
  return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  JYBOrderItem *item = dataSource[indexPath.row];
  NSString *orderId = item.orderId;
  JYBPersonImplementViewController *vc = [[JYBPersonImplementViewController alloc] init];
  vc.orderId = orderId;
  vc.navigationTitle = item.titleName;
  [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - SelectIndexDelegate
- (void)didSelectedAtIndex:(NSInteger)index
{
  createUserName = @"";
  responUser = @"";
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
  [self getOrdersWithTpye:typeNumber];
}
- (void)CalendarSearch{
  JYBWorkOrderCalendarSearchViewController *ctr = [[JYBWorkOrderCalendarSearchViewController alloc] init];
  ctr.navigationTitle = @"主责工单按日查询";
  [self.navigationController pushViewController:ctr animated:YES];
}

- (void)SelctedFriendNotifiaction:(NSNotification *)notification
{
    JYBFriendItem * item = (JYBFriendItem *)notification.object;
  [_selectButton setTitle:item.userName forState:UIControlStateNormal];
}
- (void)selctedNameNotifiaction:(NSNotification *)notification
{
  if(toastTpye ==1  || toastTpye ==2)
  {
    [toastTwo.projectButton setTitle:notification.object[0] forState:UIControlStateNormal];
  }
  else
  {
     [toast.projectButton setTitle:notification.object[0] forState:UIControlStateNormal];
  }

}
- (void)reloadTableData
{
    NSNumber *typeNumber = [NSNumber numberWithInteger:type];
    [self getOrdersWithTpye:typeNumber];
}
@end
