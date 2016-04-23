//
//  IChatBaseBubbleView.m
//  BDSocketIM
//
//  Created by 冰点 on 16/3/2.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "IChatBaseBubbleView.h"

NSString *const kRouterEventChatCellBubbleTapEventName = @"kRouterEventChatCellBubbleTapEventName";

@interface IChatBaseBubbleView ()

@property (nonatomic, assign) BOOL isSender;

@end

@implementation IChatBaseBubbleView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        _backImageView = [[UIImageView alloc] init];
        _backImageView.backgroundColor = self.backgroundColor;
        _backImageView.userInteractionEnabled = YES;
        _backImageView.multipleTouchEnabled = YES;
        _backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:_backImageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bubbleViewPressed:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)setModel:(JYBIChatMessage *)model
{
    _model = model;
    self.isSender = [[RuntimeStatus sharedInstance].userItem.userId isEqualToString:model.fromUserID];
    NSString *imageName = !self.isSender ? BUBBLE_LEFT_IMAGE_NAME : BUBBLE_RIGHT_IMAGE_NAME;
    NSInteger leftCapWidth = !self.isSender?BUBBLE_LEFT_LEFT_CAP_WIDTH:BUBBLE_RIGHT_LEFT_CAP_WIDTH;
    NSInteger topCapHeight =  !self.isSender?BUBBLE_LEFT_TOP_CAP_HEIGHT:BUBBLE_RIGHT_TOP_CAP_HEIGHT;
    self.backImageView.image = [[UIImage imageNamed:imageName] stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
}

#pragma mark - public
- (void)bubbleViewPressed:(id)sender
{
    [self routerEventWithName:kRouterEventChatCellBubbleTapEventName userInfo:@{KMESSAGEKEY:self.model}];
}

+ (CGFloat)heightForBubbleWithObject:(JYBIChatMessage *)object;
{
    return 30;
}

@end
