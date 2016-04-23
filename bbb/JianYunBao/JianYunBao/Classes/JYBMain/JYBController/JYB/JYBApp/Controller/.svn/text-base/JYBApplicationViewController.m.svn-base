//
//  JYBApplicationViewController.m
//  JianYunBao
//
//  Created by 冰点 on 16/1/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBApplicationViewController.h"
#import "JYBAppWorkOrderViewController.h"
#import "JYBAppSignInViewController.h"
#import "JYBAppSafeViewController.h"
#import "JYBAppQualityViewController.h"
#import "JYBAppProwledViewController.h"
#import "JYBAppApplicationViewController.h"
#import "JYBAppCell.h"
#import "JYBAppTypeEntity.h"
#import "CtrlCodeScan.h"

@interface JYBApplicationViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    NSArray <JYBAppTypeEntity *>*applicationTypeArray;
}

@property (weak, nonatomic) IBOutlet UICollectionView *appCollectionView;

@end

@implementation JYBApplicationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
//MARK: Init
- (instancetype)init
{
    if (self = [super init]) {
        applicationTypeArray = [self getApplicationTypeData];
        
    }
    return self;
}

//MARK: setter & getter
- (void)setAppCollectionView:(UICollectionView *)appCollectionView
{
    _appCollectionView = appCollectionView;
    appCollectionView.backgroundColor = [UIColor jyb_backgroundColor];
    [appCollectionView registerClass:[JYBAppCell class]
        forCellWithReuseIdentifier:@"cell"];
}
//MARK: loadData
- (NSArray <JYBAppTypeEntity *>*)getApplicationTypeData
{
    return [JYBAppTypeEntity mj_objectArrayWithFilename:@"JYBAppTypeList.plist"];
}

//MARK: Action

//MARK: UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return [applicationTypeArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    JYBAppCell *appCell = (JYBAppCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [appCell setApplicationTypeEntity:applicationTypeArray[indexPath.row]];
    return appCell;
}

//MARK: UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{

    NSLog(@"tap item at index = %ld",indexPath.row);
    JYBBaseViewController *ctr;
    if (indexPath.row == 0) {

        ctr = [[JYBAppWorkOrderViewController alloc] init];
        ctr.navigationTitle = @"工单";
        
    }else if(indexPath.row == 1){
        
        ctr = [[JYBAppQualityViewController alloc] init];
        ctr.navigationTitle = @"质量检查单";
        
    }else if(indexPath.row == 2){
        
        ctr = [[JYBAppSafeViewController alloc] init];
        ctr.navigationTitle = @"安全检查单";
        
    }else if(indexPath.row == 3){
        
        ctr = [[JYBAppProwledViewController alloc] init];
        ctr.navigationTitle = @"日常巡查";
        
    }else if(indexPath.row == 4){
        
        ctr = [[JYBAppSignInViewController alloc] init];
        ctr.navigationTitle = @"签到";
        
    }else if(indexPath.row == 5){
        
        ctr = [[JYBAppApplicationViewController alloc] init];
        ctr.navigationTitle = @"流程审批";
        
    }else if(indexPath.row == 6){
        [self confirmSimulator];
    }else if(indexPath.row == 7){
        [self confirmSimulator];
    }else if(indexPath.row == 8){
        [self confirmSimulator];
    }
    [ctr setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:ctr animated:YES];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self changeHighlightCellWithIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self changeHighlightCellWithIndexPath:indexPath];
}

//MARK: UICollectionViewDelegateFlowLayout

////TODO: 配置 sectionView 的 Size
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
//{
//    return CGSizeMake(107, 98);
//}

//配置 cell 的 Size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    // 107/98 = widthForCell / x
    // x = widthForCell * 98/107
    CGFloat widthForCell = floorf((SCR_WIDTH-2.0)/3.0);
    CGFloat heightForCell = floorf(widthForCell * (98.0/107.0));
    return CGSizeMake(widthForCell, heightForCell);
}

//配置 section 的边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
{
    return UIEdgeInsetsZero;//UIEdgeInsetsMake(5, 9, 5, 9);
}

//配置 cell 的最小上下间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
{
    return 1.0;
}

//配置 cell 的最小左右间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
{
    return 1.0;
}
//MARK: Other
/**
 * 根据高亮状态修改背景图片
 */
- (void)changeHighlightCellWithIndexPath: (NSIndexPath *) indexPath{
    //获取当前变化的Cell
    JYBAppCell *currentHighlightCell = (JYBAppCell *)[self.appCollectionView cellForItemAtIndexPath:indexPath];
    
    if (currentHighlightCell.highlighted){
        [UIView animateWithDuration:0.2 animations:^{
            currentHighlightCell.backgroundColor = [UIColor jyb_cellHighlightedColor];
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            currentHighlightCell.backgroundColor = [UIColor jyb_whiteColor];
        }];
    }
    
}

//扫一扫
- (void)confirmSimulator{
    if(TARGET_IPHONE_SIMULATOR){
        showMessage(@"模拟器不支持扫码！");
        return;
    }
    CtrlCodeScan *ctr = [[CtrlCodeScan alloc] init];
    ctr.navigationTitle = @"扫一扫";
    [ctr setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:ctr animated:YES];
    return;
}

@end
