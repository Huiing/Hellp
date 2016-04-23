//
//  JYBLabel.m
//  JianYunBao
//
//  Created by 冰点 on 16/1/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBLabel.h"

@implementation JYBLabel

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
    if (self.font) {
        //为hook铺垫
        self.font = [UIFont fontWithName:[self.font fontName] size:[self.font pointSize]];
    }
}

@end
