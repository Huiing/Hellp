//
//  JYBSafeOrderMainViewController.m
//  JianYunBao
//
//  Created by faith on 16/3/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBSafeOrderMainViewController.h"
#import "SelectView.h"
#import "JYBTaskCell.h"
#import "JYBLabelsViewCell.h"
#import "JYBToastView.h"
#import "JYBOrderInforTableViewCell.h"
#import "JYBFileTypeCell.h"
#import "JYBFileTypeView.h"
#import "JYBFileTypeCollectionView.h"
#import "SYWCommonRequest.h"
#import "JYBWorkCommunicationViewController.h"
#import "JYBSetStatusView.h"
#import "JYBSelectWayView.h"
#import "JYBSubTaskViewController.h"
#import "JYBOrderDetailItem.h"
#import "JYBSelectFriendViewController.h"
#import "JYBFileInforItem.h"
#import "IChatMessageToolBar.h"
#import "IChatAudioBubbleView.h"
#import "EMCDDeviceManager.h"
#import "EMAudioPlayerUtil.h"
#import <AVFoundation/AVFoundation.h>
#import "QRCodeGenerator.h"
#import "JYBSetOrderStatusView.h"
#import "JYBQualityOrderDetailItem.h"
#import "JYBSafeSubTaskViewController.h"
#import "JYBSafeTaskCell.h"
@interface JYBSafeOrderMainViewController ()<SelectIndexDelegate,UITableViewDataSource,UITableViewDelegate,ToastViewDelegate,SelectStatusViewDelegate,SelectOrderStatusViewDelegate>
{
    UITableView *_progressRepTable;
    UITableView *_showDetailTable;
    UITableView *_orderDetailTable;
    NSMutableArray *_nameArr;
    NSMutableArray *_contentArr;
    UIButton *_statusBtn;
    UIButton *_addTaskButton;
    JYBToastView *_toastView;
    JYBSetStatusView *_setstatusView;
    JYBSetOrderStatusView *_setOrderStatusView;
    JYBSelectWayView *_selectWayView;
    NSArray *_nameArray;
    NSArray *_contentArray;
    BOOL _isWillAdd;
    NSMutableArray *_images;
    NSMutableArray *_items;
    JYBFileTypeCollectionView *_collectionView;
    UIView *communicateView;
    NSMutableArray *nodeArray;
    NSString *nodeId;
    NSInteger selectStatus;
    NSInteger selectOrderStatus;
    NSMutableArray *usersIdsArray;
    NSArray *orderUserIdsArr;
    NSMutableArray *nameArr;
    NSMutableArray *iconArr;
    BOOL isAdd;
    NSMutableArray *iconArray;
    NSMutableArray *nameArray;
    NSMutableArray *photoArray;
    NSMutableArray *voiceArray;
    NSMutableArray *voiceDurationArray;
    NSMutableArray *videoArray;
    NSMutableArray *videoDurationArray;
    NSMutableArray *fileArray;
    JYBDownloadFileType fileType;
    AVAudioPlayer *player;
    NSMutableArray *executors;
    NSMutableArray *executorsArr;
    NSString *executor;
    NSInteger selectedIndex;
    NSMutableArray *countArr;
    int countAll;
    
}

@end

@implementation JYBSafeOrderMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    communicateView = [[UIView alloc] initWithFrame:CGRectMake(0,120, Mwidth, Mheight - 120)];
    communicateView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:communicateView];
    JYBWorkCommunicationViewController *vc = [[JYBWorkCommunicationViewController alloc] initWithChatter:self.safeOrderId type:JYBConversationTypeSingle];
    [communicateView addSubview:vc.view];
    SelectView *selectView = [[SelectView alloc] initWithFrame:CGRectMake(0, 66, Mwidth, 50)];
    selectView.titleArr = @[@"进度汇报",@"工作沟通",@"质量详情"];
    selectView.type = 1;
    selectView.delegate = self;
    [selectView initSubView];
    [self.view addSubview:selectView];
    
    _progressRepTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 130, Mwidth, Mheight - 60 - 130) style:UITableViewStylePlain];
    _progressRepTable.backgroundColor = RGB(240, 240, 240);
    _progressRepTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _progressRepTable.delegate = self;
    _progressRepTable.dataSource = self;
    _progressRepTable.tag = 0;
    _progressRepTable.hidden = YES;
    [self.view addSubview:_progressRepTable];
    [self configAddTaskButton];
    [self configData];
    
    _orderDetailTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 130, Mwidth, Mheight - 130) style:UITableViewStylePlain];
    _orderDetailTable.delegate = self;
    _orderDetailTable.dataSource = self;
    _orderDetailTable.tag = 2;
    _orderDetailTable.hidden = YES;
    _orderDetailTable.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_orderDetailTable];
    
    
    _showDetailTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 130, Mwidth, 88) style:UITableViewStylePlain];
    _showDetailTable.scrollEnabled = NO;
    _showDetailTable.delegate = self;
    _showDetailTable.dataSource = self;
    _showDetailTable.tag = 3;
    _showDetailTable.hidden = YES;
    [self.view addSubview:_showDetailTable];
    _statusBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_statusBtn setFrame:CGRectMake(120, _showDetailTable.bottom, Mwidth - 240, 20)];
    [_statusBtn setBackgroundColor:RGB(175, 175, 175)];
    _statusBtn.layer.cornerRadius = 5;
    _statusBtn.clipsToBounds = YES;
    [_statusBtn setTitle:@"当前状态:执行中" forState:UIControlStateNormal];
    [_statusBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _statusBtn.hidden = YES;
    [self.view addSubview:_statusBtn];
    [self loadData];
    [self checkUpdateOrder];
    
    
    [self getOrder];

    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SelctedFriendNotifiaction:) name:@"SelctedFriendNotifiaction" object:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)loadData
{
    nameArr = [NSMutableArray array];
    iconArr = [NSMutableArray array];
    nameArray = [NSMutableArray array];
    iconArray = [NSMutableArray array];
    photoArray = [NSMutableArray array];
    voiceArray = [NSMutableArray array];
    videoArray = [NSMutableArray array];
    fileArray = [NSMutableArray array];
    voiceDurationArray = [NSMutableArray array];
    videoDurationArray = [NSMutableArray array];
    executors = [NSMutableArray array];
    executorsArr = [NSMutableArray array];
    executor = [NSString string];
    selectedIndex = 1;
}

- (void)getOrder
{
    NSString *userId = [RuntimeStatus sharedInstance].userItem.userId;
    NSString *userName = [RuntimeStatus sharedInstance].userItem.userName;
    NSString *enterpriseCode = [RuntimeStatus sharedInstance].buildCloudEntity.enterpriseCode;
    SYWCommonRequest *api = [[SYWCommonRequest alloc] init];
    api.ReqURL = JYBBCHttpUrl(@"/phone/WorkOrder!get.action");
    api.ReqDictionary =
    @{
      @"userId":userId,
      @"po.id":@"394"
      };
    __weak typeof(self) weakSelf = self;
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        DLogJSON(request.responseJSONObject);
        if (GoodResponse) {
        }else{
            NSLog(@"fail:%@",BadResponseMessage);
            [self showHint:BadResponseMessage];
        }
        
    } failure:^(YTKBaseRequest *request) {
    }];
    
    
}
- (void)configData
{
    _nameArr = [NSMutableArray arrayWithObjects:@"任务名称:",@"执 行 人:", nil];
    _nameArray = @[@"标题",@"项目",@"责任人",@"问题类型",@"检查部位",@"任务状态",@"描述",@"发起人",@"创建日期",@"检查日期",@"整改日期",@"要求完成日期"];
    _items = [NSMutableArray arrayWithObjects:@"", nil];
    _images = [NSMutableArray arrayWithObjects:@"减少", nil];
    
}
- (void)configAddTaskButton
{
    _addTaskButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_addTaskButton setFrame:CGRectMake(11, Mheight - 60, Mwidth - 22, 40)];
    [_addTaskButton setTitle:@"添加子任务" forState:UIControlStateNormal];
    _addTaskButton.layer.cornerRadius = 5;
    _addTaskButton.clipsToBounds = YES;
    [_addTaskButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_addTaskButton setBackgroundColor:RGB(75, 190, 44)];
    [_addTaskButton addTarget:self action:@selector(addTaskAction) forControlEvents:UIControlEventTouchUpInside];
    _addTaskButton.hidden = YES;
    [self.view addSubview:_addTaskButton];
    
}
- (void)commulateAction
{
    communicateView.hidden = NO;
    _progressRepTable.hidden = YES;
    _addTaskButton.hidden = YES;
    _statusBtn.hidden = YES;
    _showDetailTable.hidden = YES;
    _orderDetailTable.hidden = YES;
    NSLog(@"commulateAction");
}
- (void)workSummaryAction
{
    [self addNavgationBarButtonWithImage:@"名称" addTarget:self action:@selector(commulateAction) direction:JYBNavigationBarButtonDirectionRight];
    _progressRepTable.hidden = NO;
    _addTaskButton.hidden = NO;
    communicateView.hidden = YES;
    _orderDetailTable.hidden = YES;
    _showDetailTable.hidden = YES;
    _statusBtn.hidden = YES;
    //  executorsArr = array;
    [_progressRepTable reloadData];
    //  [self getNodeData];
    //  [self checkUpdateOrder];
    //  [self getOrderDetail];
    //  [self addNode];
    NSLog(@"workSummaryAction");
}
- (void)checkUpdateOrder
{
    NSString *userId = [RuntimeStatus sharedInstance].userItem.userId;
    SYWCommonRequest *api = [[SYWCommonRequest alloc] init];
    api.ReqURL = JYBBCHttpUrl(@"/phone/SafetyInspectUpdate!update.action");
    api.ReqDictionary =
    @{
      @"userId":userId,
      @"orderId":self.safeOrderId,
      @"version":@"0",
      @"attachmentVersion":@"0",
      @"nodeVersion":@"0"
      };
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        DLogJSON(request.responseJSONObject);
        if (GoodResponse) {
            
            NSArray *attachments = [APIJsonObject[@"vo"] objectForKey:@"attachments"];
            NSArray *attachmentArr = [JYBFileInforItem mj_objectArrayWithKeyValuesArray:attachments];
            for(JYBFileInforItem *item in attachmentArr)
            {
                NSString *isPhoto = item.isPhoto;
                NSString *phonPath = item.isPhon;
                NSString *isVideo = item.isVideo;
                NSString *isFile = item.isFile;
                if([isPhoto isEqualToString:@"1"])
                {
                    NSURL *realPath = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BD_bcfHttpUrl,item.photoPath]];
                    [photoArray addObject:realPath];
                    
                }else if ([phonPath isEqualToString:@"1"])
                {
                    NSURL *realPath = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BD_bcfHttpUrl,item.phonPath]];
                    [voiceArray addObject:realPath];
                    NSString *timeString = [NSString stringWithFormat:@"%@s",item.phonDuration];
                    [voiceDurationArray addObject:timeString];
                    
                }else if ([isVideo isEqualToString:@"1"])
                {
                    NSURL *realPath = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BD_bcfHttpUrl,item.videoPath]];
                    [videoArray addObject:realPath];
                    [videoDurationArray addObject:item.videoDuration];
                }
                else if ([isFile isEqualToString:@"1"])
                {
                    NSURL *realPath = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BD_bcfHttpUrl,item.filePath]];
                    [fileArray addObject:realPath];
                }
            }
            
            NSDictionary *vo = [APIJsonObject[@"vo"] objectForKey:@"vo"];
            
            orderUserIdsArr = vo[@"userIds"];
            for(NSString *userId in orderUserIdsArr)
            {
                [self getInforWithUserId:userId];
            }
            NSDictionary *po = [vo objectForKey:@"po"];
            JYBQualityOrderDetailItem *item = [JYBQualityOrderDetailItem mj_objectWithKeyValues:po];
            if(!item.realEndDate)
            {
                item.realEndDate = @"";
            }
            if([item.workState isEqualToString:@"0"])
            {
                item.workState = @"执行中";
            }
            else if ([item.workState isEqualToString:@"1"])
            {
                item.workState = @"完成";
            }
            else if ([item.workState isEqualToString:@"3"])
            {
                item.workState = @"暂停";
            }
            else if ([item.workState isEqualToString:@"4"])
            {
                item.workState = @"取消";
            }
            if(!item.programType) item.programType = @"";
            if(!item.checkpoint) item.checkpoint = @"";
            if(!item.inspectDate) item.inspectDate = @"";
            if(!item.rectificationDate) item.rectificationDate = @"";
            if(!item.endDate) item.endDate = @"";
            _contentArray = @[item.titleName,item.projectName,item.responUser,item.programType,item.checkpoint,item.workState,item.worknote,item.createUserName,item.createDate,item.inspectDate,item.rectificationDate,item.endDate];
            //      [_showDetailTable reloadData];
            NSMutableArray *taskArray = [NSMutableArray array];
            NSMutableArray *userIdsArr = [NSMutableArray array];
            NSArray *nodes = [APIJsonObject[@"vo"] objectForKey:@"nodes"];
            if([nodes isKindOfClass:[NSNull class]]) return ;
            for(NSDictionary *node in nodes)
            {
                NSDictionary *nodeDic = [node objectForKey:@"po"];
                NSArray *userIds = [node objectForKey:@"userIds"];
                JYBSafeSubtaskItem *item = [JYBSafeSubtaskItem mj_objectWithKeyValues:nodeDic];
                [taskArray addObject:item];
                [userIdsArr addObject:userIds];
            }
            nodeArray = taskArray;
            usersIdsArray = userIdsArr;
            NSMutableArray *temp = [NSMutableArray array];
            for(int i = 0 ; i < usersIdsArray.count; i++)
            {
                NSArray *b = usersIdsArray[i];
                for(int j = 0 ; j < b.count ;j ++)
                {
                    NSString *userId = b[j];
                    [self getInforWithUserId2:userId];
                }
                //        [executorsArr addObject:executors];
                //        executors = [NSMutableArray array];
            }
            //      executorsArr = temp;
            //      [_progressRepTable reloadData];
            if(selectedIndex ==0)
            {
                //         [self workSummaryAction];
            }
            //      [self workSummaryAction];
            else if(selectedIndex ==2)
            {
                //        [self orderDetailAction];
            }
            else if (selectedIndex == 1)
            {
                
            }
            //      [self orderDetailAction];
            NSLog(@"+++2%@",nameArr);
        }
        else{
            NSLog(@"fail:%@",BadResponseMessage);
            [self showHint:BadResponseMessage];
        }
        
    } failure:^(YTKBaseRequest *request) {
        
        
    }];
    
}
//- (void)getOrderDetail
//{
//    NSString *userId = [RuntimeStatus sharedInstance].userItem.userId;
//    SYWCommonRequest *api = [[SYWCommonRequest alloc] init];
//    api.ReqURL = JYBBCHttpUrl(@"/phone/WorkOrder!get.action");
//    api.ReqDictionary =
//    @{
//      @"userId":userId,
//      @"po.id":self.orderId,
//      };
//    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
//        DLogJSON(request.responseJSONObject);
//        if (GoodResponse) {
//
//        }
//        else{
//            NSLog(@"fail:%@",BadResponseMessage);
//            [self showHint:BadResponseMessage];
//        }
//
//    } failure:^(YTKBaseRequest *request) {
//
//
//    }];
//
//}

- (void)orderDetailAction
{
    [self addNavgationBarButtonWithImage:@"更多" addTarget:self action:@selector(commulateAction) direction:JYBNavigationBarButtonDirectionRight];
    //  if(nameArr.count ==0)
    //  {
    //    for(NSString *userId in orderUserIdsArr)
    //    {
    //
    //      [self getInforWithUserId:userId type:0];
    //    }
    //  }
    [_orderDetailTable reloadData];
    _orderDetailTable.hidden = NO;
    communicateView.hidden = YES;
    _progressRepTable.hidden = YES;
    _addTaskButton.hidden = YES;
    _statusBtn.hidden = YES;
    _showDetailTable.hidden = YES;
    NSLog(@"orderDetailAction");
}
- (void)addTaskAction
{
    if(!_selectWayView)
    {
        _selectWayView = [[JYBSelectWayView alloc] initWithFrame:CGRectMake(0, 0, Mwidth, Mheight)];
    }
    _selectWayView.selectButtonBlock = ^(NSInteger tag){
        if(tag ==1)
        {
            
        }
        else{
            if(!_toastView)
            {
                _toastView = [[JYBToastView alloc] initWithFrame:CGRectMake(0, 0, Mwidth, Mheight)];
                _toastView.delegate = self;
            }
            [self.view addSubview:_toastView];
        }
    };
    [self.view addSubview:_selectWayView];
}
- (void)addNode
{
    SYWCommonRequest *api = [[SYWCommonRequest alloc] init];
    api.ReqURL = JYBBCHttpUrl(@"/phone/SafetyInspectNodeCreate!create.action");
    api.ReqDictionary =
    @{
      @"orderId":self.safeOrderId,
      @"number":_toastView.orderTextField.text,
      @"name":_toastView.taskTextField.text,
      @"note":_toastView.describeTextView.text
      };
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        DLogJSON(request.responseJSONObject);
        if (GoodResponse) {
            [self checkUpdateOrder];
        }
        else{
            NSLog(@"fail:%@",BadResponseMessage);
            [self showHint:BadResponseMessage];
        }
        
    } failure:^(YTKBaseRequest *request) {
        
        
    }];
    
}
- (void)getNodeData
{
    NSString *userId = [RuntimeStatus sharedInstance].userItem.userId;
    SYWCommonRequest *api = [[SYWCommonRequest alloc] init];
    api.ReqURL = JYBBCHttpUrl(@"/phone/SafetyInspectNode!get.action");
    api.ReqDictionary =
    @{
      @"po.orderId":self.safeOrderId,
      @"po.id":@"10"
      
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
#pragma mark - ToastViewDelegate
- (void)confirmAction
{
    [self addNode];
    [_toastView removeFromSuperview];
    [_selectWayView removeFromSuperview];
    [self checkUpdateOrder];
    [self workSummaryAction];
    //  [self checkUpdateOrder];
}
- (void)cancleAction
{
    [_toastView removeFromSuperview];
}
#pragma mark -SelectStatusViewDelegate
- (void)confirmStatusAction
{
    NSString *userId = [RuntimeStatus sharedInstance].userItem.userId;
    SYWCommonRequest *api = [[SYWCommonRequest alloc] init];
    api.ReqURL = JYBBCHttpUrl(@"/phone/SafetyInspectNodeState!state.action");
    api.ReqDictionary =
    @{
      @"userId":userId,
      @"orderId":self.safeOrderId,
      @"nodeId":nodeId,
      @"state":[NSNumber numberWithInteger:selectStatus]
      };
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        DLogJSON(request.responseJSONObject);
        if (GoodResponse) {
            [_setstatusView removeFromSuperview];
            [_progressRepTable reloadData];
        }
        else{
            NSLog(@"fail:%@",BadResponseMessage);
            [self showHint:BadResponseMessage];
        }
        
    } failure:^(YTKBaseRequest *request) {
    }];
    
}
- (void)cancleStatusAction
{
    [_setstatusView removeFromSuperview];
}
- (void)passStatus:(NSInteger)status
{
    selectStatus = status;
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
    api.ReqURL = JYBBCHttpUrl(@"/phone/SafetyInspect!state.action");
    api.ReqDictionary =
    @{
      @"userId":userId,
      @"po.id":self.safeOrderId,
      @"workState":[NSNumber numberWithInteger:selectOrderStatus]
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
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag ==0)
    {
        return nodeArray.count;
    }
    else if (tableView.tag ==2)
    {
        if(section ==0)
        {
            return 10;
        }
        else if(section ==1)
        {
            if(!_isWillAdd)
            {
                return 2;
            }
            else
            {
                return 3;
            }
        }
        else if (section ==2)
        {
            return 5;
        }
    }
    else if (tableView.tag ==3)
    {
        return _nameArr.count;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView.tag ==2)
    {
        return 3;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section ==0)
    {
        return 0;
    }else if(section ==1 || section ==2)
    {
        return 10;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    if(tableView.tag == 0)
    {
        JYBSafeTaskCell *cell = [JYBSafeTaskCell cellWithTableView:tableView indexPath:indexPath];
        cell.backgroundColor = RGB(240, 240, 240);
        JYBSafeSubtaskItem *item = nodeArray[indexPath.row];
        
        //    item.executors = executorsArr[indexPath.row];
        [cell setSafeSubtaskItem:item];
        if(row == 0)
        {
            [cell.topLine removeFromSuperview];
        }
        if(row == nodeArray.count -1)
        {
            [cell.bottomLine removeFromSuperview];
        }
        cell.statusImageBlock = ^{
            nodeId = item.safeSubTaskid;
            if(!_setstatusView)
            {
                _setstatusView = [[JYBSetStatusView alloc] initWithFrame:CGRectMake(0, 0, Mwidth, Mheight)];
                _setstatusView.delegate = self;
            }
            [self.view addSubview:_setstatusView];
            
        };
        cell.lookImageBlock = ^{
            JYBSafeSubTaskViewController *vc = [[JYBSafeSubTaskViewController alloc] init];
            vc.navigationTitle = @"工单子任务";
            vc.safeSubtaskItem = item;
            vc.userIdsArray = usersIdsArray[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
            
        };
        return cell;
        
    }
    else if (tableView.tag ==2)
    {
        if(section ==0)
        {
            JYBOrderInforTableViewCell *cell = [JYBOrderInforTableViewCell cellWithTableView:tableView indexPath:indexPath];
            cell.nameLbl.text = _nameArray[row];
            cell.contentLabl.text = _contentArray[row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        }
        else if(section == 1)
        {
            if(indexPath.row ==0)
            {
                JYBFileTypeCell *cell = [JYBFileTypeCell cellWithTableView:tableView indexPath:indexPath];
                if(!_isWillAdd)
                {
                    cell.handleImageView.image = [UIImage imageNamed:@"添加附件"];
                }
                else
                {
                    cell.handleImageView.image = [UIImage imageNamed:@"减少"];
                }
                cell.fileTypeBlock = ^(UIButton *sender,NSInteger index)
                {
                    NSLog(@"index:%ld %ld",(long)index,(long)sender.tag);
                    if(index ==154)
                    {
                        _isWillAdd = !_isWillAdd;
                        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
                        [_orderDetailTable reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];          }
                    else if(index ==150)
                    {
                        fileType = JYBDownloadFileTypeImage;
                        iconArray = photoArray;
                        nameArray = [NSMutableArray array];
                        for(int i = 0;i< iconArray.count ; i++)
                        {
                            [nameArray addObject:@""];
                        }
                        [_orderDetailTable reloadData];
                    }
                    else if (index ==151)
                    {
                        fileType = JYBDownloadFileTypeMP3;
                        
                        iconArray = voiceArray;
                        nameArray = voiceDurationArray;
                        [_orderDetailTable reloadData];
                    }
                    else if(index ==152)
                    {
                        fileType = JYBDownloadFileTypeMP4;
                        
                        iconArray = videoArray;
                        nameArray = videoDurationArray;
                        [_orderDetailTable reloadData];
                    }
                    else if(index == 153)
                    {
                        iconArray = fileArray;
                        nameArray = [NSMutableArray array];
                        for(int i = 0;i< iconArray.count ; i++)
                        {
                            [nameArray addObject:@""];
                        }
                        
                    }
                };
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
                
            }
            if(indexPath.row ==1)
            {
                if(!_isWillAdd)
                {
                    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
                    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
                    NSInteger count = iconArray.count/4 +1 ;
                    JYBFileTypeCollectionView *collectionView =[[JYBFileTypeCollectionView alloc] initWithFrame:CGRectMake(0, 0, Mwidth, Mwidth/4*count) collectionViewLayout:flowLayout];
                    collectionView.fileType = fileType;
                    collectionView.type = 1;
                    collectionView.nameArr = nameArray;
                    collectionView.imageArr = iconArray;
                    collectionView.substractBlock = ^{
                        
                    };
                    [cell.contentView addSubview:collectionView];
                    return cell;
                }
                else
                {
                    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                    JYBFileTypeView *typeView = [[JYBFileTypeView alloc] initWithFrame:CGRectMake(0, 0, Mwidth, Mwidth/4+10)];
                    typeView.itemBlock = ^(NSInteger index)
                    {
                        switch (index) {
                            case 0://拍照
                            {
                                [self showImagePickViewControllerWithSourceType:UIImagePickerControllerSourceTypeCamera isVideo:NO];
                            }
                                break;
                            case 1://图片
                            {
                                [self showImagePickViewControllerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary isVideo:NO];
                            }
                                break;
                            case 2://语音
                            {
                                IChatAudioBubbleView *toolBar = [[IChatAudioBubbleView alloc] initWithFrame:CGRectMake(100, 200, 200, 40)];
                                [self.view addSubview:toolBar];
                            }
                                break;
                            case 3://视频
                            {
                                [self showImagePickViewControllerWithSourceType:UIImagePickerControllerSourceTypeCamera isVideo:YES];
                            }
                                break;
                            case 4://文件
                            {
                                
                            }
                                break;
                                
                            default:
                                break;
                        }
                        //            [_images addObject:@"减少"];
                        //            [_items addObject:@"1"];
                        //            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
                        //            [_orderDetailTable reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                    };
                    [cell.contentView addSubview:typeView];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                    
                }
            }
            else if (indexPath.row ==2)
            {
                UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
                [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
                NSInteger count = iconArray.count/4 +1 ;
                JYBFileTypeCollectionView *collectionView =[[JYBFileTypeCollectionView alloc] initWithFrame:CGRectMake(0, 0, Mwidth, Mwidth/4*count) collectionViewLayout:flowLayout];
                collectionView.type =1;
                collectionView.fileType = fileType;
                collectionView.nameArr = nameArray;
                collectionView.imageArr = iconArray;
                collectionView.substractBlock = ^{
                    
                };
                [cell.contentView addSubview:collectionView];
                return cell;
                
            }
        }
        else
        {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            if(indexPath.row ==0)
            {
                UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 7, 30, 30)];
                icon.image = [UIImage imageNamed:@"相关人员"];
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 7, 80, 30)];
                label.text = @"相关人员";
                [cell.contentView addSubview:icon];
                [cell.contentView addSubview:label];
                return cell;
            }
            else if (indexPath.row ==1)
            {
                UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
                [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
                NSInteger count = (iconArr.count + 1)/4 +1 ;
                JYBFileTypeCollectionView *collectionView =[[JYBFileTypeCollectionView alloc] initWithFrame:CGRectMake(0, 0, Mwidth, Mwidth/4*count) collectionViewLayout:flowLayout];
                collectionView.addBlock = ^{
                    isAdd = YES;
                    
                    JYBSelectFriendViewController *vc = [[JYBSelectFriendViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                };
                collectionView.substractBlock = ^{
                    JYBSelectFriendViewController *vc = [[JYBSelectFriendViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                };
                collectionView.nameArr = nameArr;
                collectionView.imageArr = iconArr;
                [cell.contentView addSubview:collectionView];
                
            }
            else if (indexPath.row ==2)
            {
                UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 7, 30, 30)];
                icon.image = [UIImage imageNamed:@"二维码"];
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 7, 80, 30)];
                label.text = @"二维码";
                [cell.contentView addSubview:icon];
                [cell.contentView addSubview:label];
                
            }
            else if(indexPath.row ==3)
            {
                UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(Mwidth/2 - 60, 20, 120, 120)];
                icon.image = [QRCodeGenerator qrImageForString:[NSString stringWithFormat:@" jyb:2020:%@",self.safeOrderId] imageSize:icon.bounds.size.width];
                
                [cell.contentView addSubview:icon];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            else if (indexPath.row ==4)
            {
                UIButton *statusView = [[UIButton alloc] initWithFrame:CGRectMake(10,10, Mwidth - 20,40)];
                statusView.backgroundColor = RGB(50, 156, 229);
                UIImageView *statusImage = [[UIImageView alloc] initWithFrame:CGRectMake((Mwidth-20)/2-15, 5, 30, 30)];
                statusImage.image = [UIImage imageNamed:@"进行中1"];
                [statusView addSubview:statusImage];
                UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(Mwidth/2-15 -60, 5, 60, 30)];
                label1.text = @"当前状态";
                label1.font = [UIFont systemFontOfSize:13];
                label1.textColor = [UIColor whiteColor];
                [statusView addSubview:label1];
                UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(Mwidth/2+10, 5, 60, 30)];
                label2.textAlignment = NSTextAlignmentLeft;
                label2.text = [NSString stringWithFormat:@"[%@]",@"执行中"];
                label2.textColor = [UIColor whiteColor];
                label2.font = [UIFont systemFontOfSize:13];
                
                [statusView addSubview:label2];
                [statusView addTarget:self action:@selector(setOrderStatus:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:statusView];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    else if (tableView.tag ==3)
    {
        JYBLabelsViewCell *cell = [JYBLabelsViewCell cellWithTableView:tableView indexPath:indexPath];
        cell.nameLbl.text = _nameArr[row];
        //    cell.contentLbl.text = _contentArr[row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 0)
    {
        return 80;
    }
    
    else if (tableView.tag ==2)
    {
        if(indexPath.section ==0)
        {
            return 44;
        }
        if(indexPath.section ==1)
        {
            if(indexPath.row ==0)
            {
                return 44;
            }
            else if(indexPath.row ==1)
            {
                if(!_isWillAdd)
                {
                    
                    NSInteger count = iconArray.count/4 +1 ;
                    return Mwidth/4*count;
                }
                else
                {
                    
                    return Mwidth/4+20;
                }
            }
            else if(indexPath.row ==2)
            {
                NSInteger count = iconArray.count/4 +1 ;
                return Mwidth/4*count;
            }
        }
        else if (indexPath.section ==2)
        {
            if(indexPath.row ==0 || indexPath.row ==2)
            {
                return 44;
            }
            else if(indexPath.row ==1)
            {
                NSInteger count = (iconArr.count+ 1)/4 + 1;
                return Mwidth/4*count;
            }
            else if (indexPath.row ==3)
            {
                return 150;
            }
            else if (indexPath.row ==4)
            {
                return 60;
            }
        }
    }
    else if(tableView.tag ==3)
    {
        return 44;
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag ==0)
    {
        _showDetailTable.hidden = NO;
        _statusBtn.hidden = NO;
        _progressRepTable.hidden = YES;
    }
    if(tableView.tag ==3 && indexPath.row ==0)
    {
        [_nameArr addObjectsFromArray:[NSArray arrayWithObjects:@"创建时间:",@"备注:", nil]];
        [_contentArr addObjectsFromArray:[NSArray arrayWithObjects:@"2015-12",@"备注", nil]];
        [self reloadTable];
    }
}
- (void)setOrderStatus:(UIButton *)sender
{
    if(!_setOrderStatusView)
    {
        _setOrderStatusView = [[JYBSetOrderStatusView alloc] initWithFrame:CGRectMake(0, 0, Mwidth, Mheight)];
        _setOrderStatusView.delegate = self;
    }
    [self.view addSubview:_setOrderStatusView];
    
    
}
- (void)reloadTable
{
    _showDetailTable.height = _nameArr.count*44;
    _statusBtn.y = _showDetailTable.bottom;
    [_showDetailTable reloadData];
}

- (void)getInforWithUserId:(NSString *)userId {
    SYWCommonRequest *api = [[SYWCommonRequest alloc] init];
    api.ReqURL = JYBErpHttpUrl(@"jianyunbao.aspx");//[NSString stringWithFormat:@"%@/jianyunbao.aspx",self.config.erpHttpUrl];
    api.ReqDictionary =
    @{
      @"method":@"getUserInfo",
      @"enterpriseCode":[RuntimeStatus sharedInstance].buildCloudEntity.enterpriseCode,
      @"id":userId};
    __weak typeof(self) weakSelf = self;
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        DLogJSON(request.responseJSONObject);
        if (GoodResponse) {
            NSString *name = request.responseJSONObject[@"name"];
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",JYB_erpRootUrl,request.responseJSONObject[@"iconPaths"]]];
            countArr = [NSMutableArray array];
            countAll = 0;
            //      for(int i = 0; i < usersIdsArray.count ; i ++)
            //      {
            //
            //        NSArray *a= usersIdsArray[i];
            //        [countArr addObject:[NSNumber numberWithInteger:a.count]];
            //        for(int j = 0 ; j < a.count;j++)
            //        {
            //          countAll ++;
            //        }
            //      }
            if(name.length>0)
            {
                [nameArr addObject:name];
            }
            [iconArr addObject:url];
            NSLog(@"+++%@",nameArr);
            NSLog(@"---%@",executors);
        }else{
            [self showHint:BadResponseMessage];
        }
        
    } failure:^(YTKBaseRequest *request) {
    }];
}
- (void)getInforWithUserId2:(NSString *)userId {
    SYWCommonRequest *api = [[SYWCommonRequest alloc] init];
    api.ReqURL = JYBErpHttpUrl(@"jianyunbao.aspx");//[NSString stringWithFormat:@"%@/jianyunbao.aspx",self.config.erpHttpUrl];
    api.ReqDictionary =
    @{
      @"method":@"getUserInfo",
      @"enterpriseCode":[RuntimeStatus sharedInstance].buildCloudEntity.enterpriseCode,
      @"id":userId};
    __weak typeof(self) weakSelf = self;
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        DLogJSON(request.responseJSONObject);
        if (GoodResponse) {
            NSString *name = request.responseJSONObject[@"name"];
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",JYB_erpRootUrl,request.responseJSONObject[@"iconPaths"]]];
            countArr = [NSMutableArray array];
            countAll = 0;
            //      for(int i = 0; i < usersIdsArray.count ; i ++)
            //      {
            //
            //        NSArray *a= usersIdsArray[i];
            //        [countArr addObject:[NSNumber numberWithInteger:a.count]];
            //        for(int j = 0 ; j < a.count;j++)
            //        {
            //          countAll ++;
            //        }
            //      }
            if(name.length>0)
            {
                [executors addObject:name];
            }
            //      [iconArr addObject:url];
            NSLog(@"+++%@",nameArr);
            NSLog(@"---%@",executors);
        }else{
            [self showHint:BadResponseMessage];
        }
        
    } failure:^(YTKBaseRequest *request) {
    }];
}

- (void)SelctedFriendNotifiaction:(NSNotification *)notification
{
    SYWCommonRequest *api = [[SYWCommonRequest alloc] init];
    api.ReqURL = JYBBCHttpUrl(@"/phone/SafetyInspectUsers!addUsers.action");
    if(!isAdd)
    {
        api.ReqURL = JYBBCHttpUrl(@"/phone/SafetyInspectUsers!removeUsers.action");
    }
    api.ReqDictionary =
    @{
      @"orderId":self.safeOrderId,
      @"userIds":notification.object[0]
      };
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        DLogJSON(request.responseJSONObject);
        if (GoodResponse) {
            [self checkUpdateOrder];
            [self orderDetailAction];
            [self workSummaryAction];
        }
        else{
            NSLog(@"fail:%@",BadResponseMessage);
            //      [self showHint:BadResponseMessage];
        }
        
    } failure:^(YTKBaseRequest *request) {
        
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SelectIndexDelegate
- (void)didSelectedAtIndex:(NSInteger)index
{
    if(index == 0)
    {
        [self workSummaryAction];
    }
    else if(index == 1)
    {
        [self commulateAction];
    }
    else if(index == 2)
    {
        [self orderDetailAction];
    }
    NSLog(@"index:%ld",(long)index);
    selectedIndex = index;
}

- (void)showImagePickViewControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType isVideo:(BOOL)isVideo
{
    UIImagePickerController *controller = nil;
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            if ([self isAuthorCamera]) {
                controller = [[UIImagePickerController alloc] init];
                controller.sourceType = sourceType;
                if ([self isRearCameraAvailable]) {
                    controller.cameraDevice = UIImagePickerControllerCameraDeviceRear;
                    [self presentImagePickerController:controller isVideo:isVideo];
                }
            } else {
                NSString *msg = [NSString stringWithFormat:@"请在iPhone的\"设置-隐私-相机\"中允许访问相机"];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法使用相机" message:msg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                [alert show];
            }
        } else {
            NSString *msg = [NSString stringWithFormat:@"请检查iPhone的相机"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法使用相机" message:msg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alert show];
        }
    } else if (sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        if ([self isPhotoLibraryAvailable]) {
            if ([self isAuthorAssetsLibray]) {
                controller = [[UIImagePickerController alloc] init];
                controller.sourceType = sourceType;
                [self presentImagePickerController:controller isVideo:isVideo];
            } else {
                NSString *msg = [NSString stringWithFormat:@"请在iPhone的\"设置-隐私-照片\"中允许访问照片"];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法使用相册" message:msg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                [alert show];
            }
        } else {
            NSString *msg = [NSString stringWithFormat:@"请检查iPhone的相册"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法相册" message:msg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
}

- (void)presentImagePickerController:(UIImagePickerController *)picker isVideo:(BOOL)isVideo
{
    if (isVideo) {
        picker.mediaTypes = @[(__bridge NSString *)kUTTypeMovie];
        picker.videoQuality = UIImagePickerControllerQualityTypeLow;
        picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
        picker.videoMaximumDuration = 30;//录制视频最大时长30''
    } else {
        picker.mediaTypes = @[(__bridge NSString *)kUTTypeImage];
    }
    picker.allowsEditing = YES;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:NULL];
}



@end
