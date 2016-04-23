//
//  BDIndexTableView.m
//  BATableView
//
//  Created by 冰点 on 16/1/27.
//  Copyright © 2016年 abel. All rights reserved.
//

#import "BDIndexTableView.h"
#import "BDIndexView.h"

@interface BDIndexTableView ()<BDIndexViewDelegate>

@property (nonatomic, strong) BDBaseTableView *table;
@property (nonatomic, strong) UILabel * flotageLabel;//浮动视图
@property (nonatomic, strong) BDIndexView * indexView;

@end

@implementation BDIndexTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
//    [self setup];
}

- (void)setup
{
    [self addSubview:self.table];
    [self addSubview:self.indexView];
    
    self.flotageLabel = [[UILabel alloc] initWithFrame:(CGRect){(self.width - 64 ) / 2,(self.height - 64) / 2,64,64}];
    self.flotageLabel.backgroundColor = JYBMainColor;
    self.flotageLabel.hidden = YES;
    self.flotageLabel.textAlignment = NSTextAlignmentCenter;
    self.flotageLabel.textColor = [UIColor jyb_whiteColor];
    [self addSubview:self.flotageLabel];
}

- (BDBaseTableView *)table
{
    if (!_table) {
        _table = [[BDBaseTableView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) style:UITableViewStylePlain];
        [_table hideTableViewCellSeparator];
        [_table clearTableBackgroundView];
    }
    return _table;
}

- (BDIndexView *)indexView
{
    if (!_indexView) {
        _indexView = [[BDIndexView alloc] initWithFrame:(CGRect){self.table.width - 20, 64, 20, self.height}];
    }
    return _indexView;
}

- (void)setDelegate:(id<BDIndexTableViewDelegate>)delegate
{
    _delegate = delegate;
    self.table.delegate = delegate;
    self.table.dataSource = delegate;
    [self reloadData];
    
}

#pragma mark - BATableViewIndex
- (void)tableViewIndex:(BDIndexView *)tableViewIndex didSelectSectionAtIndex:(NSInteger)index withTitle:(NSString *)title {
    if (index > -1){   // for safety, should always be YES
        for (NSInteger i = 0; i < [self.delegate numberOfSectionsInTableView:self.table]; i++) {
            if ([[self.delegate titleString:i] isEqualToString:title]) {
                [self.table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:i]
                                      atScrollPosition:UITableViewScrollPositionTop
                                              animated:NO];
                break;
            }
        }
        self.flotageLabel.text = title;
    }
}

- (void)tableViewIndexTouchesBegan:(BDIndexView *)tableViewIndex {
    self.flotageLabel.hidden = NO;
}

- (void)tableViewIndexTouchesEnd:(BDIndexView *)tableViewIndex {
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.4;
    [self.flotageLabel.layer addAnimation:animation forKey:nil];
    
    self.flotageLabel.hidden = YES;
}

- (NSArray *)tableViewIndexTitle:(BDIndexView *)tableViewIndex {
    return [self.delegate sectionIndexTitlesForABELTableView:self];
}

- (void)layoutSubviews
{
}

#pragma mark - public

- (void)reloadData {
    [self.table reloadData];
    self.indexView.indexes = [self.delegate sectionIndexTitlesForABELTableView:self];
    [self.indexView reloadLayout:self.table.contentInset];
    self.indexView.delegate = self;
}

- (void)hideFlotage {
    self.flotageLabel.hidden = YES;
}
@end
