//
//  IChatImageBubbleView.m
//  JianYunBao
//
//  Created by 冰点 on 16/3/2.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "IChatImageBubbleView.h"

NSString *const kRouterEventImageBubbleTapEventName = @"kRouterEventImageBubbleTapEventName";

CGSize downLoadImageSourceWithURL(NSString * imgUrlString)
{
    NSURL * url = [NSURL URLWithString:imgUrlString];
    UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [imgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"imageDownloadFail.png"]];
    return imgView.image.size;
}

@implementation IChatImageBubbleView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
    }
    
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize retSize = downLoadImageSourceWithURL(JYBImageUrl(self.model.remoteUrl));
    CGSize scaleSize = [self transToScaleSize:retSize];
    return CGSizeMake(scaleSize.width + BUBBLE_VIEW_PADDING * 2 + BUBBLE_ARROW_WIDTH, 2 * BUBBLE_VIEW_PADDING + scaleSize.height);
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame = self.bounds;
    frame.size.width -= BUBBLE_ARROW_WIDTH;
    frame = CGRectInset(frame, BUBBLE_VIEW_PADDING, BUBBLE_VIEW_PADDING);
    if (self.isSender) {
        frame.origin.x = BUBBLE_VIEW_PADDING;
    }else{
        frame.origin.x = BUBBLE_VIEW_PADDING + BUBBLE_ARROW_WIDTH;
    }
    
    frame.origin.y = BUBBLE_VIEW_PADDING;
    [self.imageView setFrame:frame];
}

#pragma mark - setter
- (CGSize)transToScaleSize:(CGSize)size
{
    CGSize retSize = size;
    if (retSize.width == 0 || retSize.height == 0) {
        retSize.width = MAX_SIZE;
        retSize.height = MAX_SIZE;
    }
    if (retSize.width > retSize.height) {
        CGFloat height =  MAX_SIZE / retSize.width  *  retSize.height;
        retSize.height = height;
        retSize.width = MAX_SIZE;
    }else {
        CGFloat width = MAX_SIZE / retSize.height * retSize.width;
        retSize.width = width;
        retSize.height = MAX_SIZE;
    }
    return retSize;
}
- (void)setModel:(JYBIChatMessage *)model
{
    [super setModel:model];
    
    UIImage *image = _model.image;
    if (!image) {
        if (model.videoThumbnailPath) {
            self.imageView.image = [UIImage imageWithContentsOfFile:[JYB_LibraryDirectoryPath() stringByAppendingString:model.videoThumbnailPath]];
        }
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:JYBImageUrl(model.remoteUrl)] placeholderImage:[UIImage imageNamed:@"imageDownloadFail.png"]];
    } else {
        self.imageView.image = image;
    }
}

#pragma mark - public
-(void)bubbleViewPressed:(id)sender
{
    [self routerEventWithName:kRouterEventImageBubbleTapEventName
                     userInfo:@{KMESSAGEKEY:self.model}];
}

+(CGFloat)heightForBubbleWithObject:(JYBIChatMessage *)object
{
    CGSize retSize = CGSizeZero;
    if (object.remoteUrl != nil) {
        retSize = downLoadImageSourceWithURL(JYBImageUrl(object.remoteUrl));
    }
    
    if (retSize.width == 0 || retSize.height == 0) {
        retSize.width = MAX_SIZE;
        retSize.height = MAX_SIZE;
    }else if (retSize.width > retSize.height) {
        CGFloat height =  MAX_SIZE / retSize.width  *  retSize.height;
        retSize.height = height;
        retSize.width = MAX_SIZE;
    }else {
        CGFloat width = MAX_SIZE / retSize.height * retSize.width;
        retSize.width = width;
        retSize.height = MAX_SIZE;
    }
    return 2 * BUBBLE_VIEW_PADDING + retSize.height;
}

@end
