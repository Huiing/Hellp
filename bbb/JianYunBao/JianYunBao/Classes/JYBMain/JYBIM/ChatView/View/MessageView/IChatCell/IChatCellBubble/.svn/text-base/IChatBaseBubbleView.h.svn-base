//
//  IChatBaseBubbleView.h
//  BDSocketIM
//
//  Created by 冰点 on 16/3/2.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYBIChatMessage.h"
#import "UIResponder+Router.h"
#import "NSString+BDPath.h"
#import "UIImage+BDVideoThumbnail.h"

extern NSString *const kRouterEventChatCellBubbleTapEventName;

#define BUBBLE_LEFT_IMAGE_NAME @"chat_receiver_bg" // bubbleView 的背景图片
#define BUBBLE_RIGHT_IMAGE_NAME @"chat_sender_bg"
#define BUBBLE_ARROW_WIDTH 5 // bubbleView中，箭头的宽度
#define BUBBLE_VIEW_PADDING 8 // bubbleView 与 在其中的控件内边距

#define BUBBLE_RIGHT_LEFT_CAP_WIDTH 5 // 文字在右侧时,bubble用于拉伸点的X坐标
#define BUBBLE_RIGHT_TOP_CAP_HEIGHT 35 // 文字在右侧时,bubble用于拉伸点的Y坐标//35

#define BUBBLE_LEFT_LEFT_CAP_WIDTH 35 // 文字在左侧时,bubble用于拉伸点的X坐标//35
#define BUBBLE_LEFT_TOP_CAP_HEIGHT 35 // 文字在左侧时,bubble用于拉伸点的Y坐标//35

#define BUBBLE_PROGRESSVIEW_HEIGHT 10 // progressView 高度

#define KMESSAGEKEY @"message"

@interface IChatBaseBubbleView : UIView
{
    JYBIChatMessage *_model;
}

@property (nonatomic, strong) JYBIChatMessage *model;
@property (nonatomic, strong) UIImageView *backImageView;

@property (nonatomic, readonly, assign) BOOL isSender;

- (void)bubbleViewPressed:(id)sender;
+ (CGFloat)heightForBubbleWithObject:(JYBIChatMessage *)object;

@end
