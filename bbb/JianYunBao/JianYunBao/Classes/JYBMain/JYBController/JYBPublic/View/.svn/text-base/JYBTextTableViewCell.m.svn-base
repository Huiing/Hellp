//
//  JYBTextTableViewCell.m
//  JianYunBao
//
//  Created by 宋亚伟 on 16/2/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBTextTableViewCell.h"

@implementation JYBTextTableViewCell

+ (UINib*)nib
{
    return [UINib nibWithNibName:NSStringFromClass([JYBTextTableViewCell class]) bundle:nil];
}

+ (NSString *)cellReuseIdentifier
{
    return [NSString stringWithFormat:@"%@Identifier",NSStringFromClass([JYBTextTableViewCell class])];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    static NSString * reuseIdentifier = @"JYBTextTableViewCell";
    JYBTextTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JYBTextTableViewCell class]) owner:self options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setBackView:(UIView *)backView{
    _backView = backView;
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.borderWidth = 1;
    backView.layer.borderColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1].CGColor;
}

@end
