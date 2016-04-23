//
//  JYBFileTypeCell.m
//  JianYunBao
//
//  Created by faith on 16/3/14.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBFileTypeCell.h"

@implementation JYBFileTypeCell

- (void)awakeFromNib {
    // Initialization code
}
+ (UINib*)nib
{
  return [UINib nibWithNibName:NSStringFromClass([JYBFileTypeCell class]) bundle:nil];
}

+ (NSString *)cellReuseIdentifier
{
  return [NSString stringWithFormat:@"%@Identifier",NSStringFromClass([JYBFileTypeCell class])];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
  static NSString * reuseIdentifier = @"JYBTextTableViewCell";
  JYBFileTypeCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
  if (!cell) {
    cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JYBFileTypeCell class]) owner:self options:nil] firstObject];
  }
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  return cell;
}

- (IBAction)typeAction:(UIButton *)sender {
  if(self.fileTypeBlock)
  {
    self.fileTypeBlock(sender,sender.tag);
  }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
