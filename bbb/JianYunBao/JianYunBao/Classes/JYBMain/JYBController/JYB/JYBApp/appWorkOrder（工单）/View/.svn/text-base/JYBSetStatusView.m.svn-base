//
//  JYBSetStatusView.m
//  JianYunBao
//
//  Created by faith on 16/3/19.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBSetStatusView.h"
@interface JYBSetStatusView()
@property (nonatomic,strong) UIView *backGroundView;

@end
@implementation JYBSetStatusView

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
  UILabel *headView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Mwidth-40, 44)];
  headView.backgroundColor = RGB(24, 88, 147);
  headView.textAlignment = NSTextAlignmentCenter;
  headView.textColor = [UIColor whiteColor];
  headView.text = @"设置状态";
    
  UIView *completView = [[UIView alloc] initWithFrame:CGRectMake(0,44, Mwidth -40, 44)];
  UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 7, 40, 30)];
   
  
  [completView addSubview:label1];
  UIButton *status1 = [[UIButton alloc] initWithFrame:CGRectMake(Mwidth - 65, 15, 15, 15)];
  [status1 setBackgroundImage:[UIImage imageNamed:@"选择"] forState:UIControlStateNormal];
  [status1 addTarget:self action:@selector(buttonAction1:) forControlEvents:UIControlEventTouchUpInside];
  status1.tag = 1;
  [completView addSubview:status1];
  UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 89, Mwidth - 40, 1)];
  lineView.backgroundColor = RGB(172, 172, 172);
  [self.backGroundView addSubview:lineView];
  UIView *pauseView = [[UIView alloc] initWithFrame:CGRectMake(0, 90,Mwidth - 40, 44)];
  UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 7, 40, 30)];
    NSLog(@"11------%@",self.state);
    if ([self.state isEqualToString:@"0"])
    {
        label1.text = @"完成";
        label2.text = @"暂停";
    }
    else if ([self.state isEqualToString:@"1"])
    {
        label1.text = @"执行中";
        lineView.hidden = YES;
    }
    else if ([self.state isEqualToString:@"2"])
    {
        label1.text = @"完成";
        label2.text = @"执行中";
    }
  [pauseView addSubview:label2];
  UIButton *status2 = [[UIButton alloc] initWithFrame:CGRectMake(Mwidth - 65, 15, 15, 15)];
  status2.tag = 2;
  [status2 setBackgroundImage:[UIImage imageNamed:@"选择"] forState:UIControlStateNormal];
  [status2 addTarget:self action:@selector(buttonAction2:) forControlEvents:UIControlEventTouchUpInside];
  [pauseView addSubview:status2];
  
  UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 134, Mwidth-40, 44)];
  bottomView.backgroundColor = RGB(232, 232, 232);
  [self.backGroundView addSubview:bottomView];
  UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(40, 7, (Mwidth - 40)/2-40-30, 30)];
  [btn1 setTitle:@"取消" forState:UIControlStateNormal];
  [btn1 setTitleColor:RGB(55, 170, 208) forState:UIControlStateNormal];
  [btn1 setBackgroundColor:[UIColor yellowColor]];
  [btn1 addTarget:self action:@selector(btnAction1:) forControlEvents:UIControlEventTouchUpInside];
  btn1.titleLabel.font = [UIFont systemFontOfSize:15];
  [btn1 setBackgroundColor:RGB(208, 208, 208)];
  btn1.layer.cornerRadius = 5;
  [btn1 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
  [bottomView addSubview:btn1];
  UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake((Mwidth - 40)/2 +30, 7, (Mwidth - 40)/2-40-30, 30)];
  [btn2 setTitle:@"确定" forState:UIControlStateNormal];
  [btn2 setTitleColor:RGB(55, 170, 208) forState:UIControlStateNormal];
  btn2.layer.cornerRadius = 5;
  [btn2 setBackgroundColor:RGB(249, 130, 65)];
  [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  
  btn2.titleLabel.font = [UIFont systemFontOfSize:15];
  [btn2 addTarget:self action:@selector(btnAction2:) forControlEvents:UIControlEventTouchUpInside];
  [bottomView addSubview:btn2];
  [self.backGroundView addSubview:completView];
  [self.backGroundView addSubview:pauseView];
  [self.backGroundView addSubview:headView];
  [self.backGroundView setFrame:CGRectMake(20, [UIScreen mainScreen].bounds.size.height-178-64-80, [UIScreen mainScreen].bounds.size.width-40, 178)];

}
- (void)btnAction1:(UIButton *)sender
{
  NSLog(@"ddd");
  if (self.delegate != nil &&[self.delegate respondsToSelector:@selector(cancleStatusAction)]) {
    [self.delegate cancleStatusAction];
  }
}
- (void)btnAction2:(UIButton *)sender
{
  NSLog(@"ddd2");
  if (self.delegate != nil &&[self.delegate respondsToSelector:@selector(confirmStatusAction)]) {
    [self.delegate confirmStatusAction];
  }
}
- (void)buttonAction1:(UIButton *)sender
{
  UIButton *btn = [self viewWithTag:2];
  sender.selected = !sender.selected;
    [self.delegate passStatu:1];
  if(sender.selected)
  {
    [sender setBackgroundImage:[UIImage imageNamed:@"选择上"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"选择"] forState:UIControlStateNormal];
    btn.selected = NO;
  }
  else
  {
    [sender setBackgroundImage:[UIImage imageNamed:@"选择"] forState:UIControlStateNormal];
  }
  if(sender.selected && self.delegate != nil &&[self.delegate respondsToSelector:@selector(passStatu:)])
  {
    [self.delegate passStatu:1];
  }
}
- (void)buttonAction2:(UIButton *)sender
{
  UIButton *btn = [self viewWithTag:1];
  sender.selected = !sender.selected;
    [self.delegate passStatu:2];
  if(sender.selected)
  {
    [sender setBackgroundImage:[UIImage imageNamed:@"选择上"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"选择"] forState:UIControlStateNormal];
    btn.selected = NO;
  }
  else
  {
    [sender setBackgroundImage:[UIImage imageNamed:@"选择"] forState:UIControlStateNormal];
  }
  if(sender.selected && self.delegate != nil &&[self.delegate respondsToSelector:@selector(passStatu:)])
  {
    [self.delegate passStatu:2];
  }

}


@end
