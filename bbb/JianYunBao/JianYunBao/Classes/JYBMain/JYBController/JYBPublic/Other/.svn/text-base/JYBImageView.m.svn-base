//
//  JYBImageView.m
//  JianYunBao
//
//  Created by 冰点 on 16/1/27.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBImageView.h"

@implementation JYBImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
            self.contentMode = UIViewContentModeScaleAspectFit;
        self.clipsToBounds = YES;
        self.opaque = YES;
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.userInteractionEnabled = YES;
    self.contentMode = UIViewContentModeScaleAspectFit;
    self.clipsToBounds = YES;
    self.opaque = YES;
}

- (void)layoutSubviews
{
    [self setCornerRadius];
}

- (void)setCornerRadius
{
    self.layer.cornerRadius = 5.0;
    self.layer.masksToBounds = YES;
    self.clipsToBounds = YES;
}

#pragma mark - public
- (void)addTarget:(id)target action:(SEL)action
{
    _target = target;
    _action = action;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    SuppressPerformSelectorLeakWarning(
                                       [_target performSelector:_action withObject:self];
                                       );
}

@end
