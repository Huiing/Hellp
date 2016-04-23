//
//  JYBFileTypeView.h
//  JianYunBao
//
//  Created by faith on 16/3/14.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DXRecordView.h"

typedef void(^ItemBlock)(NSInteger index);

@protocol JYBFileTypeViewDelegate <NSObject>

/**
 *  按下录音按钮开始录音
 */
- (void)didStartRecordingVoiceAction:(UIView *)recordView;
/**
 *  手指向上滑动取消录音
 */
- (void)didCancelRecordingVoiceAction:(UIView *)recordView;
/**
 *  松开手指完成录音
 */
- (void)didFinishRecoingVoiceAction:(UIView *)recordView;
/**
 *  当手指离开按钮的范围内时，主要为了通知外部的HUD
 */
- (void)didDragOutsideAction:(UIView *)recordView;
/**
 *  当手指再次进入按钮的范围内时，主要也是为了通知外部的HUD
 */
- (void)didDragInsideAction:(UIView *)recordView;

@end

@interface JYBFileTypeView : UIView
@property(nonatomic ,copy)ItemBlock itemBlock;

@property (strong, nonatomic) UIView *recordView;
@property (assign, nonatomic) id <JYBFileTypeViewDelegate> delegate;

//取消录音
- (void)cancelTouchRecord;

@end
