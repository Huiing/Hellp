//
//  UIColor+BDHexColor.h
//  冰点
//
//  Created by 冰点 on 15/8/24.
//  Copyright (c) 2015年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define RGB(r,g,b) RGBA(r,g,b,1.0)


@interface UIColor (BDHexColor)

+ (UIColor *)hexFloatColor:(NSString *)hexStr;
+ (UIColor *)hexFloatColor:(NSString *)hexStr alpha:(CGFloat)alpha;
//设置图片透明度
+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image;
+ (UIImage*) imageWithColor:(UIColor*) color;

/*!
 *  @brief  白色
 *
 *  @return 白色
 */
+ (UIColor *)jyb_whiteColor;
/*!
 *  @brief  黑色
 *
 *  @return 黑色
 */
+ (UIColor *)jyb_blackColor;

/*!
 *  @brief  主色：#299be8 (蓝色)
 *
 *  @return 蓝色
 */
+ (UIColor *)jyb_mainColor;

/*!
 *  @brief  背景色：#efeff4
 *
 *  @return 灰色
 */
+ (UIColor *)jyb_backgroundColor;

/*!
 *  @brief  文字灰色：#969696
 *
 *  @return 文字灰
 */
+ (UIColor *)jyb_grayColor;

/*!
 *
 *  @brief 分割线颜色：#e1e1e1
 *
 *  @return 分割线颜色
 */
+ (UIColor *)jyb_separatorColor;

/*!
 *
 *  @brief cell的高亮颜色：#EDFAFF
 *
 *  @return cell的高亮颜色
 */
+ (UIColor *)jyb_cellHighlightedColor;

@end
