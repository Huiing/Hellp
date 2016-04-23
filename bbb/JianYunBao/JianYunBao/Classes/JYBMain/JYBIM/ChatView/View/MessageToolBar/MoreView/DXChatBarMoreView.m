/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import "DXChatBarMoreView.h"

#define CHAT_BUTTON_SIZE 50
#define INSETS 8
#define ITEM_LABEL_HEIGHT 20

@implementation DXChatBarMoreView

- (instancetype)initWithFrame:(CGRect)frame type:(ChatMoreType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setupSubviewsForType:type];
    }
    return self;
}

- (void)setupSubviewsForType:(ChatMoreType)type
{
    self.backgroundColor = [UIColor clearColor];
    CGFloat insets = (self.frame.size.width - 4 * CHAT_BUTTON_SIZE) / 5;
    
    _takePicButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [_takePicButton setFrame:CGRectMake(insets, 10, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE)];
    [_takePicButton setBackgroundImage:[UIImage imageNamed:@"照片1"] forState:UIControlStateNormal];
    [_takePicButton addTarget:self action:@selector(takePicAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_takePicButton];
    
    _photoButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [_photoButton setFrame:CGRectMake(insets * 2 + CHAT_BUTTON_SIZE, 10, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE)];
    [_photoButton setBackgroundImage:[UIImage imageNamed:@"图片1"] forState:UIControlStateNormal];
    [_photoButton addTarget:self action:@selector(photoAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_photoButton];
    
    _videoButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [_videoButton setFrame:CGRectMake(insets * 3 + CHAT_BUTTON_SIZE * 2, 10, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE)];
    [_videoButton setBackgroundImage:[UIImage imageNamed:@"视频1"] forState:UIControlStateNormal];
    [_videoButton addTarget:self action:@selector(takeVideoCallAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_videoButton];
    
    _fileButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [_fileButton setFrame:CGRectMake(insets * 4 + CHAT_BUTTON_SIZE * 3, 10, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE)];
    [_fileButton setBackgroundImage:[UIImage imageNamed:@"文件1"] forState:UIControlStateNormal];
    [_fileButton addTarget:self action:@selector(takeFileAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_fileButton];
    
    
    _takePicLabel = [[UILabel alloc] initWithFrame:CGRectMake(_takePicButton.x, _takePicButton.y + _takePicButton.height, _takePicButton.width, ITEM_LABEL_HEIGHT)];
    _takePicLabel.textColor = JYBBlackColor;
    _takePicLabel.textAlignment = NSTextAlignmentCenter;
    _takePicLabel.font = JYBFont(12);
    _takePicLabel.text = @"拍照";
    [self addSubview:_takePicLabel];
    
    _photoLabel = [[UILabel alloc] initWithFrame:CGRectMake(_photoButton.x, _photoButton.y + _photoButton.height, _photoButton.width, ITEM_LABEL_HEIGHT)];
    _photoLabel.textColor = JYBBlackColor;
    _photoLabel.textAlignment = NSTextAlignmentCenter;
    _photoLabel.font = JYBFont(12);
    _photoLabel.text = @"照片";
    [self addSubview:_photoLabel];
    
    _videoLabel = [[UILabel alloc] initWithFrame:CGRectMake(_videoButton.x, _videoButton.y + _videoButton.height, _videoButton.width, ITEM_LABEL_HEIGHT)];
    _videoLabel.textColor = JYBBlackColor;
    _videoLabel.textAlignment = NSTextAlignmentCenter;
    _videoLabel.font = JYBFont(12);
    _videoLabel.text = @"视频";
    [self addSubview:_videoLabel];
    
    _fileLabel = [[UILabel alloc] initWithFrame:CGRectMake(_fileButton.x, _fileButton.y + _fileButton.height, _fileButton.width, ITEM_LABEL_HEIGHT)];
    _fileLabel.textColor = JYBBlackColor;
    _fileLabel.textAlignment = NSTextAlignmentCenter;
    _fileLabel.font = JYBFont(12);
    _fileLabel.text = @"文件";
    [self addSubview:_fileLabel];
//    self.frame = frame;
}

#pragma mark - action

- (void)takePicAction{
    if(_delegate && [_delegate respondsToSelector:@selector(moreViewTakePicAction:)]){
        [_delegate moreViewTakePicAction:self];
    }
}

- (void)photoAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(moreViewPhotoAction:)]) {
        [_delegate moreViewPhotoAction:self];
    }
}

- (void)takeVideoCallAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(moreViewVideoAction:)]) {
        [_delegate moreViewVideoAction:self];
    }
}

- (void)takeFileAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(moreViewFileAction:)]) {
        [_delegate moreViewFileAction:self];
    }
}

@end
