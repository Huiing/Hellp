//
//  JYBPersonalHeaderTableViewCell.h
//  JianYunBao
//
//  Created by 宋亚伟 on 16/3/1.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYBFriendItem.h"
@class JYBPersonalHeaderTableViewCell;

@protocol JYBPersonalHeaderTableViewCellDelegate <NSObject>
@optional
- (void)iconClick:(UIButton *)btn view:(JYBPersonalHeaderTableViewCell *)header;
@end

@interface JYBPersonalHeaderTableViewCell : UITableViewCell
+ (UINib*)nib;
+ (NSString *)cellReuseIdentifier;
+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
@property (nonatomic, copy) NSIndexPath *indexPath;
@property (weak, nonatomic) IBOutlet UIButton *Btn;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;
@property (nonatomic,weak) id<JYBPersonalHeaderTableViewCellDelegate> delegate;


@property (nonatomic, strong) JYBFriendItem *friendItem;
@end
