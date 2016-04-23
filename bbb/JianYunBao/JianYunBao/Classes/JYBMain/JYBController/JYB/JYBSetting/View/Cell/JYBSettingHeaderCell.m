//
//  JYBSettingHeaderCell.m
//  JianYunBao
//
//  Created by 冰点 on 16/1/26.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBSettingHeaderCell.h"
#import "UITableViewCell+BDCategoryCell.h"
#import "UIImageView+WebCache.h"

@interface JYBSettingHeaderCell ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end


@implementation JYBSettingHeaderCell

- (void)awakeFromNib {
    // Initialization code
    [avatar addTarget:self action:@selector(didClickAvatar:)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    static NSString * reuseIdentifier = @"JYBSettingHeaderCell";
    JYBSettingHeaderCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JYBSettingHeaderCell class]) owner:self options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

+ (CGFloat)heightForRow
{
    return Compose_Scale(73);
}

- (void)setUser:(JYBUserItem *)user{
    _user = user;
    [avatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",JYB_erpRootUrl,user.iconPaths]] placeholderImage:[UIImage imageNamed:@"默认头像"]];
    userNameLabel.text = user.name;
    nickNameLabel.text = [NSString stringWithFormat:@"建云号：%@",user.userName];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)drawRect:(CGRect)rect
{
    [self drawSeparatorOfCellContentView:rect];
}

- (void)didClickAvatar:(JYBImageView *)avatar
{
    NSLog(@"55555");
    if (self.pickerBlock)
    {
        self.pickerBlock();
    }
    

}



#pragma mark - public

@end
