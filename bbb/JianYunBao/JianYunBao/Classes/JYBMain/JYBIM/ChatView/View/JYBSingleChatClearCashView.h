//
//  JYBSingleChatClearCashView.h
//  JianYunBao
//
//  Created by 正 on 16/4/1.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JYBSingleChatClearCashViewDelegate <NSObject>

- (void)selectSingleSettingClearCash;

@end
@interface JYBSingleChatClearCashView : UIView

@property (assign, nonatomic) id <JYBSingleChatClearCashViewDelegate> delegate;

@end
