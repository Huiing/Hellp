//
//  BDIndexTableView.h
//  BATableView
//
//  Created by 冰点 on 16/1/27.
//  Copyright © 2016年 abel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BDIndexTableView;
@protocol BDIndexTableViewDelegate <NSObject,UITableViewDataSource,UITableViewDelegate>

- (NSArray *)sectionIndexTitlesForABELTableView:(BDIndexTableView *)tableView;
- (NSString *)titleString:(NSInteger)section;

@end

@interface BDIndexTableView : UIView

///注意：此delegate一定要在`BDIndexTableView`初始化完成后才可设置代理
@property (nonatomic, assign) id <BDIndexTableViewDelegate> delegate;
- (void)reloadData;
- (void)hideFlotage;

@end
