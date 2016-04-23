//
//  JYBSignInTableViewCell.m
//  JianYunBao
//
//  Created by 宋亚伟 on 16/3/12.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBSignInTableViewCell.h"
#import "UITableViewCell+BDCategoryCell.h"

@implementation JYBSignInTableViewCell

+ (UINib*)nib
{
    return [UINib nibWithNibName:NSStringFromClass([JYBSignInTableViewCell class]) bundle:nil];
}

+ (NSString *)cellReuseIdentifier
{
    return [NSString stringWithFormat:@"%@Identifier",NSStringFromClass([JYBSignInTableViewCell class])];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    static NSString * reuseIdentifier = @"SYWSystemMessageCell";
    JYBSignInTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JYBSignInTableViewCell class]) owner:self options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)drawRect:(CGRect)rect
{
    [self drawSeparatorOfCellContentView:rect];
}

@end
