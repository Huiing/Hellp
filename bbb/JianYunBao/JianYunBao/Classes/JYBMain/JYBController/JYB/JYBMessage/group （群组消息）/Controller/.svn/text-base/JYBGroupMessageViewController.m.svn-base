//
//  JYBGroupMessageViewController.m
//  JianYunBao
//
//  Created by 宋亚伟 on 16/2/24.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBGroupMessageViewController.h"
#import "JYBCreateGroupViewController.h"
#import "JYBAddTeamViewController.h"
#import "JYBSyncGroupController.h"
#import "JYBNonDataLogoView.h"
#import "BDIMDatabaseUtil.h"
#import "JYBIChatGroupCell.h"
#import "JYBChatGroupViewController.h"
#import "JYBSyncGroupModel.h"
#import "JYBConversationModule.h"
#import "JYBSelectFriendViewController.h"

@interface JYBGroupMessageViewController ()<JYBNonDataLogoViewDelegate, UITableViewDataSource, UITableViewDelegate, ConversationModuleDelegate>
{
    JYBNonDataLogoView *nonDataLogoView;
    dispatch_queue_t conversationQueue;
}

@property (weak, nonatomic) IBOutlet BDBaseTableView *tableView;
@property (nonatomic, strong) NSArray *groups;

@end

@implementation JYBGroupMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavgationBarButtonWithImage1:@"创建添加" image2:@"群组" addTarget:self action1:@selector(addItem) action2:@selector(addTeam) direction:JYBNavigationBarButtonDirectionRight];
//    [self addNavgationBarButtonWithImage:@"创建添加" addTarget:self action:@selector(addItem) direction:JYBNavigationBarButtonDirectionRight];

    nonDataLogoView = [[JYBNonDataLogoView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HEIGHT)];
    nonDataLogoView.delegate = self;
    [self.view addSubview:nonDataLogoView];

}

- (void)addItem{
    JYBSelectFriendViewController * selectedFriend = [[JYBSelectFriendViewController alloc] init];
    selectedFriend.navigationTitle = @"发起群聊";
    selectedFriend.isFromCreatGroup = YES;
    [self.navigationController pushViewController:selectedFriend animated:YES];
}

- (void)addTeam{
    JYBAddTeamViewController *ctr = [[JYBAddTeamViewController alloc] init];
    ctr.navigationTitle = @"创建专题讨论组";
    [self.navigationController pushViewController:ctr animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

#pragma mark -
//MARK: Init
- (instancetype)init
{
    if (self = [super init]) {
        conversationQueue = dispatch_queue_create("com.JianYunBao.group.conversationQueue", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[JYBConversationModule sharedInstance] setDelegate:self];
    //必须有次方法
    [[JYBConversationModule sharedInstance] getRecentConversationWithConversationType:JYBConversationTypeGroup];
    
    [self loadGroupFromDB];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[JYBConversationModule sharedInstance] setDelegate:nil];
}

//MARK: setter & getter
- (void)setTableView:(BDBaseTableView *)tableView
{
    _tableView = tableView;
}

//MARK: loadData
- (void)loadGroupFromDB
{
    NSArray *groups = [[BDIMDatabaseUtil sharedInstance] getAllGroups];
    
    if ([groups count]) {
            [nonDataLogoView removeFromSuperview];
            nonDataLogoView = nil;
    }
    
    self.groups = [self loadDataSource:groups];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (NSMutableArray *)loadDataSource:(NSArray *)groups
{
    __block NSMutableArray *ret = [NSMutableArray array];
    dispatch_async(conversationQueue, ^{
        
        //查找最新群消息并深copy给group.xxx
        [groups enumerateObjectsUsingBlock:^(JYBSyncGroupModel  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            JYBConversation *conversation = [[JYBConversationModule sharedInstance] getConversationWithChatter:obj.sid];
            obj.conversation = [conversation copy];
        }];
        
        //根据lastMsg的timestamp排序group
        NSArray* sorte = [groups sortedArrayUsingComparator:^NSComparisonResult(JYBSyncGroupModel *obj1, JYBSyncGroupModel *obj2) {
            if (obj1.conversation.timestamp > obj2.conversation.timestamp) {
                return (NSComparisonResult)NSOrderedAscending;
            } else {
                return (NSComparisonResult)NSOrderedDescending;
            }
        }];
        [ret addObjectsFromArray:sorte];
    });
    return ret;
}

//MARK: Action

//MARK: UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [self.groups count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    JYBIChatGroupCell *cell = [JYBIChatGroupCell cellWithTableView:tableView indexPath:indexPath];
    [cell setGroupModel:self.groups[indexPath.row]];
    return cell;
}

//MARK: UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [JYBIChatGroupCell heightForRow];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYBSyncGroupModel *group = self.groups[indexPath.row];
    JYBChatGroupViewController *chatView = [[JYBChatGroupViewController alloc] initWithChatter:group.sid type:JYBConversationTypeGroup];
    chatView.navigationTitle = group.name;
    chatView.groupModel = group;
    [self.navigationController pushViewController:chatView animated:YES];
}

#pragma mark - JYBNonDataLogoViewDelegate
- (void)nonDatalogoView:(JYBNonDataLogoView *)ndlogoView didSelectedSyncAction:(JYBButton *)syncButton
{
    //同步数据
    [self pushNextController:NSStringFromClass([JYBSyncGroupController class]) hidesBottomBarWhenPushed:YES];
}

#pragma mark - ConversationModuleDelegate
- (void)conversationModule:(JYBConversationModule *)module didUnreadMessagesChanged:(JYBIChatMessage *)message;
{
    [self loadGroupFromDB];
}
//MARK: Other


@end
