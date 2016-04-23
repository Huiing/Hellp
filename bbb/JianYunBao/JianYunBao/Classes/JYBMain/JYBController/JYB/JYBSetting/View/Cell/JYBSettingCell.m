//
//  JYBSettingCell.m
//  JianYunBao
//
//  Created by 冰点 on 16/1/26.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBSettingCell.h"
#import "UITableViewCell+BDCategoryCell.h"

@implementation JYBSettingCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    if (highlighted) {
        [UIView animateWithDuration:0.2 animations:^{
            self.contentView.backgroundColor = [UIColor jyb_cellHighlightedColor];
        }];
        
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            self.contentView.backgroundColor = [UIColor clearColor];
        }];
        
    }
}

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    static NSString * reuseIdentifier = @"JYBSettingCell";
    JYBSettingCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JYBSettingCell class]) owner:self options:nil] firstObject];
        cell.indexPath = indexPath;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

+ (CGFloat)heightForRow
{
    return Compose_Scale(47);
}

- (void)setUser:(JYBUserItem *)user{
    _user = user;
    if (_indexPath.section == 1) {
        if (_indexPath.row == 0) {
            settingDetailLabel.text = user.sex;
        }else if (_indexPath.row == 1){
            settingDetailLabel.text = user.email;
        }else if (_indexPath.row == 2){
            settingDetailLabel.text = user.phoneNum;
        }
    }else if (_indexPath.section == 2){
        if (_indexPath.row == 0) {
            settingDetailLabel.text = user.company;
        }else if (_indexPath.row == 1){
            settingDetailLabel.text = user.department;
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)drawRect:(CGRect)rect
{
    [self drawSeparatorOfCellContentView:rect];
}

#pragma mark - public
- (void)setSettingEntity:(JYBSettingItem *)item;
{
    settingIcon.image = [UIImage imageNamed:item.icon];
    settingTitleLabel.text = item.name;
}

@end
