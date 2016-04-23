//
//  JYBMessageViewController.m
//  JianYunBao
//
//  Created by 冰点 on 16/1/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBMessageViewController.h"
#import "JYBMessageTypeCell.h"
#import "JYBMessageTypeEntity.h"
#import "JYBWorkOrderController.h"
#import "JYBNoticeViewController.h"
#import "JYBSafeOrderController.h"
#import "JYBWarningViewController.h"
#import "JYBQualityViewController.h"
#import "JYBApplicateViewController.h"
#import "JYBPersonalMessageViewController.h"
#import "JYBGroupMessageViewController.h"
#import "JYBWhiteBoardViewController.h"
#import "BDIMDatabaseUtil.h"
#import "JYBConversationModule.h"
#import "AppDelegate.h"


#define JYBMessageTypeTotalNumber 9

@interface JYBMessageViewController () <UITableViewDelegate, UITableViewDataSource, ConversationModuleDelegate>
{
    NSArray <JYBMessageTypeEntity *>*msgTypeArray;
}
@property (weak, nonatomic) IBOutlet BDBaseTableView *table;

@end

@implementation JYBMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerNotificationCenter];
    
#ifdef BD_DEBUG
    [[RuntimeStatus sharedInstance] clearCache];
#endif
//    [[JYBConversationModule sharedInstance] setDelegate:self];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
//MARK: Init
- (instancetype)init
{
    if (self = [super init]) {
        msgTypeArray = [self getMessageTypeData];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[JYBConversationModule sharedInstance] setDelegate:self];
    
    [self setupUnreadMessageCount];
    [self.table reloadData];
    
}

- (void)registerNotificationCenter
{
    //登录成功、登录失败、重新登录成功、
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveReLoginSuccessNotification)
                                                 name:JYBNotificationUserReloginSuccess object:nil];
    //注册消息
    [[RuntimeStatus sharedInstance] updateData];
    
}

//MARK: setter & getter
- (void)setTable:(BDBaseTableView *)table
{
    _table = table;
//    [table clearTableBackgroundView];
    [table hideTableViewCellSeparator];
}

//MARK: loadData
- (NSArray <JYBMessageTypeEntity *>*)getMessageTypeData
{
    return [JYBMessageTypeEntity mj_objectArrayWithFilename:@"JYBMessageTypeList.plist"];
}

//MARK: Action

//MARK: UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [msgTypeArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    JYBMessageTypeCell *cell = [JYBMessageTypeCell cellWithTableView:tableView indexPath:indexPath];
    [cell setMessageTypeEntity:msgTypeArray[indexPath.row]];
    return cell;
}

//MARK: UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return [JYBMessageTypeCell heightForRow];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JYBBaseViewController *ctr;
    if (indexPath.row == 0) {
        ctr = [[JYBWorkOrderController alloc] init];
        ctr.navigationTitle = @"工单";

    }else if(indexPath.row == 1){
        
        ctr = [[JYBQualityViewController alloc] init];
        ctr.navigationTitle = @"质量检查单";

    }else if(indexPath.row == 2){
        
        ctr = [[JYBSafeOrderController alloc] init];
        ctr.navigationTitle = @"安全检查单";

    }else if(indexPath.row == 3){
        
        ctr = [[JYBNoticeViewController alloc] init];
        ctr.navigationTitle = @"通知公告";

    }else if(indexPath.row == 4){
        
        ctr = [[JYBWarningViewController alloc] init];
        ctr.navigationTitle = @"预警消息";

    }else if(indexPath.row == 5){
        
        ctr = [[JYBApplicateViewController alloc] init];
        ctr.navigationTitle = @"审批提醒";

    }else if(indexPath.row == 6){

        ctr = [[JYBGroupMessageViewController alloc] init];
        ctr.navigationTitle = @"群组消息";

    }else if(indexPath.row == 7){
        
        ctr = [[JYBPersonalMessageViewController alloc] init];
        ctr.navigationTitle = @"个人消息";

    }else if(indexPath.row == 8){
        
        ctr = [[JYBWhiteBoardViewController alloc] initWithChatter:JYB_WHITEBOARD_ID type:JYBConversationTypeWhiteboard];
        ctr.navigationTitle = @"企业白板";
    }
    [ctr setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:ctr animated:YES];

}

//MARK: ConversationModuleDelegate
- (void)conversationModule:(JYBConversationModule *)module didUnreadMessagesChanged:(JYBIChatMessage *)message
{

    [self setupUnreadMessageCount];
    [self.table reloadData];
    
//    //这样写，没考虑消息同时到达的问题
//    NSIndexPath *indexPath = nil;
//    switch (module.conversation.conversationType) {
//        case JYBConversationTypeSingle:
//            indexPath = [NSIndexPath indexPathForRow:7 inSection:0];
//            break;
//        case JYBConversationTypeWhiteboard:
//            indexPath = [NSIndexPath indexPathForRow:8 inSection:0];
//            break;
//            
//        default:
//            break;
//    }
//    if (indexPath) {
//        [self.table reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//    }
}


//MARK: Other
- (void)receiveReLoginSuccessNotification
{
    //加载最近联系人
    
}

// 统计未读消息数
-(void)setupUnreadMessageCount
{
    NSInteger unreadCount = [[JYBConversationModule sharedInstance] getAllUnreadMessageCount];
    JYBTabBarController *tabController = [AppDelegate thisAppDelegate].tabBarControler;
    UIViewController *vCtrl = [tabController.viewControllers firstObject];
    if (unreadCount != 0) {
        if (unreadCount > 99) {
            [vCtrl.tabBarItem setBadgeValue:@"99+"];
        } else {
            [vCtrl.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%ld",unreadCount]];
        }
    }else{
        vCtrl.tabBarItem.badgeValue = nil;
    }
    UIApplication *application = [UIApplication sharedApplication];
    [application setApplicationIconBadgeNumber:unreadCount];
}

@end
