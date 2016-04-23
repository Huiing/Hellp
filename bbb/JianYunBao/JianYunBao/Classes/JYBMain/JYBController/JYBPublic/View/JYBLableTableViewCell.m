//
//  JYBLableTableViewCell.m
//  JianYunBao
//
//  Created by 宋亚伟 on 16/2/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBLableTableViewCell.h"

@implementation JYBLableTableViewCell

+ (UINib*)nib
{
    return [UINib nibWithNibName:NSStringFromClass([JYBLableTableViewCell class]) bundle:nil];
}

+ (NSString *)cellReuseIdentifier
{
    return [NSString stringWithFormat:@"%@Identifier",NSStringFromClass([JYBLableTableViewCell class])];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    static NSString * reuseIdentifier = @"JYBTextTableViewCell";
    JYBLableTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JYBLableTableViewCell class]) owner:self options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setBackButton:(UIButton *)backButton{
    _backButton = backButton;
    backButton.backgroundColor = [UIColor whiteColor];
    backButton.layer.borderWidth = 1;
    backButton.layer.borderColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1].CGColor;
}

- (IBAction)BtnClick:(id)sender {
    NSLog(@"%@",sender);
  if(self.selectBlock)
  {
    self.selectBlock();
  }
}

@end
