//
//  UIColor+BDHexColor.m
//  冰点
//
//  Created by 冰点 on 15/8/24.
//  Copyright (c) 2015年 冰点. All rights reserved.
//

#import "UIColor+BDHexColor.h"

@implementation UIColor (BDHexColor)

+ (UIColor *)hexFloatColor:(NSString *)hexStr {
    
    return [self hexFloatColor:hexStr alpha:1.0];
}

+ (UIColor *)hexFloatColor:(NSString *)hexStr alpha:(CGFloat)alpha
{
    if (hexStr.length < 6)
        return nil;
    
    unsigned int red_, green_, blue_;
    NSRange exceptionRange;
    exceptionRange.length = 2;
    
    //red
    exceptionRange.location = 0;
    [[NSScanner scannerWithString:[hexStr substringWithRange:exceptionRange]]scanHexInt:&red_];
    
    //green
    exceptionRange.location = 2;
    [[NSScanner scannerWithString:[hexStr substringWithRange:exceptionRange]]scanHexInt:&green_];
    
    //blue
    exceptionRange.location = 4;
    [[NSScanner scannerWithString:[hexStr substringWithRange:exceptionRange]]scanHexInt:&blue_];
    
    UIColor *resultColor = RGBA(red_, green_, blue_, alpha);
    return resultColor;
}

//设置图片透明度
+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image {
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, image.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage*) imageWithColor:(UIColor*) color
{
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
}

#pragma mark -
#pragma mark - 自定义颜色

/*!
 *  @brief  白色
 *
 *  @return 白色
 */
+ (UIColor *)jyb_whiteColor
{
    return [self hexFloatColor:@"ffffff"];
}

/*!
 *  @brief  黑色
 *
 *  @return 黑色
 */
+ (UIColor *)jyb_blackColor
{
    return [self hexFloatColor:@"4d4d4d"];
}

/*!
 *  @brief  主色：#299be8 (蓝色)
 *
 *  @return 蓝色
 */
+ (UIColor *)jyb_mainColor
{
    return [self hexFloatColor:@"2487e3"];
}

/*!
 *  @brief  背景色：#efeff4
 *
 *  @return 灰色
 */
+ (UIColor *)jyb_backgroundColor
{
    return [self hexFloatColor:@"efeff4"];
}

/*!
 *  @brief  文字灰色：#969696
 *
 *  @return 文字灰
 */
+ (UIColor *)jyb_grayColor
{
    return [self hexFloatColor:@"969696"];
}

/*!
 *
 *  @brief 分割线颜色：#e1e1e1
 *
 *  @return 分割线颜色
 */
+ (UIColor *)jyb_separatorColor
{
    return [self hexFloatColor:@"e1e1e1"];
}

/*!
 *
 *  @brief cell的高亮颜色：#EDFAFF
 *
 *  @return cell的高亮颜色
 */
+ (UIColor *)jyb_cellHighlightedColor
{
    return [self hexFloatColor:@"EDFAFF"];
}

@end
