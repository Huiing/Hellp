//
//  JYBNonDataLogoView.m
//  JianYunBao
//
//  Created by 冰点 on 16/3/15.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBNonDataLogoView.h"
#import "NSString+BDExtension.h"

#define MAX_SIZE 60

@implementation JYBNonDataLogoView
@synthesize logoImgView = _logoImgView;
@synthesize titleLabel = _titleLabel;
@synthesize syncButton = _syncButton;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _logoImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_logoImgView setImage:[UIImage imageNamed:@"暂无消息"]];
        
        _titleLabel = [[JYBLabel alloc] initWithFrame:CGRectZero];
        _titleLabel.text = @"暂无数据";
        _titleLabel.textColor = JYBBlackColor;
        _titleLabel.font = JYBFont(13);
        
        _syncButton = [JYBButton buttonWithType:UIButtonTypeCustom];
        [_syncButton setBackgroundColor:[UIColor jyb_mainColor]];
        [_syncButton setTitle:@"同步数据" forState:UIControlStateNormal];
        _syncButton.titleLabel.font = JYBFont(14);
        
        [_syncButton addTarget:self action:@selector(didSyncClick) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self addSubview:_logoImgView];
        [self addSubview:_titleLabel];
        [self addSubview:_syncButton];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize retSize = [UIImage imageNamed:@"暂无消息"].size;
    if (retSize.width > retSize.height) {
        CGFloat height =  MAX_SIZE / retSize.width  *  retSize.height;
        retSize.height = height;
        retSize.width = MAX_SIZE;
    }else {
        CGFloat width = MAX_SIZE / retSize.height * retSize.width;
        retSize.width = width;
        retSize.height = MAX_SIZE;
    }
    _logoImgView.size = retSize;
    
     CGSize titleSize = [@"暂无数据" sizeWithFont:_titleLabel.font maxSize:CGSizeMake(self.width, self.height/2.0)];
    _titleLabel.size = titleSize;
    CGSize buttonSize = [@"同步数据" sizeWithFont:_syncButton.titleLabel.font maxSize:CGSizeMake(self.width, self.height/2.0)];
    _syncButton.width = buttonSize.width + 20 * 2;
    _syncButton.height = buttonSize.height + 10;
    _syncButton.layer.cornerRadius = 5;
    _syncButton.layer.masksToBounds = YES;
    
    _logoImgView.centerX = self.centerX;
    _titleLabel.centerX = self.centerX;
    _syncButton.centerX  = self.centerX;
    
    _logoImgView.y = self.centerY;
    _titleLabel.y = _logoImgView.bottom + 10;
    _syncButton.y = _titleLabel.bottom + 10;
    
}

- (void)didSyncClick
{
    if (_delegate && [_delegate respondsToSelector:@selector(nonDatalogoView:didSelectedSyncAction:)]) {
        [_delegate nonDatalogoView:self didSelectedSyncAction:_syncButton];
    }
}
@end
