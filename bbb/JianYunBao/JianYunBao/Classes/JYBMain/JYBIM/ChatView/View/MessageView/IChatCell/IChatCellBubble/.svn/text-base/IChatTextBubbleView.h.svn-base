//
//  IChatTextBubbleView.h
//  BDSocketIM
//
//  Created by 冰点 on 16/3/2.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "IChatBaseBubbleView.h"

#define TEXTLABEL_MAX_WIDTH 200 // textLaebl 最大宽度
#define LABEL_FONT_SIZE 14      // 文字大小
#define LABEL_LINESPACE 0       // 行间距

extern NSString *const kRouterEventTextURLTapEventName;
extern NSString *const kRouterEventMenuTapEventName;

@interface IChatTextBubbleView : IChatBaseBubbleView
{
    NSDataDetector *_detector;
    NSArray *_urlMatches;
}

@property (nonatomic, strong) UILabel *textLabel;
+ (CGFloat)lineSpacing;
+ (UIFont *)textLabelFont;
+ (NSLineBreakMode)textLabelLineBreakModel;
- (void)highlightLinksWithIndex:(CFIndex)index;

@end
