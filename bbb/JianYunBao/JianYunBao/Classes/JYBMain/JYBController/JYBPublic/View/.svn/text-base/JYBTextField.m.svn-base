//
//  JYBTextField.m
//  JianYunBao
//
//  Created by 冰点 on 16/1/28.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBTextField.h"

@implementation JYBTextField
@synthesize textField = _textField;
@synthesize placeholder = _placeholder;

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor whiteColor];
    [self setupTextField];
}

- (void)setupTextField
{
    _textField = [UITextField new];
    _textField.borderStyle = UITextBorderStyleNone;
    _textField.backgroundColor = [UIColor clearColor];
    _textField.placeholder = _placeholder;
    [self addSubview:_textField];
}

- (void)layoutSubviews
{
    _textField.frame = CGRectMake(Compose_Scale(5), 0, self.width, self.height);
}


@end
