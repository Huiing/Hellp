//
//  JYBOrderInforTableViewCell.m
//  JianYunBao
//
//  Created by faith on 16/3/12.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBOrderInforTableViewCell.h"

@implementation JYBOrderInforTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

+ (UINib*)nib
{
  return [UINib nibWithNibName:NSStringFromClass([JYBOrderInforTableViewCell class]) bundle:nil];
}

+ (NSString *)cellReuseIdentifier
{
  return [NSString stringWithFormat:@"%@Identifier",NSStringFromClass([JYBOrderInforTableViewCell class])];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
  static NSString * reuseIdentifier = @"JYBOrderInforTableViewCell";
  JYBOrderInforTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
  if (!cell) {
    cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JYBOrderInforTableViewCell class]) owner:self options:nil] firstObject];
  }
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  return cell;
}

@end
