//
//  JYBPersonalMessageViewController.m
//  JianYunBao
//
//  Created by 宋亚伟 on 16/2/24.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBPersonalMessageViewController.h"
#import "JYBCreateChatViewController.h"
#import "JYBConversationModule.h"
#import "BDIMDatabaseUtil.h"
#import "JYBConversationCell.h"
#import "JYBChatViewController.h"

@interface JYBPersonalMessageViewController () <UITableViewDelegate, UITableViewDataSource, ConversationModuleDelegate>
{
    dispatch_queue_t conversationQueue;
}

//@property (nonatomic, strong) BDBaseTableView *tableView;
@property (weak, nonatomic) IBOutlet BDBaseTableView *tableView;

@property (nonatomic, strong) NSMutableArray <JYBConversation *>*dataSource;

@end

@implementation JYBPersonalMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavgationBarButtonWithImage:@"创建添加" addTarget:self action:@selector(addItem) direction:JYBNavigationBarButtonDirectionRight];
    
    [self removeEmptyConversationsFromDB];
    
    [self.view addSubview:self.tableView];
}

- (void)addItem{
    
    DLog(@"宋亚伟");
    JYBCreateChatViewController *ctr = [[JYBCreateChatViewController alloc] init];
    ctr.navigationTitle = @"发起单聊";
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
        conversationQueue = dispatch_queue_create("com.JianYunBao.single.conversationQueue", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[JYBConversationModule sharedInstance] setDelegate:self];
    [self refreshDataSource];
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
    [tableView hideTableViewCellSeparator];
}

- (NSMutableArray<JYBConversation *> *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

//MARK: loadData
- (void)refreshDataSource
{
    self.dataSource = [self loadDataSource];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (NSMutableArray *)loadDataSource
{
    __block NSMutableArray *ret = [NSMutableArray array];
    dispatch_async(conversationQueue, ^{
        NSArray *conversations =[[JYBConversationModule sharedInstance] getRecentConversationWithConversationType:JYBConversationTypeSingle];
        NSArray* sorte = [conversations sortedArrayUsingComparator:
                          ^(JYBConversation *obj1, JYBConversation* obj2){
                              if(obj1.timestamp > obj2.timestamp) {
                                  return(NSComparisonResult)NSOrderedAscending;
                              }else {
                                  return(NSComparisonResult)NSOrderedDescending;
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
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    JYBConversationCell *cell = [JYBConversationCell cellWithTableView:tableView indexPath:indexPath];
    [cell setConversation:self.dataSource[indexPath.row]];
    return cell;
}

//MARK: UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return [JYBConversationCell heightForRow];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    JYBConversation *conversation = self.dataSource[indexPath.row];
    JYBChatViewController *chatView = [[JYBChatViewController alloc] initWithChatter:conversation.chatter type:JYBConversationTypeSingle];
    chatView.navigationTitle = conversation.name;
    [self.navigationController pushViewController:chatView animated:YES];
}

//MARK: ConversationModuleDelegate
- (void)conversationModule:(JYBConversationModule *)module didUnreadMessagesChanged:(JYBIChatMessage *)message
{
    [self refreshDataSource];
}

//MARK: Other
- (void)removeEmptyConversationsFromDB
{
    NSArray *conversations =[[JYBConversationModule sharedInstance] getRecentConversationWithConversationType:JYBConversationTypeSingle];
    for (JYBConversation *conversation in conversations) {
        if (!bd_isValidKey(conversation.lastMsgId)) {
            [[JYBConversationModule sharedInstance] removeConversationFromDB:conversation];
        }
    }
}

@end
