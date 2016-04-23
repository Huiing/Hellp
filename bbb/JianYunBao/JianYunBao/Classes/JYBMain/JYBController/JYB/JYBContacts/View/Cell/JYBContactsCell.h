//
//  JYBContactsCell.h
//  JianYunBao
//
//  Created by 冰点 on 16/1/27.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYBFriendItem.h"

@interface JYBContactsCell : UITableViewCell
{
    @private
    __weak IBOutlet JYBImageView *contactIcon;
    __weak IBOutlet JYBLabel *contactNameLabel;
    __weak IBOutlet JYBLabel *contactTelLabel;
    
    __weak IBOutlet NSLayoutConstraint *layoutConstraintWithContactNameLabelCenterY;
    
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) JYBFriendItem *friendItem;

+ (CGFloat)heightForRow;

- (void)setContactEntity:(NSString *)name;
///勿修改
- (void)setOtherContactEntity:(NSString *)name;
@end
