//
//  UIView+GridLayout.m
//  OAS
//
//  Created by C-147 on 13-1-17.
//
//

#import "UIView+GridLayout.h"

@implementation UIView (GridLayout)

/**
 *表格布局(根据Subview的大小来平均分布)
 */
-(CGSize)layoutSubviewsWithPadding:(CGPoint)padding spacing:(CGPoint)spacing{
    CGRect bounds = self.bounds;
    CGFloat width = bounds.size.width;
    CGFloat height = padding.y - spacing.y;
    int began = 0;
    int maxHeight = 0;
    CGFloat totalWidth = padding.x * 2 - spacing.x;
    for (int i = 0; i < self.subviews.count; i++) {
        UIView *view = self.subviews[i];
        CGRect frame = view.frame;
        totalWidth += (spacing.x + frame.size.width);
        if(totalWidth > width){
            int left = (width - (totalWidth - spacing.x - frame.size.width))/2 + padding.x;
            height += spacing.y;
            for (int j = began; j < i; j++) {
                UIView *sub = self.subviews[j];
                CGRect newFrame = sub.frame;
                newFrame.origin.x = left;
                newFrame.origin.y = height + (maxHeight - newFrame.size.height)/2;
                sub.frame = newFrame;
                left += spacing.x + newFrame.size.width;
            }
            height += maxHeight;
            began = i;
            maxHeight = frame.size.height;
            totalWidth = padding.x * 2 - frame.size.width;
        }else if(maxHeight < frame.size.height) {
            maxHeight = frame.size.height;
        }
    }
    //最后一行
    int left = padding.x;
    height += spacing.y;
    for (int j = began; j < self.subviews.count; j++) {
        UIView *sub = self.subviews[j];
        CGRect newFrame = sub.frame;
        newFrame.origin.x = left;
        newFrame.origin.y = height + (maxHeight - newFrame.size.height)/2;
        sub.frame = newFrame;
        left += spacing.x + newFrame.size.width;
    }
    height += maxHeight;
    
    height += padding.y;
    bounds.size.height = height;
    self.bounds = bounds;
    return self.bounds.size;
}

/**
 *表格布局(根据每行固定的单元格大小来平均分布)
 */
-(CGSize)layoutSubviewsWithSize:(CGSize)size paddingY:(CGFloat)paddingY spacing:(CGPoint)spacing{
    CGRect bounds = self.bounds;
    
    CGFloat width = bounds.size.width;
    NSInteger column = (width + spacing.x) / (size.width + spacing.x);
    CGFloat paddingX = (width + spacing.x - (size.width + spacing.x) * column) / 2;
    
    CGPoint padding = CGPointMake(paddingX, paddingY);
    CGPoint sizeAndSpacing = CGPointMake(size.width + spacing.x, size.height + spacing.y);
    
    int colCount = column;
    int rowCount = (self.subviews.count + colCount - 1) / colCount;
    
    for (int j = 0; j < rowCount; j++) {
        for (int k = 0; k < colCount; k++) {
            int index = j * colCount + k;
            if(index >= self.subviews.count){
                j = rowCount ;
                break;
            }
            UIView *item = self.subviews[index];
            CGRect frame = item.frame;
            frame.origin = CGPointMake(k * sizeAndSpacing.x + padding.x, j * sizeAndSpacing.y + padding.y);
            item.frame = frame;
        }
    }
    
    bounds.size.height = rowCount * sizeAndSpacing.y - spacing.y +  padding.y * 2;
    self.bounds = bounds;
    
    return self.bounds.size;
}
/**
 *表格布局(根据每行固定的单元格数目来平均分布)
 */
-(CGSize)layoutSubviewsWithPadding:(CGPoint)padding spacing:(CGPoint)spacing column:(NSInteger)column{
    CGFloat size = (self.bounds.size.width - spacing.x * 2 + padding.x) / column - padding.x;
    return [self layoutSubviewsWithSize:CGSizeMake(size, size) paddingY:padding.y spacing:spacing];
}

/**
 *表格布局(根据固定的单元格大小来平均分布)
 */
-(CGSize)layoutSubviewsWithSize:(CGSize)size spacing:(CGPoint)spacing{
    CGFloat width = self.bounds.size.width;
    NSInteger column = (width + spacing.x) / (size.width + spacing.x);
    CGFloat padding = (width + spacing.x - (size.width + spacing.x) * column) / 2;
    return [self layoutSubviewsWithSize:size paddingY:padding spacing:spacing];
}

/**
 *表格布局(根据每行固定的单元格大小及数目来平均分布)
 */
-(CGSize)layoutSubviewsWithSize:(CGSize)size padding:(CGPoint)padding column:(NSInteger)column{
    CGFloat spacing = (self.bounds.size.width - padding.x * 2 - size.width * column) / (column - 1);
    return [self layoutSubviewsWithSize:size paddingY:padding.y spacing:CGPointMake(spacing, spacing)];
}

@end
