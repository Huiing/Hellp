//
//  JYBNonDataLogoView.h
//  JianYunBao
//
//  Created by 冰点 on 16/3/15.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYBButton.h"

@class JYBNonDataLogoView;
@protocol JYBNonDataLogoViewDelegate <NSObject>

@optional
- (void)nonDatalogoView:(JYBNonDataLogoView *)ndlogoView didSelectedSyncAction:(JYBButton *)syncButton;

@end

@interface JYBNonDataLogoView : UIView
{
    @private
    UIImageView * _logoImgView;
    JYBLabel * _titleLabel;
    JYBButton *_syncButton;
}

@property (nonatomic, readonly) UIImageView *logoImgView;
@property (nonatomic, readonly) JYBLabel *titleLabel;
@property (nonatomic, readonly) JYBButton *syncButton;

@property (nonatomic, weak) id <JYBNonDataLogoViewDelegate> delegate;

@end
