//
//  JYBNavigationController.h
//  JianYunBao
//
//  Created by 冰点 on 16/1/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYBNavigationController : UINavigationController


@end

@interface JYBNavigationController (JYBConfigAttributes)

/*!
 *  @brief  设置导航条标题属性
 *
 *  @return Attributes
 */
+ (NSDictionary*)titleTextAttributes;
+ (NSDictionary*)titleTextAttributes:(UIColor*)color;

/*!
 *  @brief  导航条颜色
 *
 *  @return 色值
 */
+ (UIColor *)barTintColor;
@end