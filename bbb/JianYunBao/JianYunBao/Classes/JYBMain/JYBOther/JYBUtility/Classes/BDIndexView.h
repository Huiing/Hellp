//
//  BDIndexView.h
//  BATableView
//
//  Created by 冰点 on 16/1/27.
//  Copyright © 2016年 abel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BDIndexView;
@protocol BDIndexViewDelegate <NSObject>

/**
 *  触摸到索引时触发
 *
 *  @param tableViewIndex 触发didSelectSectionAtIndex对象
 *  @param index          索引下标
 *  @param title          索引文字
 */
- (void)tableViewIndex:(BDIndexView *)tableViewIndex didSelectSectionAtIndex:(NSInteger)index withTitle:(NSString *)title;

/**
 *  开始触摸索引
 *
 *  @param tableViewIndex 触发tableViewIndexTouchesBegan对象
 */
- (void)tableViewIndexTouchesBegan:(BDIndexView *)tableViewIndex;
/**
 *  触摸索引结束
 *
 *  @param tableViewIndex
 */
- (void)tableViewIndexTouchesEnd:(BDIndexView *)tableViewIndex;

/**
 *  TableView中右边右边索引title
 *
 *  @param tableViewIndex 触发tableViewIndexTitle对象
 *
 *  @return 索引title数组
 */
- (NSArray *)tableViewIndexTitle:(BDIndexView *)tableViewIndex;

@end

@interface BDIndexView : UIView

@property (nonatomic, strong) NSArray *indexes;
@property (nonatomic, assign) id <BDIndexViewDelegate> delegate;

- (void)reloadLayout:(UIEdgeInsets)edgeInsets;

@end
