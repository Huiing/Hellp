//
//  AppDelegate.m
//  neipinJob
//
//  Created by 冰点 on 15/11/6.
//  Copyright © 2015年 冰点. All rights reserved.
//

#import "AppDelegate.h"
#import "YTKNetworkAgent.h"
#import "JYBLoginViewController.h"
#import "UIFont+AdaptiveFont.h"
#import "BDClientStateMaintenanceManager.h"
#import "AppDelegate+JYBBaiduConfig.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //百度地图
    [self setupBaidu];
    [UIFont hook];
    [BDClientStateMaintenanceManager sharedInstance];
    
    YTKNetworkAgent *agent = [YTKNetworkAgent sharedInstance];
    [agent setValue:[NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json",@"text/html",@"text/css", nil] forKeyPath:@"_manager.responseSerializer.acceptableContentTypes"];
    
//    self.window.rootViewController = [[JYBTabBarController alloc] init];
    [self setupLoginController];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

/**
 *  获取AppDelegate对象
 *
 *  @return AppDelegate对象
 */
+ (AppDelegate*)thisAppDelegate {
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}

- (void)setupTabbarController
{
    self.tabBarControler = [[JYBTabBarController alloc] init];
    self.window.rootViewController = self.tabBarControler;
}

- (void)setupLoginController{
    JYBNavigationController *na = [[JYBNavigationController alloc] initWithRootViewController:[[JYBLoginViewController alloc] init]];
    self.window.rootViewController = na;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
