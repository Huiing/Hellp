//
//  SelectView.m
//  MySchoolMobile
//
//  Created by faith on 15/10/22.
//  Copyright (c) 2015年 faith. All rights reserved.
//

#import "SelectView.h"
#define BottomTag 10000
@interface SelectView()
{
  UIView *bottomView;
  BOOL isSelected;
}
@end
@implementation SelectView
- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if(self)
  {
    self.backgroundColor = [UIColor whiteColor];
    self.titleArr = [NSArray array];
    bottomView = [[UIView alloc] initWithFrame:CGRectMake(Mwidth/3, 47, Mwidth/3, 3)];
    bottomView.backgroundColor = JYBMainColor;
    [self addSubview:bottomView];
  }
  return self;
}
- (void)initSubView
{
  
  for(int i = 0 ; i< 3 ; i ++)
  {
    float width = Mwidth/3;
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i*width , 0, width, 44)];
    [btn setTitle:_titleArr[i] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    if(_type ==1)
    {
      if(i ==1)
      {
        [btn setTitleColor:JYBMainColor forState:UIControlStateNormal];
      }

    }
    else
    {
      if(i ==0)
      {
        [btn setTitleColor:JYBMainColor forState:UIControlStateNormal];
        bottomView.x = 0;
      }

    }
    btn.tag = i + BottomTag;
    [self addSubview:btn];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
  }
}
- (void)btnAction:(UIButton *)sender
{
  NSInteger tag = sender.tag;
  [sender setTitleColor:JYBMainColor forState:UIControlStateNormal];
  for(int i = BottomTag ; i < BottomTag +3 ; i ++)
  {
    UIButton *b = (UIButton *)[self viewWithTag:i];
    NSInteger otherButtonTag = b.tag;
    if(tag != otherButtonTag)
    {
      [b setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
  }
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    CGRect f = bottomView.frame;
    f.origin.x = f.size.width * (tag - BottomTag);
    bottomView.frame = f;
    [UIView commitAnimations];
    if(self.delegate&&[self.delegate respondsToSelector:@selector(didSelectedAtIndex:)])
    {
        [self.delegate didSelectedAtIndex:tag - BottomTag];

    }
//    [self.delegate didSelectedAtIndex:tag];
}
@end
