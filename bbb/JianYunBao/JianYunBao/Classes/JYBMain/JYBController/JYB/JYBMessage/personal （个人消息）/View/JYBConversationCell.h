//
//  JYBConversationCell.h
//  JianYunBao
//
//  Created by 冰点 on 16/3/12.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYBMessageLabel.h"

@class JYBConversation;
@interface JYBConversationCell : UITableViewCell
{
    @private
    
    __weak IBOutlet UIImageView *avatar;
    
    __weak IBOutlet JYBMessageLabel *unreadLabel;
    
    __weak IBOutlet JYBLabel *usernameLabel;
    
    __weak IBOutlet JYBLabel *msgContentLabel;
    
    __weak IBOutlet JYBLabel *timeLabel;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
+ (CGFloat)heightForRow;
- (void)setConversation:(JYBConversation *)conversation;
@end
