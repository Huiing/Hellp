//
//  JYBSelectFriendCell.h
//  JianYunBao
//
//  Created by faith on 16/3/16.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYBFriendItem.h"
@class JYBSelectFriendCell;
typedef void(^SelectFriendBlock)(JYBSelectFriendCell *cell);
@interface JYBSelectFriendCell : UITableViewCell
@property (weak, nonatomic) IBOutlet JYBImageView *contactIcon;
@property (weak, nonatomic) IBOutlet UILabel *contactNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;

@property (nonatomic ,copy)SelectFriendBlock selectFriendBlock;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) JYBFriendItem *friendItem;
+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
+ (CGFloat)heightForRow;

- (void)setContactEntity:(NSString *)name;
///勿修改
- (void)setOtherContactEntity:(NSString *)name;
- (void)setCheckImg:(BOOL)status;
@end
