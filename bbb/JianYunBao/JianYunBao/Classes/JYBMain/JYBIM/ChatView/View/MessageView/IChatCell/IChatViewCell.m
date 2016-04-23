//
//  IChatViewCell.m
//  BDSocketIM
//
//  Created by 冰点 on 16/3/2.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "IChatViewCell.h"

NSString *const kResendButtonTapEventName = @"kResendButtonTapEventName";
NSString *const kShouldResendCell = @"kShouldResendCell";

@implementation IChatViewCell

- (instancetype)initWithMessageModel:(JYBIChatMessage *)model reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithMessageModel:model reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.headImageView.clipsToBounds = YES;
        self.headImageView.layer.cornerRadius = 3.0;
        
    }
    return self;
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGRect bubbleFrame = _bubbleView.frame;
    bubbleFrame.origin.y = self.headImageView.frame.origin.y;
    
    if (self.isSender) {
        bubbleFrame.origin.y = self.headImageView.frame.origin.y;
        bubbleFrame.origin.x = self.headImageView.frame.origin.x - bubbleFrame.size.width - HEAD_PADDING;
        _bubbleView.frame = bubbleFrame;
    } else {
        bubbleFrame.origin.x = HEAD_PADDING * 2 + HEAD_SIZE;
        _bubbleView.frame = bubbleFrame;
    }
}

- (void)setMessageEntity:(JYBIChatMessage *)messageEntity
{
    [super setMessageEntity:messageEntity];
    _bubbleView.model = self.messageEntity;
    [_bubbleView sizeToFit];
}

#pragma mark - action

// 重发按钮事件
-(void)retryButtonPressed:(UIButton *)sender
{
    [self routerEventWithName:kResendButtonTapEventName
                     userInfo:@{kShouldResendCell:self}];
}

#pragma mark - private
- (void)setupSubviewsForMessageModel:(JYBIChatMessage *)model
{
    [super setupSubviewsForMessageModel:model];
    if (self.isSender) {
        
    } else {
        
    }
    _bubbleView = [self bubbleViewForMessageModel:model];
    [self.contentView addSubview:_bubbleView];
}

- (IChatBaseBubbleView *)bubbleViewForMessageModel:(JYBIChatMessage *)messageModel
{
    switch (messageModel.messageBodyType) {
        case JYBIMMessageBodyTypeText:
            return [[IChatTextBubbleView alloc] init];
            break;
        case JYBIMMessageBodyTypeAudio:
            return [[IChatAudioBubbleView alloc] init];
            break;
        case JYBIMMessageBodyTypeImage:
            return [[IChatImageBubbleView alloc] init];
            break;
        case JYBIMMessageBodyTypeVideo:
            return [[IChatVideoBubbleView alloc] init];
            break;
        default:
            return [[IChatFileBubbleView alloc] init];
            break;
    }
    return nil;
}

+ (CGFloat)bubbleViewHeightForMessageModel:(JYBIChatMessage *)messageModel
{
    switch (messageModel.messageBodyType) {
        case JYBIMMessageBodyTypeText:
            return [IChatTextBubbleView heightForBubbleWithObject:messageModel];
            break;
        case JYBIMMessageBodyTypeAudio:
            return [IChatAudioBubbleView heightForBubbleWithObject:messageModel];
            break;
        case JYBIMMessageBodyTypeImage:
            return [IChatImageBubbleView heightForBubbleWithObject:messageModel];
            break;
        case JYBIMMessageBodyTypeVideo:
            return [IChatVideoBubbleView heightForBubbleWithObject:messageModel];
            break;
        case JYBIMMessageBodyTypeFile:
            return [IChatFileBubbleView heightForBubbleWithObject:messageModel];
            break;
        default:
            break;
    }
    return HEAD_SIZE;
}

#pragma mark - public
+ (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath withObject:(JYBIChatMessage *)model
{
    NSInteger bubbleHeight = [self bubbleViewHeightForMessageModel:model];
    NSInteger headHeight = HEAD_PADDING * 2 + HEAD_SIZE;
    BOOL isSender = [self isSender:model];
    if (isSender) {
        headHeight += NAME_LABEL_HEIGHT;
    }

    return MAX(headHeight, bubbleHeight + NAME_LABEL_HEIGHT + NAME_LABEL_PADDING) + CELLPADDING;
}



@end
