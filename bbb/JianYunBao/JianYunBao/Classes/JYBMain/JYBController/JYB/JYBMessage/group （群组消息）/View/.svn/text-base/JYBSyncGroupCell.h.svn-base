//
//  JYBSyncGroupCell.h
//  JianYunBao
//
//  Created by 冰点 on 16/3/15.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYBSyncGroupModel.h"

@interface JYBSyncGroupCell : UITableViewCell
{
    @private
    __weak IBOutlet UIImageView *avatar;
    __weak IBOutlet JYBLabel *userNameLabel;
    __weak IBOutlet JYBLabel *groupNameLabel;
    __weak IBOutlet JYBLabel *createDateLabel;
    __weak IBOutlet JYBLabel *isHadLabel;
    
    __weak IBOutlet UIImageView *checkBoxImg;
    
    
}
+ (UINib *)nib;
+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
+ (CGFloat)heightForRow;

- (void)setSyncGroupCellModel:(JYBSyncGroupModel *)model;
- (void)setCheckBoxStatus:(BOOL)status;

@end
