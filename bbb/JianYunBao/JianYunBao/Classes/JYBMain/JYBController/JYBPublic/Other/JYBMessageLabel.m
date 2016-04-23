//
//  JYBLabel.m
//  JianYunBao
//
//  Created by 冰点 on 16/1/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBMessageLabel.h"

@implementation JYBMessageLabel
@dynamic unreadCount;

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self configCornerRadius];
    [self setUnreadCount:0];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self configCornerRadius];
        [self setUnreadCount:0];
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self configCornerRadius];
        [self setUnreadCount:0];
    }
    return self;
}

- (void)configCornerRadius
{
    self.layer.cornerRadius = Compose_Scale(self.height / 2.0);
    self.layer.masksToBounds = YES;
}

- (void)setUnreadCount:(NSInteger)unreadCount
{
    _unreadCount = unreadCount;
    [self autoFontFit];
}

- (NSInteger)unreadCount
{
    return _unreadCount;
}

- (void)autoFontFit
{
    if (_unreadCount > 0) {
        if (_unreadCount <= 9) {
            self.font = JYBFont(13);
        }else if(_unreadCount > 9 && _unreadCount < 99){
            self.font = JYBFont(12);
        }else{
            self.font = JYBFont(10);
        }
        [self setHidden:NO];
        self.text = [NSString stringWithFormat:@"%ld",(long)_unreadCount];
    }else{
        [self setHidden:YES];
    }
}

@end
