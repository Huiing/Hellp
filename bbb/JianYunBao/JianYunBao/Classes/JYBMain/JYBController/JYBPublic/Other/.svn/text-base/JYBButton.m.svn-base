//
//  JYBButton.m
//  JianYunBao
//
//  Created by 冰点 on 16/1/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBButton.h"

@implementation JYBButton

- (void)awakeFromNib
{
    [self adjustFontSizeToFillItsContents];
    [super awakeFromNib];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self adjustFontSizeToFillItsContents];
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self adjustFontSizeToFillItsContents];
    }
    return self;
}

- (void)adjustFontSizeToFillItsContents
{
    if (self.titleLabel.font) {
        //为hook铺垫
        self.titleLabel.font = [UIFont fontWithName:[self.titleLabel.font fontName] size:[self.titleLabel.font pointSize]];
    }
}

@end
