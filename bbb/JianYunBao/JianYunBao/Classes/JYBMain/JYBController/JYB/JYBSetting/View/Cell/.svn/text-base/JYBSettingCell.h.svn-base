//
//  JYBSettingCell.h
//  JianYunBao
//
//  Created by 冰点 on 16/1/26.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYBSettingEntity.h"
#import "JYBUserItem.h"

@interface JYBSettingCell : UITableViewCell
{
    @private
    
    __weak IBOutlet UIImageView *settingIcon;
    __weak IBOutlet JYBLabel *settingTitleLabel;
    __weak IBOutlet JYBLabel *settingDetailLabel;
    
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) JYBUserItem *user;
+ (CGFloat)heightForRow;

///勿修改
- (void)setSettingEntity:(JYBSettingItem *)item;


@end
