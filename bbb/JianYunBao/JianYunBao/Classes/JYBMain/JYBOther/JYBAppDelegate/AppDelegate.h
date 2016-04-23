//
//  AppDelegate.h
//  JianYunBao
//
//  Created by 冰点 on 16/1/25.
//  Copyright © 2015年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYBTabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) JYBTabBarController *tabBarControler;

+ (AppDelegate*)thisAppDelegate;
- (void)setupTabbarController;
- (void)setupLoginController;
@end

