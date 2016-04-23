//
//  JYBSelectWayView.m
//  JianYunBao
//
//  Created by faith on 16/3/19.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBSelectWayView.h"
@interface JYBSelectWayView()
@property (nonatomic,strong) UIView *backGroundView;
@end
@implementation JYBSelectWayView
- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if(self)
  {
    self.frame =CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.backgroundColor = RGB(105, 105, 105);
    self.userInteractionEnabled = YES;
    [self setupView];
    
  }
  return self;
}
- (void)setupView
{
  self.backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-50, [UIScreen mainScreen].bounds.size.width -100, 0)];
  self.backGroundView.backgroundColor = [UIColor whiteColor];
  [self addSubview:self.backGroundView];
  UIButton *modelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Mwidth-40, 44)];
  modelButton.tag = 1;
  [modelButton setTitle:@"从模板创建" forState:UIControlStateNormal];
  [modelButton setTitleColor:RGB(172, 172, 172) forState:UIControlStateNormal];
  [self.backGroundView addSubview:modelButton];
  [modelButton addTarget:self action:@selector(modelAction:) forControlEvents:UIControlEventTouchUpInside];
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 45, Mwidth-40, 1)];
  view.backgroundColor = RGB(172, 172, 172);
  UIButton *customButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 46, Mwidth-40, 44)];
  customButton.tag = 2;
  [customButton setTitle:@"自定义" forState:UIControlStateNormal];
  [customButton setTitleColor:RGB(172, 172, 172) forState:UIControlStateNormal];
  [customButton addTarget:self action:@selector(modelAction:) forControlEvents:UIControlEventTouchUpInside];

  [self.backGroundView addSubview:modelButton];
  [self.backGroundView addSubview:view];
  [self.backGroundView addSubview:customButton];
  [self.backGroundView setFrame:CGRectMake(20, [UIScreen mainScreen].bounds.size.height-90-64-80, [UIScreen mainScreen].bounds.size.width-40, 90)];
  
}
- (void)modelAction:(UIButton *)sender;
{
  if(self.selectButtonBlock)
  {
    self.selectButtonBlock(sender.tag);
  }
}
@end
