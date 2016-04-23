//
//  JYBAppCell.m
//  JianYunBao
//
//  Created by 冰点 on 16/1/26.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBAppCell.h"

@implementation JYBAppCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JYBAppCell class]) owner:self options:nil] lastObject];
    }
    return self;
}

#pragma mark - public
- (void)setApplicationTypeEntity:(JYBAppTypeEntity *)entity
{
    appIcon.image = [UIImage imageNamed:entity.icon];
    appTitleLabel.text = entity.name;
//    unreadLabel.unreadCount = 9;
}



@end
