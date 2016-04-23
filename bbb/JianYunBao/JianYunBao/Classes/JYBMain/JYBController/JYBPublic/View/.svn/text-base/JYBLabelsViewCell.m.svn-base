//
//  JYBLabelsViewCell.m
//  JianYunBao
//
//  Created by faith on 16/3/12.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBLabelsViewCell.h"

@implementation JYBLabelsViewCell

- (void)awakeFromNib {
    // Initialization code
}

+ (UINib*)nib
{
  return [UINib nibWithNibName:NSStringFromClass([JYBLabelsViewCell class]) bundle:nil];
}

+ (NSString *)cellReuseIdentifier
{
  return [NSString stringWithFormat:@"%@Identifier",NSStringFromClass([JYBLabelsViewCell class])];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
  static NSString * reuseIdentifier = @"JYBTextTableViewCell";
  JYBLabelsViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
  if (!cell) {
    cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JYBLabelsViewCell class]) owner:self options:nil] firstObject];
  }
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  return cell;
}
@end
