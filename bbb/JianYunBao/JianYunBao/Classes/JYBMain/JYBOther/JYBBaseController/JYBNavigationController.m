//
//  JYBNavigationController.m
//  JianYunBao
//
//  Created by 冰点 on 16/1/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBNavigationController.h"

@interface JYBNavigationController ()

@end

@implementation JYBNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.titleTextAttributes=[JYBNavigationController titleTextAttributes];
    self.navigationBar.barTintColor = [JYBNavigationController barTintColor];
    self.navigationBar.barStyle = UIBarStyleBlack;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

@implementation JYBNavigationController (JYBConfigAttributes)

/*!
 *  @brief  设置导航条标题属性
 *
 *  @return Attributes
 */
+ (NSDictionary*)titleTextAttributes
{
    return [self titleTextAttributes:JYBWhiteColor];
}

+ (NSDictionary*)titleTextAttributes:(UIColor*)color
{
    return  @{/*NSFontAttributeName: JYBFont(JYBNavTitleFontSize),*/
              NSForegroundColorAttributeName:color};
}

/*!
 *  @brief  导航条颜色
 *
 *  @return 色值
 */
+ (UIColor *)barTintColor
{
    return JYBMainColor;
}
@end