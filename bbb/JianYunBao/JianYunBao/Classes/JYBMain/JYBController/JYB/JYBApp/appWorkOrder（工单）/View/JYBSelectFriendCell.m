//
//  JYBSelectFriendCell.m
//  JianYunBao
//
//  Created by faith on 16/3/16.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBSelectFriendCell.h"
#import "UITableViewCell+BDCategoryCell.h"
#import "UIImageView+WebCache.h"
@implementation JYBSelectFriendCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)selectPeople:(id)sender {
  if(self.selectFriendBlock)
  {
    self.selectFriendBlock(self);
  }

}
+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
  static NSString * reuseIdentifier = @"JYBContactsCell";
  JYBSelectFriendCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
  if (!cell) {
    cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JYBSelectFriendCell class]) owner:self options:nil] firstObject];
    cell.backgroundColor = [UIColor clearColor];
  }
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  return cell;
}

+ (CGFloat)heightForRow
{
  return Compose_Scale(54);
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
- (void)setFriendItem:(JYBFriendItem *)friendItem{
  _friendItem = friendItem;
  if ([friendItem.phoneNum isEqualToString:@""] || friendItem.phoneNum == nil) {
    [self setOtherContactEntity:friendItem.name];
  }else{
    [self setContactEntity:friendItem.name];
//    contactTelLabel.text = friendItem.phoneNum;
  }
  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",JYB_erpRootUrl,friendItem.iconPaths]];
  [_contactIcon sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"图片默认图标"]];
  
}
- (void)setContactEntity:(NSString *)name
{
  _contactNameLabel.text = name;
//  layoutConstraintWithContactNameLabelCenterY.constant = -0.5 / (contactIcon.height / contactNameLabel.height) * _contactIcon.height;
//  contactTelLabel.hidden = NO;
  
}

- (void)setOtherContactEntity:(NSString *)name
{
  if ([name isEqualToString:@"全部联系人"]) {
    _contactIcon.image = [UIImage imageNamed:@"常用联系人"];
  }else{
    _contactIcon.image = [UIImage imageNamed:name];
  }
  
  _contactNameLabel.text = name;
//  layoutConstraintWithContactNameLabelCenterY.constant = 0;
//  contactTelLabel.hidden = YES;
}

- (void)setCheckImg:(BOOL)status
{
    if (status) {
        [self.selectButton setBackgroundImage:[UIImage imageNamed:@"选择上"] forState:UIControlStateNormal];
    }else {
        [self.selectButton setBackgroundImage:[UIImage imageNamed:@"选择"] forState:UIControlStateNormal];
    }
}


@end
