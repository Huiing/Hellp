//
//  JYBTextField.h
//  JianYunBao
//
//  Created by 冰点 on 16/1/28.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface JYBTextField : UIView
{
    UITextField *_textField;
    NSString *_placeholder;
}

@property (nullable, nonatomic, strong) UITextField *textField;
@property(nullable, nonatomic,copy) IBInspectable NSString *placeholder;          // default is nil.

@end
