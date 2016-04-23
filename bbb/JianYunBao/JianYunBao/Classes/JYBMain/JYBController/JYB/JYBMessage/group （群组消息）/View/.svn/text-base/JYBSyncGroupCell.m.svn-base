//
//  JYBSyncGroupCell.m
//  JianYunBao
//
//  Created by 冰点 on 16/3/15.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBSyncGroupCell.h"
#import "UITableViewCell+BDCategoryCell.h"
#import "JYBFriendItemTool.h"

@implementation JYBSyncGroupCell

- (void)awakeFromNib {
    // Initialization code
}

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

+ (UINib *)nib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JYBSyncGroupCell class]) owner:self options:nil] lastObject];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    static NSString * reuseIdentifier = @"JYBSyncGroupCell";
    JYBSyncGroupCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JYBSyncGroupCell class]) owner:self options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

+ (CGFloat)heightForRow
{
    return Compose_Scale(57);
}

- (void)drawRect:(CGRect)rect
{
    [self drawSeparatorOfCellContentView:rect];
}

- (void)setSyncGroupCellModel:(JYBSyncGroupModel *)model
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSString *avatarRemoteUrl = [[[JYBFriendItemTool friends:model.userId] firstObject] iconPaths];
        dispatch_async(dispatch_get_main_queue(), ^{
            [avatar sd_setImageWithURL:[NSURL URLWithString:JYBErpRootUrl(avatarRemoteUrl)] placeholderImage:[UIImage imageNamed:@"图片默认图标"]];
        });
    });
    
    userNameLabel.text = model.userName;
    groupNameLabel.text = model.name;
    createDateLabel.text = [@"创建日期" stringByAppendingFormat:@"%@", model.createDate];
    
}

- (void)setCheckBoxStatus:(BOOL)status
{
    status ? [checkBoxImg setImage:[UIImage imageNamed:@"icon_check_blue"]] :[checkBoxImg setImage:[UIImage imageNamed:@"btn_checkbox_off"]];
}

@end
