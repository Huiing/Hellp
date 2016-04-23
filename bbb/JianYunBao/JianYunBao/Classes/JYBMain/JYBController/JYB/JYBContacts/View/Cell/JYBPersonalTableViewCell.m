//
//  JYBPersonalTableViewCell.m
//  JianYunBao
//
//  Created by 宋亚伟 on 16/3/1.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBPersonalTableViewCell.h"

@implementation JYBPersonalTableViewCell

+ (UINib*)nib
{
    return [UINib nibWithNibName:NSStringFromClass([JYBPersonalTableViewCell class]) bundle:nil];
}

+ (NSString *)cellReuseIdentifier
{
    return [NSString stringWithFormat:@"%@Identifier",NSStringFromClass([JYBPersonalTableViewCell class])];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    static NSString * reuseIdentifier = @"JYBPersonalTableViewCell";
    JYBPersonalTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JYBPersonalTableViewCell class]) owner:self options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexPath = indexPath;
    return cell;
}

- (void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            _titleLabel.text = @"单位";
            _contentLabel.text = _friendItem.company;
        }else if (indexPath.row == 1){
            _titleLabel.text = @"部门";
            _contentLabel.text = _friendItem.department;
        }else if (indexPath.row == 2){
            _titleLabel.text = @"手机";
            _contentLabel.text = _friendItem.phoneNum;
        }else if (indexPath.row == 3){
            _titleLabel.text = @"邮箱";
            _contentLabel.text = _friendItem.email;
            self.lineView.hidden = YES;
        }
    }
}

- (void)setFriendItem:(JYBFriendItem *)friendItem{
    _friendItem = friendItem;
    
    if (_indexPath.section == 0) {
        if (_indexPath.row == 0) {
            _contentLabel.text = _friendItem.company;
        }else if (_indexPath.row == 1){
            _contentLabel.text = _friendItem.department;
        }else if (_indexPath.row == 2){
            _contentLabel.text = _friendItem.phoneNum;
        }else if (_indexPath.row == 3){
            _contentLabel.text = _friendItem.email;
            self.lineView.hidden = YES;
        }
    }

}

@end
