//
//  JYBEditRelatedPersonViewController.m
//  JianYunBao
//
//  Created by faith on 16/3/27.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBEditRelatedPersonViewController.h"
#import "JYBFileTypeCollectionView.h"
#import "SYWCommonRequest.h"
@interface JYBEditRelatedPersonViewController ()
{
    JYBFileTypeCollectionView *collectionView;
    NSMutableArray *nameArr;
    NSMutableArray *iconArr;
}
@end

@implementation JYBEditRelatedPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    nameArr = [NSMutableArray array];
    iconArr = [NSMutableArray array];
    CGRect f = self.view.frame;
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    collectionView =[[JYBFileTypeCollectionView alloc] initWithFrame:CGRectMake(0, 100, Mwidth, Mwidth/6) collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor purpleColor];
    for(NSString *userId in _orderUserIdsArr)
    {
        [self getInforWithUserId:userId];
    }
    [self.view addSubview:collectionView];
//    collectionView.fileType = fileType;
//    collectionView.nameArr = nameArray;
//    collectionView.imageArr = iconArray;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)getInforWithUserId:(NSString *)userId {
    SYWCommonRequest *api = [[SYWCommonRequest alloc] init];
    api.ReqURL = JYBErpHttpUrl(@"jianyunbao.aspx");
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
                [nameArr addObject:name];
            }
            [iconArr addObject:url];
            if(iconArr.count == _orderUserIdsArr.count)
            {
//                NSInteger count = (iconArr.count + 2)/4 + 1;
//                collectionView.frame = CGRectMake(0, 100, Mwidth, 100+Mwidth/4*count);
            }
        
        }else{
            [self showHint:BadResponseMessage];
        }
        
    } failure:^(YTKBaseRequest *request) {
    }];
}


@end
