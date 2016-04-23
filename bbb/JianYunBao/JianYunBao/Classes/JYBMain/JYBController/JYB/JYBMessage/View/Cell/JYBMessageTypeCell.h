//
//  JYBMessageTypeCell.h
//  JianYunBao
//
//  Created by 冰点 on 16/1/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYBMessageLabel.h"
#import "JYBMessageTypeEntity.h"

@interface JYBMessageTypeCell : UITableViewCell
{
    @private
    NSIndexPath *indexPath_;
    __weak IBOutlet UIImageView *messageIcon;
    __weak IBOutlet JYBMessageLabel *unreadLabel;
    __weak IBOutlet JYBLabel *messageTypeLabel;
    
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) NSInteger unreadCount;

+ (CGFloat)heightForRow;

///勿修改
- (void)setMessageTypeEntity:(JYBMessageTypeEntity *)entity;

@end
