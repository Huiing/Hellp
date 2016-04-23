//
//  JYBPersonalTableViewCell.h
//  JianYunBao
//
//  Created by 宋亚伟 on 16/3/1.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYBFriendItem.h"


@interface JYBPersonalTableViewCell : UITableViewCell
+ (UINib*)nib;
+ (NSString *)cellReuseIdentifier;
+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
@property (nonatomic, copy) NSIndexPath *indexPath;

@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) JYBFriendItem *friendItem;

@end
