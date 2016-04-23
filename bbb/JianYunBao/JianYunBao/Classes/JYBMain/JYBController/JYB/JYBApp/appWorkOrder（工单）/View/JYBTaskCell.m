//
//  JYBTaskCell.m
//  TestView
//
//  Created by faith on 16/3/11.
//  Copyright © 2016年 faith. All rights reserved.
//

#import "JYBTaskCell.h"

@implementation JYBTaskCell

+ (UINib*)nib
{
  return [UINib nibWithNibName:NSStringFromClass([JYBTaskCell class]) bundle:nil];
}
- (void)awakeFromNib
{
  UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
  _workStateImage.userInteractionEnabled = YES;
  [_workStateImage addGestureRecognizer:tapGesture];
  
  UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction2:)];
  _lookImage.userInteractionEnabled = YES;
  [_lookImage addGestureRecognizer:tapGesture2];

}
- (void)tapAction:(UITapGestureRecognizer *)sender
{
  if(self.statusImageBlock)
  {
    self.statusImageBlock();
  }
}
- (void)tapAction2:(UITapGestureRecognizer *)sender
{
  if(self.lookImageBlock)
  {
    self.lookImageBlock();
  }
}

+ (NSString *)cellReuseIdentifier
{
  return [NSString stringWithFormat:@"%@Identifier",NSStringFromClass([JYBTaskCell class])];
}
+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
  static NSString * reuseIdentifier = @"JYBTaskCell";
  JYBTaskCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
  if (!cell) {
    cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JYBTaskCell class]) owner:self options:nil] firstObject];
  }
  cell.lineView.backgroundColor = RGB(50, 156, 229);
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  return cell;
}
- (void)setSubTaskItem:(JYBSubtaskItem *)subTaskItem
{
  NSString * executorStr = [subTaskItem.executors componentsJoinedByString:@","];
  _executor.text = executorStr;
  _executor.font = [UIFont systemFontOfSize:10];
  _taskName.text = subTaskItem.name;
  NSString *workState = subTaskItem.workState;
  if([workState isEqualToString:@"0"])
  {
    _workStateImage.image = [UIImage imageNamed:@"进行中1"];
  }
  else if ([workState isEqualToString:@"1"])
  {
    _workStateImage.image = [UIImage imageNamed:@"完成"];
  }
  else if([workState isEqualToString:@"2"])
  {
    _workStateImage.image = [UIImage imageNamed:@"暂停"];
  }
  
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
