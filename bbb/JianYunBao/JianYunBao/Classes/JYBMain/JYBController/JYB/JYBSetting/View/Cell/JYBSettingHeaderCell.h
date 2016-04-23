//
//  JYBSettingHeaderCell.h
//  JianYunBao
//
//  Created by 冰点 on 16/1/26.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYBUserItem.h"


typedef void(^pickerBlock)();

@interface JYBSettingHeaderCell : UITableViewCell
{
    @private
    __weak IBOutlet JYBImageView *avatar;
    __weak IBOutlet JYBLabel *userNameLabel;
    __weak IBOutlet JYBLabel *nickNameLabel;
    
}
+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
+ (CGFloat)heightForRow;

@property (nonatomic, strong) JYBUserItem *user;

@property (nonatomic,copy) pickerBlock pickerBlock;


@end
