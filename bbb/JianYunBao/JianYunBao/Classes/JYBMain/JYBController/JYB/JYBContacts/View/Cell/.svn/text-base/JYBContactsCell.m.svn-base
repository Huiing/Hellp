//
//  JYBContactsCell.m
//  JianYunBao
//
//  Created by 冰点 on 16/1/27.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBContactsCell.h"
#import "UIImageView+WebCache.h"
#import "UITableViewCell+BDCategoryCell.h"


@implementation JYBContactsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    static NSString * reuseIdentifier = @"JYBContactsCell";
    JYBContactsCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JYBContactsCell class]) owner:self options:nil] firstObject];
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
        contactTelLabel.text = friendItem.phoneNum;
    }
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",JYB_erpRootUrl,friendItem.iconPaths]];
    [contactIcon sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"图片默认图标"]];

}
- (void)setContactEntity:(NSString *)name
{
    contactNameLabel.text = name;
    layoutConstraintWithContactNameLabelCenterY.constant = -0.5 / (contactIcon.height / contactNameLabel.height) * contactIcon.height;
    contactTelLabel.hidden = NO;

}

- (void)setOtherContactEntity:(NSString *)name
{
    if ([name isEqualToString:@"全部联系人"]) {
        contactIcon.image = [UIImage imageNamed:@"常用联系人"];
    }else{
        contactIcon.image = [UIImage imageNamed:name];
    }
    
    contactNameLabel.text = name;
    layoutConstraintWithContactNameLabelCenterY.constant = 0;
    contactTelLabel.hidden = YES;
}

@end
