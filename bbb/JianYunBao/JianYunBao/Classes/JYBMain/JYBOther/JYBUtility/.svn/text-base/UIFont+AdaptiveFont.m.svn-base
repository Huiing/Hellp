//
//  UIFont+AdaptiveFont.m
//  AspectCellScaleDemo
//
//  Created by 冰点 on 16/1/16.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "UIFont+AdaptiveFont.h"
#import "AdaptiveFontUtility.h"

@implementation UIFont (AdaptiveFont)

+ (void)hook
{
    bd_exchageClassMethod([UIFont class], @selector(fontWithName:size:), @selector(hook_fontWithName:size:));
}

+ (void)hook_system
{
    bd_exchageClassMethod([UIFont class], @selector(systemFontOfSize:), @selector(hook_systemFontOfSize:));
}

+ (UIFont *)hook_fontWithName:(NSString *)fontName size:(CGFloat)fontSize
{
//    NSLog(@"before : %.1f", fontSize);
    CGFloat scale = ([UIScreen mainScreen].bounds.size.width / 320);
//    NSLog(@"scale : %f", scale);
    UIFont *font = [self hook_fontWithName:fontName size:fontSize * scale];
//    NSLog(@"after : %.1f", [font pointSize]);
//    printf("<--------------------->\n");
    return font;
}

+ (UIFont *)hook_systemFontOfSize:(CGFloat)fontSize
{
    CGFloat scale = ([UIScreen mainScreen].bounds.size.width / 320);
    UIFont *font = [self hook_systemFontOfSize:fontSize * scale];
    return font;
}
@end
