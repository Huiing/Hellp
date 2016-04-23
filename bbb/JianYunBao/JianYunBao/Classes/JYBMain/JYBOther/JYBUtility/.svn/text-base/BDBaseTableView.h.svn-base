//
//  BDBaseTableView.h
//  BDBaseTableView
//
//  Created by 冰点 on 15/4/30.
//  Copyright (c) 2015年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    BDSeparatorHideTypeNone,
    BDSeparatorHideTypeHeader,
    BDSeparatorHideTypeFooter,
} BDSeparatorHideType;

@protocol TouchTableDelegate <NSObject>
@optional
- (void)tableView:(UITableView *)tableView touchesBegin:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)tableView:(UITableView *)tableView touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)tableView:(UITableView *)tableView touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)tableView:(UITableView *)tableView touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;

@end
@interface BDBaseTableView : UITableView
@property (assign,nonatomic) id <TouchTableDelegate> touchDelegate;
/**
 *  隐藏没有数据的分割线
 */
- (void)hideSeparatorForNotDataSource;
- (void)hideSeparatorWhenNotDataSource:(BDSeparatorHideType)separatorType;
- (void)hideTableViewCellSeparator;

- (void)clearTableBackgroundView;

- (void)viewDidlayoutSeparatorInset;

/*!
 *  @brief  绘制iOS6TableGroup风格
 *
 *  @param tableView     当前Table
 *  @param destTable     目标Table
 *  @param cell          当前Cell
 *  @param indexPath     当前索引
 *  @param filterSection   过滤某一段禁止绘制
 */
- (void)drawiOS6TableGroupStyle:(UITableView *)tableView destinationTable:(UITableView *)destTable cell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath filterSection:(NSInteger)section;

/*!
 *  @brief  绘制iOS6TableGroup风格, 默认第一段禁止绘制
 *
 *  @param tableView 当前Table
 *  @param destTable 目标Table
 *  @param cell      当前Cell
 *  @param indexPath 当前索引
 */
- (void)drawiOS6TableGroupStyle:(UITableView *)tableView destinationTable:(UITableView *)destTable cell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
@end
