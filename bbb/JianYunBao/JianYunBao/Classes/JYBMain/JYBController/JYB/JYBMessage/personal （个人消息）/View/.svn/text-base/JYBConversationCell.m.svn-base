//
//  JYBConversationCell.m
//  JianYunBao
//
//  Created by 冰点 on 16/3/12.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBConversationCell.h"
#import "JYBConversation.h"
#import "UITableViewCell+BDCategoryCell.h"
#import "NSDate+Category.h"

@interface JYBConversationCell ()

@end

@implementation JYBConversationCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    if (highlighted) {
        [UIView animateWithDuration:0.2 animations:^{
            self.contentView.backgroundColor = [UIColor jyb_cellHighlightedColor];
        }];
        
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            self.contentView.backgroundColor = [UIColor clearColor];
        }];
        
    }
}

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    static NSString * reuseIdentifier = @"JYBConversationCell";
    JYBConversationCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JYBConversationCell class]) owner:self options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

+ (CGFloat)heightForRow
{
    return Compose_Scale(57);
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
- (void)setConversation:(JYBConversation *)conversation
{
    [avatar sd_setImageWithURL:[NSURL URLWithString:[JYB_erpRootUrl stringByAppendingFormat:@"%@", conversation.avatar]] placeholderImage:[UIImage imageNamed:@"图片默认图标"]];
    unreadLabel.unreadCount = conversation.unreadCount;
    usernameLabel.text = conversation.name;
    msgContentLabel.text = conversation.lastMsg;
    NSDate *createDate = [NSDate dateWithTimeIntervalInMilliSecondSince1970:conversation.timestamp];
    timeLabel.text = [createDate formattedTime];
}


@end
