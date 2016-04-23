//
//  UIView+BDIBInspectable.m
//  3J
//
//  Created by 冰点 on 15/11/22.
//  Copyright © 2015年 冰点. All rights reserved.
//

#import "UIView+BDIBInspectable.h"

@implementation UIView (BDIBInspectable)
@dynamic cornerRadius;
@dynamic borderColor;
@dynamic borderWidth;

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = (cornerRadius > 0) ? YES : NO;
    NSLog(@"BDIBInspectable = %.2f",cornerRadius);
}

- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
}


@end
