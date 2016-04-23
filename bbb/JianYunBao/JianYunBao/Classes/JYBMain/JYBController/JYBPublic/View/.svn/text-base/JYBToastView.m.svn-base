//
//  JYBToastView.m
//  JianYunBao
//
//  Created by faith on 16/3/12.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBToastView.h"
@interface JYBToastView()
@property (nonatomic,strong) UIView *backGroundView;
@end
@implementation JYBToastView

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
  headView.text = @"添加子任务";
  [self.backGroundView addSubview:headView];
  UILabel *orderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 100, 20)];
  orderLabel.text = @"顺序号";
  orderLabel.textAlignment = NSTextAlignmentRight;
  [self.backGroundView addSubview:orderLabel];
  _orderTextField = [[UITextField alloc] initWithFrame:CGRectMake(110, 50, Mwidth - 160, 40)];
  _orderTextField.borderStyle = UITextBorderStyleRoundedRect;
  [self.backGroundView addSubview:_orderTextField];
  UILabel *taskLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 110, 100, 20)];
  taskLabel.text = @"任务名称";
  taskLabel.textAlignment = NSTextAlignmentRight;
  [self.backGroundView addSubview:taskLabel];
  _taskTextField = [[UITextField alloc] initWithFrame:CGRectMake(110, 100, Mwidth - 160, 40)];
  _taskTextField.borderStyle = UITextBorderStyleRoundedRect;
  [self.backGroundView addSubview:_taskTextField];
  UILabel *describeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 160, 100, 20)];
  describeLabel.text = @"描述";
  describeLabel.textAlignment = NSTextAlignmentRight;
  [self.backGroundView addSubview:describeLabel];
  _describeTextView = [[UITextView alloc] initWithFrame:CGRectMake(110, 150, Mwidth - 160, 80)];
  _describeTextView.layer.cornerRadius = 5;
  _describeTextView.layer.borderColor = RGB(171, 171, 171).CGColor;
  _describeTextView.layer.borderWidth = 1;
  [self.backGroundView addSubview:_describeTextView];
  UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 240, Mwidth - 40, 44)];
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
  [self.backGroundView setFrame:CGRectMake(20, [UIScreen mainScreen].bounds.size.height-284-64, [UIScreen mainScreen].bounds.size.width-40, 284)];
  //    [UIView animateWithDuration:0.5 animations:^{
  //        [self.backGroundView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-284-64, [UIScreen mainScreen].bounds.size.width, 284)];
  //    } completion:^(BOOL finished) {
  //    }];
  
  
  
  
}
- (void)btnAction1:(UIButton *)sender
{
  NSLog(@"ddd");
  if (self.delegate != nil &&[self.delegate respondsToSelector:@selector(cancleAction)]) {
    [self.delegate cancleAction];
  }
}
- (void)btnAction2:(UIButton *)sender
{
  NSLog(@"ddd2");
  if (self.delegate != nil &&[self.delegate respondsToSelector:@selector(confirmAction)]) {
    [self.delegate confirmAction];
  }
}

@end
