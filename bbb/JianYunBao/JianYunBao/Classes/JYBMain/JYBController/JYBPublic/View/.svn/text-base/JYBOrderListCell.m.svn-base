//
//  JYBOrderListCell.m
//  JianYunBao
//
//  Created by faith on 16/3/11.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBOrderListCell.h"
#import "UIImageView+WebCache.h"

@implementation JYBOrderListCell




+ (UINib*)nib
{
  return [UINib nibWithNibName:NSStringFromClass([JYBOrderListCell class]) bundle:nil];
}

+ (NSString *)cellReuseIdentifier
{
  return [NSString stringWithFormat:@"%@Identifier",NSStringFromClass([JYBOrderListCell class])];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
  static NSString * reuseIdentifier = @"JYBOrderListCell";
  JYBOrderListCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
  if (!cell) {
    cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JYBOrderListCell class]) owner:self options:nil] firstObject];
  }
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  return cell;
}
- (void)setOrderItem:(JYBOrderItem *)orderItem{
  NSString *orderId = [NSString stringWithFormat:@"ID:000%@",orderItem.orderId];
  _orderIdLabel.text = orderId;
  _nameLbl.text = orderItem.createUserName;
  _titleNameLbl.text = orderItem.titleName;
  _responsibeLbl.text = [NSString stringWithFormat:@"责任人:%@",orderItem.responUser];
  UIColor *color = RGB(172, 172, 172);
  NSString *importance = @"不重要";
  if([orderItem.importantState isEqualToString:@"1"])
  {
    color = RGB(151, 200, 233);
    importance = @"重要";
  }
  _importanceLbl.text = importance;
  _importanceLbl.backgroundColor = color;

  NSString *emergency = @"不紧急";
  if([orderItem.emergencyState isEqualToString:@"1"])
  {
    color = RGB(236, 160, 144);
    emergency = @"紧急";
  }
  _emergencyLbl.text = emergency;
  _emergencyLbl.backgroundColor = color;

  NSString *workStatus = @"执行中";
  color = RGB(150, 225, 170);

  if([orderItem.workState isEqualToString:@"1"])
  {
    workStatus = @"完成";
  }
  else if([orderItem.workState isEqualToString:@"2"])
  {
    workStatus = @"暂停";
  }
  else if([orderItem.workState isEqualToString:@"3"])
  {
    workStatus = @"取消";
  }
  _workStatusLbl.text = workStatus;
  _workStatusLbl.backgroundColor = color;

  _backGroundLbl.layer.cornerRadius = 5;
  _backGroundLbl.layer.borderColor = [UIColor lightGrayColor].CGColor;
  _backGroundLbl.layer.borderWidth = 2;
  _backGroundLbl.clipsToBounds = YES;
  _dateLbl.text = [NSString stringWithFormat:@"完成日期:%@",orderItem.createDate];
  NSURL *url = [NSURL URLWithString:@""];
  [_icon sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"图片默认图标"]];


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
