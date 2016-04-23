//
//  JYBTabBarController.m
//  JianYunBao
//
//  Created by 冰点 on 16/1/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBTabBarController.h"
#import "JYBMessageViewController.h"
#import "JYBApplicationViewController.h"
#import "JYBContactsViewController.h"
#import "JYBSettingViewController.h"
#import "JYBLoginViewController.h"
#import "JYBNavigationController.h"
#import "BDClientState.h"
#import "JYBConversationModule.h"


@interface JYBTabBarController () <UIAlertViewDelegate, ConversationModuleDelegate>
{
    NSMutableArray *viewControllers_;
    NSArray *allChildControllers_;
    NSArray *itemTitles_;
    NSArray *tabBarNormalImages_;
    NSArray *tabBarSelectedImages_;
    NSString *msgControllerCls;
    UIViewController *messageController;
    UIAlertView *kickout_alertView;//用户被挤下线的警告框
}

@end

@implementation JYBTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerNotificationCenter];
    viewControllers_ = [NSMutableArray array];
    [self loadAllResources];
    [self addViewControllers:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveIChatMessage:) name:JYBNotificationReceiveMessage object:nil];
    // Do any additional setup after loading the view.
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
//MARK: Init
- (void)loadAllResources
{
    itemTitles_ = @[@"消息", @"应用", @"通讯录", @"设置" ];
    tabBarNormalImages_ = @[@"消息", @"应用", @"通讯录", @"设置" ];
    tabBarSelectedImages_ = @[@"消息1", @"应用1", @"通讯录1", @"设置l" ];
}

- (void)registerNotificationCenter
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kickOffUserNotification:) name:JYBNotificationUserKickouted object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutNotification:) name:JYBNotificationUserLogout object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(invalidUserNotification:) name:JYBNotificationInvalidUser object:nil];
}

//MARK: setter & getter

//MARK: loadData

//MARK: Action

//MARK: delegate

//MARK: Other
- (void)addViewControllers:(NSArray *)controllers
{
    if (![controllers count]) {
        allChildControllers_ = @[@"JYBMessageViewController", @"JYBApplicationViewController", @"JYBContactsViewController", @"JYBSettingViewController"];
        msgControllerCls = allChildControllers_[0];
    } else {
        allChildControllers_ = controllers;
        msgControllerCls = allChildControllers_[0];//存在风险问题
    }
    [self loadAllChildViewController];
    [self setupUnreadMessageCount];
}

// 统计未读消息数
-(void)setupUnreadMessageCount
{
    NSInteger unreadCount = [[JYBConversationModule sharedInstance] getAllUnreadMessageCount];
    if (unreadCount != 0) {
        if (unreadCount > 99) {
            [messageController.tabBarItem setBadgeValue:@"99+"];
        } else {
            [messageController.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%ld",unreadCount]];
        }
    }else{
        messageController.tabBarItem.badgeValue = nil;
    }
    UIApplication *application = [UIApplication sharedApplication];
    [application setApplicationIconBadgeNumber:unreadCount];
}


- (void)loadAllChildViewController
{
    __weak typeof(self) weakSelf = self;
    
    [allChildControllers_ enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [weakSelf initChildViewControllerClassString:obj
                             withNavigationItemTitle:itemTitles_[idx]
                               withAllChildCtrlCount:allChildControllers_.count];
    }];
}

- (void)initChildViewControllerClassString:(NSString*)aClassName
                   withNavigationItemTitle:(NSString*)title
                     withAllChildCtrlCount:(NSUInteger)count
{
    Class class = NSClassFromString(aClassName);
    BOOL ret = [[class superclass] isSubclassOfClass:[JYBBaseViewController class]];
    if (ret) {
        JYBBaseViewController *rootCtrl = [[class alloc] init];
        rootCtrl.navigationTitle = title;
        JYBNavigationController *navCtrl = [[JYBNavigationController alloc] initWithRootViewController:rootCtrl];
        if ([rootCtrl isKindOfClass:NSClassFromString(msgControllerCls)]) {
            messageController = navCtrl;
        }
        [self addChildViewController:navCtrl withAllChildCtrlCount:count];
    }
}

- (void)addChildViewController:(JYBNavigationController *)childController withAllChildCtrlCount:(NSUInteger)count
{
    [viewControllers_ addObject:childController];
    if ([viewControllers_ count] != count) { return; }
    self.viewControllers = viewControllers_;
    [self setResourceForTabBarItems];
}

- (void)setResourceForTabBarItems
{
    __weak typeof(self) weakSelf = self;
    [self.tabBar.items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UITabBarItem *tabBarItem = (UITabBarItem *)obj;
        weakSelf.tabBarItem  = [tabBarItem initWithTitle:itemTitles_[idx]
                                                   image:[[UIImage imageNamed:tabBarNormalImages_[idx]]
                                                          imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                           selectedImage:[[UIImage imageNamed:tabBarSelectedImages_[idx]]
                                                          imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: JYBMainColor}
                                             forState:UIControlStateSelected];
}

#pragma mark - 退出登录和被挤下线的 通知
- (void)kickOffUserNotification:(NSNotification *)notification
{
        [BDClientState sharedInstance].userState = JYBUserStateKickout;
        kickout_alertView =  [[UIAlertView alloc] initWithTitle:@"注意" message:@"你的账号在其他设备登陆了" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [kickout_alertView show];
}

- (void)logoutNotification:(NSNotification *)notification
{
    [BDClientState sharedInstance].userState = JYBUserStateOfflineInitiative;
    [self presentLoginController];
}

- (void)invalidUserNotification:(NSNotification *)notification
{
    kickout_alertView =  [[UIAlertView alloc] initWithTitle:@"注意" message:@"您使用的是无效账号！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [kickout_alertView show];
}

- (void)didReceiveIChatMessage:(NSNotification *)notification
{
    [self setupUnreadMessageCount];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //流程：
    /**
     1、进入登录界面
     2、断开TCP连接
     **/
    [self presentLoginController];
}

- (void)presentLoginController
{
    JYBLoginViewController *loginContrl = [[JYBLoginViewController alloc] init];
    UINavigationController *nav = [[JYBNavigationController alloc] initWithRootViewController:loginContrl];
    
    loginContrl.loginCompleted = ^{};
    
    [self presentViewController:nav animated:YES completion:^{
        [loginContrl setLoginModal:JYBLoginModalPresent];
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
