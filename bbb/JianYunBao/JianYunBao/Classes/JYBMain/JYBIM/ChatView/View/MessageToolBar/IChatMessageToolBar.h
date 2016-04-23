//
//  IChatMessageToolBar.h
//  BDSocketIM
//
//  Created by 冰点 on 16/3/2.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHMessageTextView.h"
#import "DXChatBarMoreView.h"
#import "DXRecordView.h"

#define kInputTextViewMinHeight 36
#define kInputTextViewMaxHeight 200
#define kHorizontalPadding 8
#define kVerticalPadding 5

#define kTouchToRecord @"按住说话"
#define kTouchToFinish @"松开发送"

typedef enum : NSUInteger {
    IChatMessageToolBarStyleChat = 0,//聊天室情况
    IChatMessageToolBarStyleComment,//评论情况
    IChatMessageToolBarStyleNone = IChatMessageToolBarStyleChat,
} IChatMessageToolBarStyle;

@protocol IChatMessageToolBarDelegate <NSObject>

@optional
/**
 *  在普通状态和语音状态之间进行切换时，会触发这个回调函数
 *
 *  @param changedToRecord 是否改为发送语音状态
 */
- (void)didStyleChangeToRecord:(BOOL)changedToRecord;

/**
 *  文字输入框开始编辑
 *
 *  @param inputTextView 输入框对象
 */
- (void)inputTextViewDidBeginEditing:(XHMessageTextView *)messageInputTextView;

/**
 *  文字输入框将要开始编辑
 *
 *  @param inputTextView 输入框对象
 */
- (void)inputTextViewWillBeginEditing:(XHMessageTextView *)messageInputTextView;

/**
 *  发送文字消息，可能包含系统自带表情
 *
 *  @param text 文字消息
 */
- (void)didSendText:(NSString *)text;

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

@required
/**
 *  高度变到toHeight
 */
- (void)didChangeFrameToHeight:(CGFloat)toHeight;

@end

@interface IChatMessageToolBar : UIView
@property (nonatomic, weak) id <IChatMessageToolBarDelegate> delegate;

@property (strong, nonatomic) UIButton *recordButton;
@property (strong, nonatomic) UIImage *toolbarBackgroundImage;
@property (strong, nonatomic) UIImage *backgroundImage;
@property (strong, nonatomic) UIView *moreView;
@property (strong, nonatomic) UIView *recordView;
@property (strong, nonatomic) XHMessageTextView *inputTextView;
/**
 *  文字输入区域最大高度，必须 > KInputTextViewMinHeight(最小高度)并且 < KInputTextViewMaxHeight，否则设置无效
 */
@property (nonatomic) CGFloat maxTextInputViewHeight;
- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic, assign) IChatMessageToolBarStyle toolBarStyle;

+ (CGFloat)defaultHeight;
- (void)cancelTouchRecord;
@end
