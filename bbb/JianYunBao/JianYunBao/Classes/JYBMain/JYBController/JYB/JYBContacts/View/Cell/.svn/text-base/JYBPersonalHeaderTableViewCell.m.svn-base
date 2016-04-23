//
//  JYBPersonalHeaderTableViewCell.m
//  JianYunBao
//
//  Created by 宋亚伟 on 16/3/1.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBPersonalHeaderTableViewCell.h"
#import <UIButton+WebCache.h>

@implementation JYBPersonalHeaderTableViewCell


+ (UINib*)nib
{
    return [UINib nibWithNibName:NSStringFromClass([JYBPersonalHeaderTableViewCell class]) bundle:nil];
}

+ (NSString *)cellReuseIdentifier
{
    return [NSString stringWithFormat:@"%@Identifier",NSStringFromClass([JYBPersonalHeaderTableViewCell class])];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    static NSString * reuseIdentifier = @"JYBPersonalTableViewCell";
    JYBPersonalHeaderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JYBPersonalHeaderTableViewCell class]) owner:self options:nil] firstObject];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.indexPath = indexPath;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setFriendItem:(JYBFriendItem *)friendItem{
    _friendItem = friendItem;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",JYB_erpRootUrl,friendItem.iconPaths]];
    [self.Btn sd_setBackgroundImageWithURL:url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"图片默认图标"]];
    if ([friendItem.sex isEqualToString:@"男"] || friendItem.sex == nil || [friendItem.sex isEqualToString:@""]) {
        [_sexImageView setImage:[UIImage imageNamed:@"nan"]];
    }else{
        [_sexImageView setImage:[UIImage imageNamed:@"nv"]];
    }

    self.nameLabel.text = friendItem.name;
    self.userNameLabel.text = friendItem.userName;
    
}

- (IBAction)BtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(iconClick:view:)]) {
        [self.delegate iconClick:_Btn view:self];
    }
}


@end
