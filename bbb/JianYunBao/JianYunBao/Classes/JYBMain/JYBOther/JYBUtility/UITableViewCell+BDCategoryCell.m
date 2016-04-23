//
//  UITableViewCell+BDCategoryCell.m
//  
//
//  Created by 冰点 on 15/11/7.
//  Copyright © 2015年 冰点. All rights reserved.
//

#import "UITableViewCell+BDCategoryCell.h"

@implementation UITableViewCell (BDCategoryCell)

- (void)drawSeparatorOfCellContentView:(CGRect)rect
{
    [self drawSeparatorOfCellContentView:rect padding:0];
}

- (void)drawSeparatorOfCellContentView:(CGRect)rect padding:(CGFloat)padding
{
    CGContextRef cxt = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(cxt, 0.5);
    CGContextSetStrokeColorWithColor(cxt, [UIColor jyb_separatorColor].CGColor);
    CGContextMoveToPoint(cxt, 0.0 , self.frame.size.height - 0.5);
    CGContextAddLineToPoint(cxt,self.frame.size.width , self.frame.size.height - 0.5);
    CGContextStrokePath(cxt);
}

@end
