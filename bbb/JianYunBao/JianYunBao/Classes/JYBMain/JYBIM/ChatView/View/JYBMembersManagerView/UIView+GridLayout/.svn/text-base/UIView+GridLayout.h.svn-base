//
//  UIView+GridLayout.h
//  OAS
//
//  Created by C-147 on 13-1-17.
//
//

#import <UIKit/UIKit.h>

@interface UIView (GridLayout)

/**
 *表格布局(根据Subview的大小来平均分布)
 */
-(CGSize)layoutSubviewsWithPadding:(CGPoint)padding spacing:(CGPoint)spacing;

/**
 *表格布局(根据每行固定的单元格大小来平均分布)
 */
-(CGSize)layoutSubviewsWithSize:(CGSize)size paddingY:(CGFloat)paddingY spacing:(CGPoint)spacing;

/**
 *表格布局(根据每行固定的单元格数目来平均分布)
 */
-(CGSize)layoutSubviewsWithPadding:(CGPoint)padding spacing:(CGPoint)spacing column:(NSInteger)column;

/**
 *表格布局(根据固定的单元格大小来平均分布)
 */
-(CGSize)layoutSubviewsWithSize:(CGSize)size spacing:(CGPoint)spacing;

/**
 *表格布局(根据每行固定的单元格大小及数目来平均分布)
 */
-(CGSize)layoutSubviewsWithSize:(CGSize)size padding:(CGPoint)padding column:(NSInteger)column;

@end
