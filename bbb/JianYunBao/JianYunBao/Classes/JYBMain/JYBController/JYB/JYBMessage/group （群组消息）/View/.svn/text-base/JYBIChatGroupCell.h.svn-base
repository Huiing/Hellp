//
//  JYBIChatGroupCell.h
//  JianYunBao
//
//  Created by 冰点 on 16/3/15.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYBMessageLabel.h"
#import "BDGroupAvatarView.h"

@class JYBSyncGroupModel;
@class JYBConversation;
@interface JYBIChatGroupCell : UITableViewCell
{
    @private
    __weak IBOutlet BDGroupAvatarView *groupAvatar;
    __weak IBOutlet JYBLabel *groupNameLabel;
    
    
    __weak IBOutlet JYBMessageLabel *unreadLabel;
    
    __weak IBOutlet UILabel *groupContentLabel;
    
    __weak IBOutlet UILabel *groupTimeLabel;
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
+ (CGFloat)heightForRow;

- (void)setGroupModel:(JYBSyncGroupModel *)model;

- (void)setConversation:(JYBConversation *)conversation;
@end
