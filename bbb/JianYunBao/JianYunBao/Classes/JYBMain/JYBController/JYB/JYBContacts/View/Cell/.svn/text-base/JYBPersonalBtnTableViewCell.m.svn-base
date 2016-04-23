//
//  JYBPersonalBtnTableViewCell.m
//  JianYunBao
//
//  Created by 宋亚伟 on 16/3/1.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBPersonalBtnTableViewCell.h"

@implementation JYBPersonalBtnTableViewCell

+ (UINib*)nib
{
    return [UINib nibWithNibName:NSStringFromClass([JYBPersonalBtnTableViewCell class]) bundle:nil];
}

+ (NSString *)cellReuseIdentifier
{
    return [NSString stringWithFormat:@"%@Identifier",NSStringFromClass([JYBPersonalBtnTableViewCell class])];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    static NSString * reuseIdentifier = @"JYBPersonalTableViewCell";
    JYBPersonalBtnTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JYBPersonalBtnTableViewCell class]) owner:self options:nil] firstObject];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.indexPath = indexPath;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setBtn:(UIButton *)Btn{
    _Btn = Btn;
}

- (void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    if (indexPath.section == 1) {
        self.Btn.backgroundColor = [UIColor colorWithRed:66/255.0 green:193/255.0 blue:48/255.0 alpha:1.0];
        [self.Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.Btn setTitle:@"发消息" forState:UIControlStateNormal];
    }else if(indexPath.section == 2){
        self.Btn.backgroundColor = [UIColor whiteColor];
        [self.Btn setTitle:@"打电话" forState:UIControlStateNormal];
    }else if(indexPath.section == 3){
        self.Btn.backgroundColor = [UIColor whiteColor];
        [self.Btn setTitle:@"发短信" forState:UIControlStateNormal];
    }else if(indexPath.section == 4){
        self.Btn.backgroundColor = [UIColor whiteColor];
        [self.Btn setTitle:@"添加到常用联系人" forState:UIControlStateNormal];
    }
    
}

- (void)setContact:(NSString *)contact{
    _contact = contact;
    if(_indexPath.section == 4){
        if ([contact isEqualToString:@"0"]) {
            [self.Btn setTitle:@"添加到常用联系人" forState:UIControlStateNormal];
        }else{
            [self.Btn setTitle:@"移除常用联系人" forState:UIControlStateNormal];
        }
    }


}

- (IBAction)BtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(btnClick:)]) {
        [self.delegate btnClick:_indexPath];
    }
}

@end
