//
//  UITableViewCell+BDCategoryCell.h
//
//
//  Created by 冰点 on 15/11/7.
//  Copyright © 2015年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (BDCategoryCell)

- (void)drawSeparatorOfCellContentView:(CGRect)rect;
- (void)drawSeparatorOfCellContentView:(CGRect)rect padding:(CGFloat)padding;

@end

/*
 注意：前提要设置`cell.backgroundColor = [UIColor clearColor];`否则无效果
 */