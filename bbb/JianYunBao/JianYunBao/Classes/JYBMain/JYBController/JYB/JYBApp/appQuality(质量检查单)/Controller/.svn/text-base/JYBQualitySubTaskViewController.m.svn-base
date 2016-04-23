//
//  JYBQualitySubTaskViewController.m
//  JianYunBao
//
//  Created by faith on 16/3/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBQualitySubTaskViewController.h"
#import "JYBFileTypeCollectionView.h"
#import "JYBTaskHeadView.h"
#import "SYWCommonRequest.h"
#import "UIImageView+WebCache.h"
#import "JYBSelectFriendViewController.h"
@interface JYBQualitySubTaskViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_images;
    NSMutableArray *_items;
    NSMutableArray *_iconArr;
    NSMutableArray *_nameArr;
    BOOL isSubstract;

}
@end

@implementation JYBQualitySubTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavgationBarButtonWithImage:nil title:@"保存" titleColor:[UIColor whiteColor] addTarget:self action:@selector(save) direction:JYBNavigationBarButtonDirectionRight];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SelctedFriendNotifiaction:) name:@"SelctedFriendNotifiaction" object:nil];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Mwidth, Mheight) style:UITableViewStylePlain];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = JYBBackgroundColor;
    _items = [NSMutableArray arrayWithObjects:@"",@"", nil];
    _images = [NSMutableArray arrayWithObjects:@"添加", @"减少",nil];
    JYBTaskHeadView *taskHeadView = [[[NSBundle mainBundle] loadNibNamed:@"JYBTaskHeadView" owner:nil options:nil] lastObject];
    taskHeadView.backgroundColor = JYBBackgroundColor;
    taskHeadView.numberTextField.text = _qualitySubtaskItem.number;
    taskHeadView.taskNameTextField.text = _qualitySubtaskItem.name;
    taskHeadView.describeTextField.text = _qualitySubtaskItem.note;
    _tableView.tableHeaderView = taskHeadView;
    UIView *statusView = [[UIView alloc] initWithFrame:CGRectMake(10,0, Mwidth - 20,40)];
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
    [self loadData];
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
    _iconArr = [NSMutableArray array];
    _nameArr = [NSMutableArray array];
    for(NSString *userId in self.userIdsArray)
    {
        [self getUser:userId];
        NSLog(@"++");
    }
}
- (void)getUser:(NSString *)userId{
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
            if(name.length>0)
            {
                [_nameArr addObject:name];
            }
            [_iconArr addObject:url];
            if(_nameArr.count == self.userIdsArray.count)
            {
                //        [_nameArr addObjectsFromArray:_items];
                //        [_iconArr addObjectsFromArray:_images];
                NSInteger count = (_nameArr.count +1)/4 +1 ;
                _tableView.height = Mheight ;
                [_tableView reloadData];
                
            }
            //      [_tableView reloadData];
            
            
        }else{
            [self showHint:BadResponseMessage];
        }
        
    } failure:^(YTKBaseRequest *request) {
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mwidth, 20)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 2, 15, 15)];
    imageView.image = [UIImage imageNamed:@"相关人员"];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 2, 100, 15)];
    label.text = @"执行人员";
    label.font = [UIFont systemFontOfSize:9];
    [view addSubview:imageView];
    [view addSubview:label];
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 19, Mwidth, 1)];
    line.backgroundColor = RGB(242, 242, 242);
    [view addSubview:line];
    view.backgroundColor = [UIColor whiteColor];
    return view;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //  if(indexPath.section ==0)
    //  {
    //    return 250;
    //  }
    //  NSInteger count = (_images.count-1)/4 + 1;
    //  return Mwidth/4*count;
    NSInteger count = (_images.count +1)/4 +1 ;
    
    return 180;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row ==0)
        
    {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        NSInteger count = (_images.count +1)/4 +1 ;
        JYBFileTypeCollectionView *collectionView =[[JYBFileTypeCollectionView alloc] initWithFrame:CGRectMake(0, 0, Mwidth, Mwidth/4*3) collectionViewLayout:flowLayout];
        collectionView.addBlock = ^{
            JYBSelectFriendViewController *vc = [[JYBSelectFriendViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        };
        collectionView.substractBlock = ^{
            isSubstract = YES;
            JYBSelectFriendViewController *vc = [[JYBSelectFriendViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        };
        collectionView.nameArr = _nameArr;
        collectionView.imageArr = _iconArr;
        [cell.contentView addSubview:collectionView];
        return cell;
        
    }
    return nil;
    
}
- (void)SelctedFriendNotifiaction:(NSNotification *)notification
{
    SYWCommonRequest *api = [[SYWCommonRequest alloc] init];
    api.ReqURL = JYBBCHttpUrl(@"/phone/QualityInspectNodeUsers!addUsers.action");
    if(isSubstract)
    {
        api.ReqURL = JYBBCHttpUrl(@"/phone/QualityInspectNodeUsers!removeUsers.action");
    }
    api.ReqDictionary =
    @{
      @"orderId":_qualitySubtaskItem.qualityId,
      @"nodeId":_qualitySubtaskItem.qualitySubTaskid,
      @"userIds":notification.object[0]
      };
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        DLogJSON(request.responseJSONObject);
        if (GoodResponse) {
            
        }
        else{
            NSLog(@"fail:%@",BadResponseMessage);
            //      [self showHint:BadResponseMessage];
        }
        
    } failure:^(YTKBaseRequest *request) {
        
        
    }];
    
}
- (void)deletAction:(UIButton *)sender
{
    
}
- (void)save
{
    
}
@end
