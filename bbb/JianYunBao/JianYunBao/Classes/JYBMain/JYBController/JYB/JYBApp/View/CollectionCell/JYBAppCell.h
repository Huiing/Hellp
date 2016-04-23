//
//  JYBAppCell.h
//  JianYunBao
//
//  Created by 冰点 on 16/1/26.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYBAppTypeEntity.h"
#import "JYBMessageLabel.h"

@interface JYBAppCell : UICollectionViewCell
{
    __weak IBOutlet JYBLabel *appTitleLabel;
    __weak IBOutlet JYBMessageLabel *unreadLabel;
    __weak IBOutlet UIImageView *appIcon;
    
}
///勿修改
- (void)setApplicationTypeEntity:(JYBAppTypeEntity *)entity;

@end
