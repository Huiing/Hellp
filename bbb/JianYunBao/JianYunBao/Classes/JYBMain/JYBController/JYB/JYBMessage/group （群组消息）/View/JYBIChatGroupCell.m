//
//  JYBIChatGroupCell.m
//  JianYunBao
//
//  Created by 冰点 on 16/3/15.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBIChatGroupCell.h"
#import "JYBFriendItemTool.h"
#import "JYBSyncGroupModel.h"
#import "UITableViewCell+BDCategoryCell.h"
#import "BDIMDatabaseUtil.h"
#import "JYBConversation.h"
#import "NSDate+Category.h"
#import "JYBFriendItem.h"

@implementation JYBIChatGroupCell

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
    static NSString * reuseIdentifier = @"JYBIChatGroupCell";
    JYBIChatGroupCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JYBIChatGroupCell class]) owner:self options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

+ (CGFloat)heightForRow
{
    return Compose_Scale(57);
}

- (void)drawRect:(CGRect)rect
{
    [self drawSeparatorOfCellContentView:rect];
}

- (void)setGroupModel:(JYBSyncGroupModel *)model
{
//    NSString *avatar = [[[JYBFriendItemTool friends:model.userId] firstObject] iconPaths];
//    [groupAvatar sd_setImageWithURL:[NSURL URLWithString:JYBErpRootUrl(avatar)] placeholderImage:[UIImage imageNamed:@"图片默认图标"]];
    
    for (NSString *userId in model.userIds) {
        JYBFriendItem *friendItem = [[JYBFriendItemTool friends:userId] firstObject];
        [groupAvatar addAvatarWithUrl:[NSURL URLWithString:JYBErpRootUrl(friendItem.iconPaths)]];
    }
    
    groupNameLabel.text = model.name;
    if (model.conversation) {
        unreadLabel.unreadCount = model.conversation.unreadCount;
        groupContentLabel.text = model.conversation.lastMsg;
        NSDate *createDate = [NSDate dateWithTimeIntervalInMilliSecondSince1970:model.conversation.timestamp];
        groupTimeLabel.text = [createDate formattedTime];
    } else {
        groupContentLabel.text = @"";
        groupTimeLabel.text = @"";
    }
}

- (void)setConversation:(JYBConversation *)conversation
{
    JYBSyncGroupModel *model = [[BDIMDatabaseUtil sharedInstance] getGroupWithSid:conversation.message.conversationChatter];
    [self setGroupModel:model];
    
    groupContentLabel.text = conversation.lastMsg;
    NSDate *createDate = [NSDate dateWithTimeIntervalInMilliSecondSince1970:conversation.timestamp];
    groupTimeLabel.text = [createDate formattedTime];
}


@end
