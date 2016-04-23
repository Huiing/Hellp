//
//  JYBMessageTypeCell.m
//  JianYunBao
//
//  Created by 冰点 on 16/1/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBMessageTypeCell.h"
#import "UITableViewCell+BDCategoryCell.h"
#import "JYBConversationModule.h"

@implementation JYBMessageTypeCell
@synthesize indexPath = indexPath_;

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
    static NSString * reuseIdentifier = @"JYBMessageTypeCell";
    JYBMessageTypeCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JYBMessageTypeCell class]) owner:self options:nil] firstObject];
    }
    cell.indexPath = indexPath;
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
- (void)setMessageTypeEntity:(JYBMessageTypeEntity *)entity
{
    messageIcon.image = [UIImage imageNamed:entity.icon];
    messageTypeLabel.text = entity.name;
    switch (indexPath_.row) {
        case 0:break;
        case 1:break;
        case 2:break;
        case 3:break;
        case 4:break;
        case 5:break;
        case 6:
            self.unreadCount = [[JYBConversationModule sharedInstance] getUnreadMessageCountWith:JYBConversationTypeGroup];
            break;
        case 7:
            self.unreadCount = [[JYBConversationModule sharedInstance] getUnreadMessageCountWith:JYBConversationTypeSingle];
            break;
        case 8:
            self.unreadCount = [[JYBConversationModule sharedInstance] getUnreadMessageCountWith:JYBConversationTypeWhiteboard];
            break;
        default:
            break;
    }
    
}

- (void)setUnreadCount:(NSInteger)unreadCount
{
    _unreadCount = unreadCount;
    unreadLabel.unreadCount = unreadCount;
    
}



@end
