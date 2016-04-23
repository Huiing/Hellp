//
//  JYBFileTypeView.m
//  JianYunBao
//
//  Created by faith on 16/3/14.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBFileTypeView.h"

@implementation JYBFileTypeView
- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if(self)
  {
    [self configSubview];
  }
  return self;
}
- (void)configSubview
{
  self.userInteractionEnabled = YES;
  NSArray *imageArr = [NSArray arrayWithObjects:@"照片1", @"图片1",@"语音d",@"视频1",@"文件1",nil];
  NSArray *nameArr = @[@"拍照",@"图片",@"按住说话",@"视频",@"文件"];
  for(int i = 0; i <5 ; i++)
  {
    float left = Mwidth/5*i;
      UIView * background = [[UIView alloc] initWithFrame:CGRectMake(left, 0, Mwidth/5, 60)];
      background.userInteractionEnabled = YES;
      [self addSubview:background];
      
      UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
      [button setTag:i];
      [button setFrame:CGRectMake(10, 10, Mwidth/5-20, Mwidth/5-20)];
      [button setImage:[UIImage imageNamed:[imageArr objectAtIndex:i]] forState:UIControlStateNormal];
      [button addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
      //监听说话按钮状态
      if (i == 2){
          [button addTarget:self action:@selector(recordButtonTouchDown) forControlEvents:UIControlEventTouchDown];
          [button addTarget:self action:@selector(recordButtonTouchUpOutside) forControlEvents:UIControlEventTouchUpOutside];
          [button addTarget:self action:@selector(recordButtonDragInside) forControlEvents:UIControlEventTouchDragInside];
          [button addTarget:self action:@selector(recordButtonDragOutside) forControlEvents:UIControlEventTouchDragOutside];
      }
      [background addSubview:button];
      
      UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(0, Mwidth/5 - 5, Mwidth/5, 20)];
      nameLable.textAlignment = NSTextAlignmentCenter;
      nameLable.font = [UIFont systemFontOfSize:13];
      nameLable.text = nameArr[i];
      [background addSubview:nameLable];
  }
    if (!self.recordView) {
        self.recordView = [[DXRecordView alloc] initWithFrame:CGRectMake(90, 130, 140, 140)];
    }
}
//按钮点击事件
- (void)itemAction:(UIButton *)sender
{
  if(self.itemBlock)
  {
    self.itemBlock(sender.tag);
  }
    if (sender.tag == 2){
        [self recordButtonTouchUpInside];
    }

  NSLog(@"sender:%d",sender.tag);
}
- (void)recordButtonTouchDown
{
    if ([self.recordView isKindOfClass:[DXRecordView class]]) {
        [(DXRecordView *)self.recordView recordButtonTouchDown];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(didStartRecordingVoiceAction:)]) {
        [_delegate didStartRecordingVoiceAction:self.recordView];
    }
}

- (void)recordButtonTouchUpOutside
{
    if (_delegate && [_delegate respondsToSelector:@selector(didCancelRecordingVoiceAction:)])
    {
        [_delegate didCancelRecordingVoiceAction:self.recordView];
    }
    
    if ([self.recordView isKindOfClass:[DXRecordView class]]) {
        [(DXRecordView *)self.recordView recordButtonTouchUpOutside];
    }
    
    [self.recordView removeFromSuperview];
}

- (void)recordButtonTouchUpInside
{
    if ([self.recordView isKindOfClass:[DXRecordView class]]) {
        [(DXRecordView *)self.recordView recordButtonTouchUpInside];
    }
    
    if ([self.delegate respondsToSelector:@selector(didFinishRecoingVoiceAction:)])
    {
        [self.delegate didFinishRecoingVoiceAction:self.recordView];
    }
    
    [self.recordView removeFromSuperview];
}

- (void)recordButtonDragOutside
{
    if ([self.recordView isKindOfClass:[DXRecordView class]]) {
        [(DXRecordView *)self.recordView recordButtonDragOutside];
    }
    
    if ([self.delegate respondsToSelector:@selector(didDragOutsideAction:)])
    {
        [self.delegate didDragOutsideAction:self.recordView];
    }
}

- (void)recordButtonDragInside
{
    if ([self.recordView isKindOfClass:[DXRecordView class]]) {
        [(DXRecordView *)self.recordView recordButtonDragInside];
    }
    
    if ([self.delegate respondsToSelector:@selector(didDragInsideAction:)])
    {
        [self.delegate didDragInsideAction:self.recordView];
    }
}
/**
 *  取消触摸录音键
 */
- (void)cancelTouchRecord
{
    if ([_recordView isKindOfClass:[DXRecordView class]]) {
        [(DXRecordView *)_recordView recordButtonTouchUpInside];
        [_recordView removeFromSuperview];
    }
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
