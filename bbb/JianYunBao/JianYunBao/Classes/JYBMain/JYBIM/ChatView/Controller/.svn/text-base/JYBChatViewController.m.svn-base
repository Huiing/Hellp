//
//  JYBChatViewController.m
//  JianYunBao
//
//  Created by 冰点 on 16/3/2.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBChatViewController.h"
@import AVFoundation;
@import MediaPlayer;
@import MobileCoreServices;
#import "JYBMessageModule.h"
#import "IChatViewCell.h"
#import "IChatMessageToolBar.h"
#import "BDIMDatabaseUtil.h"
#import "IChatTimeCell.h"
#import "NSDate+Category.h"
#import "JYBIMWhiteboardHandle.h"
#import "EMCDDeviceManager.h"
#import "IChatMessageReadManager.h"
#import "NSString+BDPath.h"
#import "JYBDownloadFileApi.h"
#import "UIImage+BDVideoThumbnail.h"
#import "JYBIMChatSingleHandle.h"
#import "JYBIChatMessage.h"
#import "JYBConversationModule.h"
#import "JYBChatGroupHandle.h"
#import "JYBNoticeHandle.h"
#import "JYBFriendItemTool.h"
#import "JYBPersonalInformationViewController.h"
#import "JYBIMGetWhiteboardMessageApi.h"
#import "JYBWhiteBoardModel.h"
#import "JYBFileDownloadHandler.h"
#import "JYBSingleChatSettingViewController.h"

#define KPageCount 20

NSString *const JYB_WHITEBOARD_ID = @"10005";

@interface JYBChatViewController ()
<UITableViewDataSource,UITableViewDelegate,
UINavigationControllerDelegate,UIImagePickerControllerDelegate,
IChatMessageToolBarDelegate,DXChatBarMoreViewDelegate>
{
    UIMenuController *_menuController;
    UIMenuItem *_copyMenuItem;
    UIMenuItem *_deleteMenuItem;
    NSIndexPath *_longPressIndexPath;
    
    NSInteger page;
    dispatch_queue_t _messageQueue;
    
    //发送消息管理类
    JYBIMWhiteboardHandle *_whiteboardHandle;
    JYBIMChatSingleHandle *_singleChatHandle;
    JYBChatGroupHandle *_groupChatHandle;
    //...
    //...
    JYBNoticeHandle *_noticeChatHandle;
}

@property (nonatomic) BOOL isInvisible;
@property (nonatomic, strong) NSMutableArray <JYBIChatMessage*>*messages;

@property (weak, nonatomic) NSDate *chatTagDate;
@property (strong, nonatomic) IChatMessageToolBar *chatToolBar;

@property (strong, nonatomic) IChatMessageReadManager *messageReadManager;//message阅读的管理者
@property (nonatomic) BOOL isPlayingAudio;

@end

@implementation JYBChatViewController
{
    NSString *_enterpriseCode;
    NSString *_userid;
    NSString *_name;
    NSString *_chatter;
    JYBConversationType _chatType;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNavgationBarButtonWithImage:@"用户名" addTarget:self action:@selector(chatSetting) direction:JYBNavigationBarButtonDirectionRight];
    [self createChatApiWithChatType:_chatType];
    
    page = 1;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveIChatMessage:) name:JYBNotificationReceiveMessage object:nil];
    
    [JYBMessageModule sharedInstance];
    
    _messageQueue = dispatch_queue_create("JianYunBao.IMMessage.com", NULL);
    [self.view addSubview:self.chatToolBar];
    
    CGRect tableFrame = self.tableView.frame;
    tableFrame.size.height = self.view.frame.size.height - self.chatToolBar.frame.size.height;
    self.tableView.frame = tableFrame;
    
    //将self注册为chatToolBar的moreView的代理
    if ([self.chatToolBar.moreView isKindOfClass:[DXChatBarMoreView class]]) {
        [(DXChatBarMoreView *)self.chatToolBar.moreView setDelegate:self];
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyBoardHidden)];
    [self.view addGestureRecognizer:tap];
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = .5;
    [self.tableView addGestureRecognizer:lpgr];
    
    //本地加载历史消息
    [self loadMoreMessagesFromIndex:page pageCount:KPageCount append:NO];
    
    self.showRefreshHeader = YES;
    
    // Do any additional setup after loading the view.
}
//聊天设置
- (void)chatSetting{
    JYBSingleChatSettingViewController * chatSetting = [[JYBSingleChatSettingViewController alloc] init];
    chatSetting.navigationTitle = @"聊天设置";
    chatSetting.friendId = _chatter;
    [self.navigationController pushViewController:chatSetting animated:YES];
}

#pragma mark -
//MARK: Init
- (instancetype)initWithChatter:(NSString *)chatter type:(JYBConversationType) chatType
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        _messages = [NSMutableArray array];
        _isPlayingAudio = NO;
        
        _enterpriseCode =  [RuntimeStatus sharedInstance].buildCloudEntity.enterpriseCode;
        _userid = [RuntimeStatus sharedInstance].userItem.userId;
        _name = [RuntimeStatus sharedInstance].userItem.name;
        
        _chatter = chatter;
        _chatType = chatType;
    }
    return self;
}

- (void)createChatApiWithChatType:(JYBConversationType)chatType
{
    switch (chatType) {
        case JYBConversationTypeWhiteboard:
        {
            _whiteboardHandle = [[JYBIMWhiteboardHandle alloc] initSendMessageWithEnterpriseCode:_enterpriseCode userid:_userid name:_name];
        }
            break;
        case JYBConversationTypeSingle:
        {
            _singleChatHandle = [[JYBIMChatSingleHandle alloc] initSendSingleChatMessageWithEnterpriseCode:_enterpriseCode userid:_userid name:_name receiveUserId:_chatter];
        }
            break;
        case JYBConversationTypeGroup:
        {
            _groupChatHandle = [[JYBChatGroupHandle alloc] initSendGroupChatMessageWithEnterpriseCode:_enterpriseCode userid:_userid name:_name groupId:_chatter];
        }
            break;
        case JYBConversationTypeNoticeComment:
        {
            _noticeChatHandle = [[JYBNoticeHandle alloc] initSendNoticeWithEnterpriseCode:_enterpriseCode userid:_userid name:_name newId:_chatter];
        }
            break;
        default:
            break;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //注册清除缓存通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearCache) name:@"ClearCacheNotification" object:nil];
    //需标记消息已读的处理
    [[JYBConversationModule sharedInstance] getRecentConversationWithConversationType:_chatType];
    JYBConversation *conversation  = [[JYBConversationModule sharedInstance] getConversationWithChatter:_chatter];
    conversation.unreadCount = 0;
    
    [[BDIMDatabaseUtil sharedInstance] updateConversation:conversation];
    
    [self.tableView reloadData];
    [self scrollViewToBottom:NO];
}

- (void)dealloc
{
    _chatToolBar.delegate = nil;
    _chatToolBar = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//MARK: setter & getter

- (void)setIsInvisible:(BOOL)isInvisible
{
    _isInvisible =isInvisible;
}

- (NSMutableArray<JYBIChatMessage *> *)messages
{
    if (!_messages) {
        _messages = [NSMutableArray array];
    }
    return _messages;
}

- (NSDate *)chatTagDate
{
    if (_chatTagDate == nil) {
        _chatTagDate = [NSDate dateWithTimeIntervalInMilliSecondSince1970:0];
    }
    return _chatTagDate;
}

- (IChatMessageToolBar *)chatToolBar
{
    if (_chatToolBar == nil) {
        _chatToolBar = [[IChatMessageToolBar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - [IChatMessageToolBar defaultHeight], self.view.frame.size.width, [IChatMessageToolBar defaultHeight])];
        
        switch (_chatType) {
            case JYBConversationTypeNoticeComment:
                _chatToolBar.toolBarStyle = IChatMessageToolBarStyleComment;
                break;
                
            default:
                _chatToolBar.toolBarStyle = IChatMessageToolBarStyleChat;
                break;
        }
        _chatToolBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
        _chatToolBar.delegate = self;
        
        _chatToolBar.moreView = [[DXChatBarMoreView alloc] initWithFrame:CGRectMake(0, (kVerticalPadding * 2 + kInputTextViewMinHeight), _chatToolBar.frame.size.width, 80) type:ChatMoreTypeChat];
        _chatToolBar.moreView.backgroundColor = RGBA(240, 242, 247, 1);
        _chatToolBar.moreView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    }
    
    return _chatToolBar;
}


- (IChatMessageReadManager *)messageReadManager
{
    if (_messageReadManager == nil) {
        _messageReadManager = [IChatMessageReadManager defaultManager];
    }
    
    return _messageReadManager;
}

//MARK: loadData
- (void)loadMoreMessagesFromIndex:(NSInteger)index pageCount:(NSInteger)count append:(BOOL)append
{
    __weak __typeof(self)weakSelf = self;
    [[BDIMDatabaseUtil sharedInstance] getIChatMessagesWithConversationChatter:_chatter page:page count:count success:^(NSArray *messages) {
        
        dispatch_async(_messageQueue, ^{
            if (messages.count > 0) {
                NSInteger currentCount = 0;
                if (append) {
                    [weakSelf.messages insertObjects:messages atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [messages count])]];
                    NSArray *formated = [weakSelf formatMessages:messages];
                    id model = [weakSelf.dataSource firstObject];
                    if ([model isKindOfClass:[NSString class]])
                    {
                        NSString *timestamp = model;
                        [formated enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id model, NSUInteger idx, BOOL *stop) {
                            if ([model isKindOfClass:[NSString class]] && [timestamp isEqualToString:model])
                            {
                                [weakSelf.dataSource removeObjectAtIndex:0];
                                *stop = YES;
                            }
                        }];
                    }
                    currentCount = [weakSelf.dataSource count];
                    [weakSelf.dataSource insertObjects:formated atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [formated count])]];
                    
                    JYBIChatMessage *latest = [weakSelf.messages lastObject];
                    weakSelf.chatTagDate = [NSDate dateWithTimeIntervalInMilliSecondSince1970:(NSTimeInterval)latest.timestamp];
                } else {
                    weakSelf.messages = [messages mutableCopy];
                    weakSelf.dataSource = [[weakSelf formatMessages:messages] mutableCopy];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    //end refreshing
                    [weakSelf.tableView reloadData];
                    [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[weakSelf.dataSource count] - currentCount - 1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
                });
            } else {
                //end refreshing
                dispatch_async(dispatch_get_main_queue(), ^{
                        //从服务器获取
//                        [weakSelf loadHistoryMessageFromRemoteServer];
                });
            }
        });
    } failure:^(NSError *error) {
        DLog(@"%@",error);
    }];
    
}

- (void)loadHistoryMessageFromRemoteServer
{
    switch (_chatType) {
        case JYBConversationTypeWhiteboard:
        {
            JYBIChatMessage *msg = [self.messages firstObject];
            JYBIMGetWhiteboardMessageApi *api = [[JYBIMGetWhiteboardMessageApi alloc] initGetWhiteboardMessageWithLastMsgId:bd_isValidKey(msg.messageID) ? msg.messageID: @"0"];
            [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
                DLogJSON(request.responseJSONObject);
                if ([APIJsonObject[@"result"] boolValue] && ![APIJsonObject[@"deleted"] boolValue]) {
                    NSArray *models = [JYBWhiteBoardModel mj_objectArrayWithKeyValuesArray:APIJsonObject[@"list"]];
                    if (models.count) {
                        NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:models.count];
                        dispatch_async(_messageQueue, ^{
                            for (JYBWhiteBoardModel *model in models) {
                                [tmp addObject:[JYBWhiteBoardModel parseFromModel:model]];
                            }
                            [[BDIMDatabaseUtil sharedInstance] insertIChatMessages:tmp success:^{} failure:^(NSString *errorDescripe) {}];
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [self loadMoreMessagesFromIndex:page pageCount:KPageCount append:YES];
                            });
                        });
                    }
                }
            } failure:^(__kindof YTKBaseRequest *request) {
                [self showHint:@"网络异常！"];
            }];
        }
            break;
            
        default:
            break;
    }
}

//插入时间的处理
- (NSArray *)formatMessages:(NSArray *)messages
{
    NSMutableArray *formatArray =nil;
    if (messages.count > 0) {
        if (formatArray == nil) {
            formatArray = [NSMutableArray array];
        }
        
        for (JYBIChatMessage *messageEntity in messages) {
            @autoreleasepool {
                //插入时间戳
                NSDate *createDate = [NSDate dateWithTimeIntervalInMilliSecondSince1970:messageEntity.timestamp];
                NSTimeInterval tempDate = [createDate timeIntervalSinceDate:self.chatTagDate];
                if (tempDate > 60 || tempDate < -60 || (self.chatTagDate == nil)) {
                    @autoreleasepool {
                        [formatArray addObject:[createDate formattedTime]];
                    }
                    self.chatTagDate = createDate;
                }
                
                if (messageEntity) {
                    
                    if (_chatType == JYBConversationTypeSingle) {
                        if ([_chatter isEqualToString:[RuntimeStatus sharedInstance].userItem.userId]) {
                            messageEntity.avatar =  [RuntimeStatus sharedInstance].userItem.iconPaths;
                        } else {
                            messageEntity.avatar = [[[JYBFriendItemTool friends:messageEntity.fromUserID] firstObject] iconPaths];
                        }
                    } else {
                        messageEntity.avatar = [[[JYBFriendItemTool friends:messageEntity.fromUserID] firstObject] iconPaths];
                    }
                    
                    if (messageEntity.messageBodyType == JYBIMMessageBodyTypeVideo) {
                        if (messageEntity.videoThumbnailPath) {
                            messageEntity.image =  [UIImage imageWithContentsOfFile:[JYB_LibraryDirectoryPath() stringByAppendingString:messageEntity.videoThumbnailPath]];
                        }
                    }
                    [formatArray addObject:messageEntity];
                }
            }
        }
    }
    return formatArray;
}
//MARK: Action
- (void)tableViewDidTriggerHeaderRefresh
{
    page++;
//    [self loadMoreMessagesFromIndex:page pageCount:KPageCount append:YES];
    [self loadHistoryMessageFromRemoteServer];
    [self tableViewDidFinishTriggerHeader:YES reload:NO];
}

- (void)tableViewDidTriggerFooterRefresh
{
    [self tableViewDidFinishTriggerHeader:YES reload:NO];
}

#pragma mark - MenuItem actions
- (void)copyMenuAction:(id)sender
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    if (_longPressIndexPath.row > 0) {
        JYBIChatMessage *model = [self.dataSource objectAtIndex:_longPressIndexPath.row];
        pasteboard.string = model.content;
    }
    
    _longPressIndexPath = nil;
}

- (void)deleteMenuAction:(id)sender
{
    if (_longPressIndexPath && _longPressIndexPath.row > 0) {
        JYBIChatMessage *model = [self.dataSource objectAtIndex:_longPressIndexPath.row];
        NSMutableIndexSet *indexs = [NSMutableIndexSet indexSetWithIndex:_longPressIndexPath.row];
        [[BDIMDatabaseUtil sharedInstance] deleteIChatMessageWithMsgID:model.messageID success:^{}];
        [self.messages removeObject:model];
        NSMutableArray *indexPaths = [NSMutableArray arrayWithObjects:_longPressIndexPath, nil];;
        if (_longPressIndexPath.row - 1 >= 0) {
            id nextMessage = nil;
            id prevMessage = [self.dataSource objectAtIndex:(_longPressIndexPath.row - 1)];
            if (_longPressIndexPath.row + 1 < [self.dataSource count]) {
                nextMessage = [self.dataSource objectAtIndex:(_longPressIndexPath.row + 1)];
            }
            if ((!nextMessage || [nextMessage isKindOfClass:[NSString class]]) && [prevMessage isKindOfClass:[NSString class]]) {
                [indexs addIndex:_longPressIndexPath.row - 1];
                [indexPaths addObject:[NSIndexPath indexPathForRow:(_longPressIndexPath.row - 1) inSection:0]];
            }
        }
        
        [self.dataSource removeObjectsAtIndexes:indexs];
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }
    
    _longPressIndexPath = nil;
}

//MARK: delegate
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.row < [self.dataSource count]) {
        id obj = [self.dataSource objectAtIndex:indexPath.row];
        if ([obj isKindOfClass:[NSString class]]) {
            IChatTimeCell *timeCell = [IChatTimeCell cellWithTableView:tableView identifier:@"MessageCellTime"];
            [timeCell setFormatTime:(NSString *)obj];
            return timeCell;
        } else {
            JYBIChatMessage *message = (JYBIChatMessage *)obj;
            NSString *cellIdentifier = [IChatViewCell cellIdentifierForMessageModel:message];
            IChatViewCell *cell = (IChatViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell) {
                cell = [[IChatViewCell alloc] initWithMessageModel:message reuseIdentifier:cellIdentifier];
                cell.backgroundColor = [UIColor clearColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.messageEntity = message;
            return cell;
        }
    }
    return nil;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject *obj = [self.dataSource objectAtIndex:indexPath.row];
    if ([obj isKindOfClass:[NSString class]]) {
        return 40;
    }
    else{
        return [IChatViewCell tableView:tableView heightForRowAtIndexPath:indexPath withObject:(JYBIChatMessage *)obj];
    }
}

#pragma mark - Notification
- (void)didReceiveIChatMessage:(NSNotification *)notification
{
    id message = [notification object];
    if ([message isKindOfClass:[JYBIChatMessage class]]) {
        [self addMessage:message];
    }
}

- (void)addMessage:(JYBIChatMessage *)message
{
    if (![_chatter isEqualToString:message.conversationChatter]) {
        return;
    }
    
    //update DB of conversation
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        JYBConversation *conversation = [[JYBConversationModule sharedInstance] getConversationWithChatter:_chatter];
        if (conversation) {
            conversation.lastMsgId = message.messageID;
            conversation.lastMsg = message.content;
            [[BDIMDatabaseUtil sharedInstance] insertConversations:@[conversation]];
        }
    });
    
    
    [_messages addObject:message];
    __weak JYBChatViewController *weakSelf = self;
    dispatch_async(_messageQueue, ^{
        if (message.messageBodyType == JYBIMMessageBodyTypeAudio) {
            message.isRead = NO;
        } else {
            message.isRead = YES;
        }
        [[BDIMDatabaseUtil sharedInstance] updateIChatMessageWithIChatMessage:message success:^{}];
        NSArray *messages = [weakSelf formatMessage:message];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.dataSource addObjectsFromArray:messages];
            [weakSelf.tableView reloadData];
            [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[weakSelf.dataSource count] - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        });
    });
}

- (NSArray *)formatMessage:(JYBIChatMessage *)message
{
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    NSDate *createDate = [NSDate dateWithTimeIntervalInMilliSecondSince1970:(NSTimeInterval)message.timestamp];
    NSTimeInterval tempDate = [createDate timeIntervalSinceDate:self.chatTagDate];
    if (tempDate > 60 || tempDate < -60 || (self.chatTagDate == nil)) {
        [ret addObject:[createDate formattedTime]];
        self.chatTagDate = createDate;
    }
    if (message) {
        if (_chatType == JYBConversationTypeSingle) {
            if ([_chatter isEqualToString:[RuntimeStatus sharedInstance].userItem.userId]) {
                message.avatar =  [RuntimeStatus sharedInstance].userItem.iconPaths;
            } else {
                message.avatar = [[[JYBFriendItemTool friends:message.fromUserID] firstObject] iconPaths];
            }
        } else {
            message.avatar = [[[JYBFriendItemTool friends:message.fromUserID] firstObject] iconPaths];
        }
        
        if (message.messageBodyType == JYBIMMessageBodyTypeVideo) {
            if (message.videoThumbnailPath) {
                message.image =  [UIImage imageWithContentsOfFile:[JYB_LibraryDirectoryPath() stringByAppendingString:message.videoThumbnailPath]];
            }
        }
        [ret addObject:message];
    }
    return ret;
}

#pragma mark - IChatMessageToolBarDelegate
- (void)inputTextViewWillBeginEditing:(XHMessageTextView *)messageInputTextView{
        [_menuController setMenuItems:nil];
}

- (void)didChangeFrameToHeight:(CGFloat)toHeight
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.tableView.frame;
        rect.origin.y = 0;
        rect.size.height = self.view.frame.size.height - toHeight;//198
        self.tableView.frame = rect;
    }];
    [self scrollViewToBottom:NO];
}

- (void)didSendText:(NSString *)text
{
    if (text && text.length > 0) {
        //TODO: 会话类型 -- 添加类型
        switch (_chatType) {
            case JYBConversationTypeWhiteboard:
                [self sendWhiteboardTextMessage:text];
                break;
            case JYBConversationTypeSingle:
                [self sendSingleTextMessage:text];
                break;
            case JYBConversationTypeGroup:
                [self sendGroupTextMessage:text];
                break;
            case JYBConversationTypeNoticeComment:
                [self sendNoticeTextMessage:text];
                break;
            default:
                break;
        }
    }
}

/**
 *  按下录音按钮开始录音
 */
- (void)didStartRecordingVoiceAction:(UIView *)recordView
{
    if ([self canRecord]) {
        DXRecordView *tmpView = (DXRecordView *)recordView;
        tmpView.center = self.view.center;
        [self.view addSubview:tmpView];
        [self.view bringSubviewToFront:recordView];
        int x = arc4random() % 100000;
        NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
        NSString *fileName = [NSString stringWithFormat:@"%d%d",(int)time,x];
        
        [[EMCDDeviceManager sharedInstance] asyncStartRecordingWithFileName:fileName
                                                                 completion:^(NSError *error)
         {
             if (error) {
                 DLog(@"开始录音失败");
             }
         }];
    }
}

/**
 *  手指向上滑动取消录音
 */
- (void)didCancelRecordingVoiceAction:(UIView *)recordView
{
     [[EMCDDeviceManager sharedInstance] cancelCurrentRecording];
}

/**
 *  松开手指完成录音
 */
- (void)didFinishRecoingVoiceAction:(UIView *)recordView
{
    __weak typeof(self) weakSelf = self;
    [[EMCDDeviceManager sharedInstance] asyncStopRecordingWithCompletion:^(NSString *recordPath, NSInteger aDuration, NSError *error) {
        if (!error) {
            //TODO: 会话类型 -- 添加类型
            switch (_chatType) {
                case JYBConversationTypeWhiteboard:
                    [weakSelf sendWhiteboardAudioMessage:recordPath duration:aDuration];
                    break;
                case JYBConversationTypeSingle:
                    [weakSelf sendSingleAudioMessage:recordPath duration:aDuration];
                    break;
                case JYBConversationTypeGroup:
                    [weakSelf sendGroupAudioMessage:recordPath duration:aDuration];
                    break;
                case JYBConversationTypeNoticeComment:
                    [weakSelf sendNoticeAudioMessage:recordPath duration:aDuration];
                    break;
                default:
                    break;
            }
            
        }else {
            [weakSelf showHudInView:self.view hint:@"录音时间太短了"];
            weakSelf.chatToolBar.recordButton.enabled = NO;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf hideHud];
                weakSelf.chatToolBar.recordButton.enabled = YES;
            });
        }
    }];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) {//视频
        NSURL *videoURL = info[UIImagePickerControllerMediaURL];
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum([videoURL path])) {
//            UISaveVideoAtPathToSavedPhotosAlbum([videoURL path], self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
        }
        [picker dismissViewControllerAnimated:YES completion:NULL];
        // video url:
        // file:///private/var/mobile/Applications/B3CDD0B2-2F19-432B-9CFA-158700F4DE8F/tmp/capture-T0x16e39100.tmp.9R8weF/capturedvideo.mp4
        // we will convert it to mp4 format
        NSURL *mp4 = [self convert2Mp4:videoURL];
        NSFileManager *fileman = [NSFileManager defaultManager];
        if ([fileman fileExistsAtPath:videoURL.path]) {
            NSError *error = nil;
            [fileman removeItemAtURL:videoURL error:&error];
            if (error) {
                NSLog(@"failed to remove file, error:%@.", error);
            }
        }
        //根据MP4将文件写入sandbox中
        NSString *toPath = [NSString createWhiteboardVideoFilePath];
        NSError *error = nil;
        [fileman copyItemAtPath:mp4.path toPath:toPath error:&error];
        
        AVURLAsset* audioAsset =[AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:toPath] options:nil];
        CMTime audioDuration = audioAsset.duration;
        float videoDurationSeconds =CMTimeGetSeconds(audioDuration) * 1000;//s * 1000 = ms
        //TODO: 会话类型 -- 添加类型
        switch (_chatType) {
            case JYBConversationTypeWhiteboard:
                [self sendWhiteboardVideoMessage:toPath duration:videoDurationSeconds];
                break;
            case JYBConversationTypeSingle:
                [self sendSingleVideoMessage:toPath duration:videoDurationSeconds];
                break;
            case JYBConversationTypeGroup:
                [self sendGroupVideoMessage:toPath duration:videoDurationSeconds];
                break;
            case JYBConversationTypeNoticeComment:
                [self sendNoticeVideoMessage:toPath duration:videoDurationSeconds];
                break;
            default:
                break;
        }
        
    }else{//图片
        UIImage *orgImage = info[UIImagePickerControllerOriginalImage];
        UIImageWriteToSavedPhotosAlbum(orgImage, nil, nil, nil);
        [picker dismissViewControllerAnimated:YES completion:NULL];
        //TODO: 会话类型 -- 添加类型
        switch (_chatType) {
            case JYBConversationTypeWhiteboard:
                [self sendWhiteboardImageMessage:orgImage];
                break;
            case JYBConversationTypeSingle:
                [self sendSingleImageMessage:orgImage];
                break;
            case JYBConversationTypeGroup:
                [self sendGroupImageMessage:orgImage];
                break;
            case JYBConversationTypeNoticeComment:
                [self sendNoticeImageMessage:orgImage];
                break;
            default:
                break;
        }
        
    }
    self.isInvisible = NO;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
    self.isInvisible = NO;
}

//视频保存后的回调
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
}

#pragma mark - DXChatBarMoreViewDelegate
- (void)moreViewTakePicAction:(DXChatBarMoreView *)moreView;
{
    // 隐藏键盘
    [self keyBoardHidden];
    [self showImagePickViewControllerWithSourceType:UIImagePickerControllerSourceTypeCamera isVideo:NO];
    self.isInvisible = YES;
}

- (void)moreViewPhotoAction:(DXChatBarMoreView *)moreView
{
    // 隐藏键盘
    [self keyBoardHidden];
    [self showImagePickViewControllerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary isVideo:NO];
    self.isInvisible = YES;
}

- (void)moreViewVideoAction:(DXChatBarMoreView *)moreView
{
    // 隐藏键盘
    [self keyBoardHidden];
    [self showImagePickViewControllerWithSourceType:UIImagePickerControllerSourceTypeCamera isVideo:YES];
}

- (void)moreViewFileAction:(DXChatBarMoreView *)moreView
{
    // 隐藏键盘
    [self keyBoardHidden];
    [self showHint:@"iOS 暂无Word、Text、PPT、PDF等文件！"];
}

#pragma mark - GestureRecognizer
// 点击背景隐藏
-(void)keyBoardHidden
{
    [self.chatToolBar endEditing:YES];
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan && [self.dataSource count] > 0) {
        CGPoint location = [recognizer locationInView:self.tableView];
        NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:location];
        id object = [self.dataSource objectAtIndex:indexPath.row];
        if ([object isKindOfClass:[JYBIChatMessage class]]) {
            IChatViewCell *cell = (IChatViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            [cell becomeFirstResponder];
            _longPressIndexPath = indexPath;
            [self showMenuViewController:cell.bubbleView andIndexPath:indexPath messageType:cell.messageEntity.messageBodyType];
        }
    }
}

#pragma mark - UIResponder actions
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    JYBIChatMessage *model = [userInfo objectForKey:KMESSAGEKEY];
    
    if ([eventName isEqualToString:kRouterEventAudioBubbleTapEventName]) {
        [self chatAudioCellBubblePressed:model];
    } else if ([eventName isEqualToString:kRouterEventImageBubbleTapEventName]) {
        [self chatImageCellBubblePressed:model];
    } else if ([eventName isEqualToString:kRouterEventChatCellVideoTapEventName]) {
        [self chatVideoCellPressed:model];
    } else if ([eventName isEqualToString:kRouterEventChatHeadImageTapEventName]) {
        [self pushProfileDetailControllerWithIChatMessage:model];
    }
}

// 语音的bubble被点击
- (void)chatAudioCellBubblePressed:(JYBIChatMessage *)model
{
    if (model.messageBodyType != JYBIMMessageBodyTypeAudio) {
        return;
    }
    
    if (!model.localPath) {
        //下载语音
        [JYBFileDownloadHandler downloadAudioWithIChatMessage:model finished:^(NSString *localPath) {
            model.localPath = localPath;
            [self chatAudioPlayer:model];
        }];
        return;
    }
    [self chatAudioPlayer:model];
    
}

- (void)chatAudioPlayer:(JYBIChatMessage *)model
{
    __weak JYBChatViewController *weakSelf = self;
    BOOL isPrepare = [self.messageReadManager prepareMessageAudioModel:model updateViewCompletion:^(JYBIChatMessage *prevAudioModel, JYBIChatMessage *currentAudioModel) {
        if (prevAudioModel || currentAudioModel) {
            [weakSelf.tableView reloadData];
        }
    }];
    
    if (isPrepare) {
        _isPlayingAudio = YES;
        __weak JYBChatViewController *weakSelf = self;
        [[EMCDDeviceManager sharedInstance] enableProximitySensor];
        NSString *recordPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        [[EMCDDeviceManager sharedInstance] asyncPlayingWithPath:[recordPath stringByAppendingFormat:@"%@",model.localPath] completion:^(NSError *error) {
            [weakSelf.messageReadManager stopMessageAudioModel];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
                weakSelf.isPlayingAudio = NO;
                [[EMCDDeviceManager sharedInstance] disableProximitySensor];
            });
        }];
    }
    else{
        _isPlayingAudio = NO;
    }
}

// 图片的bubble被点击
-(void)chatImageCellBubblePressed:(JYBIChatMessage *)model
{
    if (model.messageBodyType == JYBIMMessageBodyTypeImage) {
        [self.messageReadManager showBrowserWithImages:@[[NSURL URLWithString:JYBBcfHttpUrl(model.remoteUrl)]]];
    };
}

- (void)chatVideoCellPressed:(JYBIChatMessage *)model
{
    if (model.localPath && model.localPath.length > 0)
    {
        [self playVideoWithVideoPath:[JYB_LibraryDirectoryPath() stringByAppendingString:model.localPath]];
        return;
    }
    [self showHudInView:self.view hint:@"下载视频中..."];
    [self downloadVideoInfoWithVideoUrl:model.remoteUrl complete:^(BOOL finished, NSString *localPath) {
        if (!finished) {
        } else {
            //update DB
            if (localPath && localPath.length > 0) {
                [self playVideoWithVideoPath:localPath];
                model.localPath = [NSString handleInterceptLibraryResourcePath:localPath];
                if ([model.videoThumbnailPath length]) {
                    model.image = [UIImage imageWithContentsOfFile:[JYB_LibraryDirectoryPath() stringByAppendingFormat:@"%@", model.videoThumbnailPath]];
                } else {
                    model.image = [UIImage thumbnailImageForVideo:[NSURL URLWithString:[JYB_LibraryDirectoryPath() stringByAppendingFormat:@"%@", model.localPath]]];
                }
                [[BDIMDatabaseUtil sharedInstance] updateIChatMessageWithIChatMessage:model success:^{}];
            }
        }
    }];
}

- (void)downloadVideoInfoWithVideoUrl:(NSString *)videoUrl complete:(void(^)(BOOL finished, id localPath))complete
{
    JYBDownloadFileApi *api = [[JYBDownloadFileApi alloc] initWithDownloadFileUrl:JYBBcfHttpUrl(videoUrl) type:JYBDownloadFileTypeMP4];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        DLog(@"%@",request.responseJSONObject);
        [self hideHud];
        NSString *videoPath = request.responseJSONObject;
        if (videoPath == nil) {
            if (complete) {
                complete(NO, @"");
            }
        } else {
            if (complete) {
                complete(YES, videoPath);
            }
        }
        
    } failure:^(__kindof YTKBaseRequest *request) {
        DLog(@"%@",request.requestOperation.error);
        [self showHint:@"网络异常！"];
    }];
}

- (void)playVideoWithVideoPath:(NSString *)videoPath
{
//    _isScrollToBottom = NO;
    NSURL *videoURL = [NSURL fileURLWithPath:videoPath];
    MPMoviePlayerViewController *moviePlayerController = [[MPMoviePlayerViewController alloc] initWithContentURL:videoURL];
    [moviePlayerController.moviePlayer prepareToPlay];
    moviePlayerController.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
    [self presentMoviePlayerViewControllerAnimated:moviePlayerController];
}

- (void)pushProfileDetailControllerWithIChatMessage:(JYBIChatMessage *)message
{
    NSString *fromId = [RuntimeStatus sharedInstance].userItem.userId;
    JYBFriendItem *userItem = nil;
    
    if ([fromId isEqualToString:message.fromUserID]) {
        userItem = [[JYBFriendItemTool friends:fromId] firstObject];
    } else {
        userItem = [[JYBFriendItemTool friends:message.fromUserID] firstObject];
    }
    
    if (userItem) {
        [self pushNextController:@"JYBPersonalInformationViewController" hidesBottomBarWhenPushed:YES complete:^(UIViewController *vCtrl) {
            [(JYBPersonalInformationViewController *)vCtrl setFriendItem:userItem];
        }];
    }
    
}

//MARK: Other
- (void)showImagePickViewControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType isVideo:(BOOL)isVideo
{
    UIImagePickerController *controller = nil;
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            if ([self isAuthorCamera]) {
                controller = [[UIImagePickerController alloc] init];
                controller.sourceType = sourceType;
                if ([self isRearCameraAvailable]) {
                    controller.cameraDevice = UIImagePickerControllerCameraDeviceRear;
                    [self presentImagePickerController:controller isVideo:isVideo];
                }
            } else {
                NSString *msg = [NSString stringWithFormat:@"请在iPhone的\"设置-隐私-相机\"中允许访问相机"];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法使用相机" message:msg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                [alert show];
            }
        } else {
            NSString *msg = [NSString stringWithFormat:@"请检查iPhone的相机"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法使用相机" message:msg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alert show];
        }
    } else if (sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        if ([self isPhotoLibraryAvailable]) {
            if ([self isAuthorAssetsLibray]) {
                controller = [[UIImagePickerController alloc] init];
                controller.sourceType = sourceType;
                [self presentImagePickerController:controller isVideo:isVideo];
            } else {
                NSString *msg = [NSString stringWithFormat:@"请在iPhone的\"设置-隐私-照片\"中允许访问照片"];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法使用相册" message:msg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                [alert show];
            }
        } else {
            NSString *msg = [NSString stringWithFormat:@"请检查iPhone的相册"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法相册" message:msg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
    
}

- (void)presentImagePickerController:(UIImagePickerController *)picker isVideo:(BOOL)isVideo
{
    if (isVideo) {
        picker.mediaTypes = @[(__bridge NSString *)kUTTypeMovie];
        picker.videoQuality = UIImagePickerControllerQualityTypeLow;
        picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
        picker.videoMaximumDuration = 30;//录制视频最大时长30''
    } else {
        picker.mediaTypes = @[(__bridge NSString *)kUTTypeImage];
    }
    picker.allowsEditing = YES;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:NULL];
}

- (BOOL)canRecord
{
    __block BOOL bCanRecord = YES;
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
    {
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                bCanRecord = granted;
            }];
        }
    }
    
    return bCanRecord;
}

- (void)showMenuViewController:(UIView *)showInView andIndexPath:(NSIndexPath *)indexPath messageType:(JYBIMMessageBodyType)messageType
{
    if (_menuController == nil) {
        _menuController = [UIMenuController sharedMenuController];
    }
    if (_copyMenuItem == nil) {
        _copyMenuItem = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyMenuAction:)];
    }
    if (_deleteMenuItem == nil) {
        _deleteMenuItem = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(deleteMenuAction:)];
    }
    
    if (messageType == JYBIMMessageBodyTypeText) {
        [_menuController setMenuItems:@[_copyMenuItem, _deleteMenuItem]];
    }
    else{
        [_menuController setMenuItems:@[_deleteMenuItem]];
    }
    
    [_menuController setTargetRect:showInView.frame inView:showInView.superview];
    [_menuController setMenuVisible:YES animated:YES];
}

- (NSURL *)convert2Mp4:(NSURL *)movUrl {
    NSURL *mp4Url = nil;
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:movUrl options:nil];
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    if ([compatiblePresets containsObject:AVAssetExportPresetHighestQuality]) {
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]initWithAsset:avAsset
                                                                              presetName:AVAssetExportPresetHighestQuality];
        mp4Url = [movUrl copy];
        mp4Url = [mp4Url URLByDeletingPathExtension];
        mp4Url = [mp4Url URLByAppendingPathExtension:@"mp4"];
        exportSession.outputURL = mp4Url;
        exportSession.shouldOptimizeForNetworkUse = YES;
        exportSession.outputFileType = AVFileTypeMPEG4;
        dispatch_semaphore_t wait = dispatch_semaphore_create(0l);
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            switch ([exportSession status]) {
                case AVAssetExportSessionStatusFailed: {
                    NSLog(@"failed, error:%@.", exportSession.error);
                } break;
                case AVAssetExportSessionStatusCancelled: {
                    NSLog(@"cancelled.");
                } break;
                case AVAssetExportSessionStatusCompleted: {
                    NSLog(@"completed.");
                } break;
                default: {
                    NSLog(@"others.");
                } break;
            }
            dispatch_semaphore_signal(wait);
        }];
        long timeout = dispatch_semaphore_wait(wait, DISPATCH_TIME_FOREVER);
        if (timeout) {
            NSLog(@"timeout.");
        }
        if (wait) {
            //dispatch_release(wait);
            wait = nil;
        }
    }
    
    return mp4Url;
}


- (void)scrollViewToBottom:(BOOL)animated
{
    if (self.tableView.contentSize.height > self.tableView.frame.size.height)
    {
        CGPoint offset = CGPointMake(0, self.tableView.contentSize.height - self.tableView.frame.size.height);
        [self.tableView setContentOffset:offset animated:animated];
    }
}

/** 
 发送消息这块 没有设计好 这样的设计冗余太大
 时间有限 先说下后期设计方案：
 设计一个IChatManager管理类，负责发送消息，解析消息由MessageModule负责
 因为发送消息是走http的，所以接口Api在设计上同样重要，也应由一个SendMessageApiManager进行管理
 这样将会降低`ChatController`的冗余量... ...
 
 最好呢，用一个或多个delegate设计模式，将可能的部（属性和接口）分抽离出来, 具体的类继承Protocol实现具体协议方法和属性... ...
 
 目前存在问题：
 * 功能上基本实现，存在少量不合理之处，具体未知（等于没说 囧！！！）。
 * 未对发送失败做任何处理！！！
 
 ********************
 *发送失败处理方案：*
 ********************
 
 》在发送一条消息之前先将message存入数据库，难点：messageID无法确定；
 》发送成功后update消息数据库；
 》若发送失败，将会出现 惊叹号 标记发送失败的消息，点击重发后将进行重新发送
 》消息重发的按钮在BubbleView中有定义，但给注释了，稍微改改即可使用
 
 * 下面的发送接口`send...Message:`将会成线性增加当前`ChatController`的冗余量
 
 **/

#pragma mark - 企业白板
- (void)sendWhiteboardTextMessage:(NSString *)text
{
    [_whiteboardHandle sendText:text success:^(id message) {
        if ([message isKindOfClass:[JYBIChatMessage class]]) {
            [self addMessage:message];
        }
    } failure:^(NSString *error) {
        [self showHint:error];
    }];
}

- (void)sendWhiteboardAudioMessage:(NSString *)audioPath duration:(NSInteger)duration
{
    [_whiteboardHandle sendAudio:audioPath duration:duration success:^(id message){
        if ([message isKindOfClass:[JYBIChatMessage class]]) {
            [self addMessage:message];
        }
    } failure:^(NSString *error){
        [self showHint:error];
    }];
}

- (void)sendWhiteboardImageMessage:(UIImage *)image
{
    //思路：
    /*
    先插入DB中，HTTP发送成功后，delete message & insert message
     */
    [_whiteboardHandle sendImage:image success:^(id message) {
        if ([message isKindOfClass:[JYBIChatMessage class]]) {
            [self addMessage:message];
        }
    } failure:^(NSString *error) {
        [self showHint:error];
    }];
}

- (void)sendWhiteboardVideoMessage:(NSString *)videoPath duration:(NSInteger)duration
{
    [_whiteboardHandle sendVideo:videoPath duration:duration success:^(id message) {
        if ([message isKindOfClass:[JYBIChatMessage class]]) {
            [self addMessage:message];
        }
    } failure:^(NSString *error) {
        [self showHint:error];
    }];
}

#pragma mark - 单聊
- (void)sendSingleTextMessage:(NSString *)text
{
    [_singleChatHandle sendText:text success:^(id message) {
        if ([message isKindOfClass:[JYBIChatMessage class]]) {
            [self addMessage:message];
        }
    } failure:^(NSString *error) {
        [self showHint:error];
    }];
}

- (void)sendSingleAudioMessage:(NSString *)audioPath duration:(NSInteger)duration
{
    [_singleChatHandle sendAudio:audioPath duration:duration success:^(id message){
        if ([message isKindOfClass:[JYBIChatMessage class]]) {
            [self addMessage:message];
        }
    } failure:^(NSString *error){
        [self showHint:error];
    }];
}

- (void)sendSingleImageMessage:(UIImage *)image
{
    [_singleChatHandle sendImage:image success:^(id message) {
        if ([message isKindOfClass:[JYBIChatMessage class]]) {
            [self addMessage:message];
        }
    } failure:^(NSString *error) {
        [self showHint:error];
    }];
}

- (void)sendSingleVideoMessage:(NSString *)videoPath duration:(NSInteger)duration
{
    [_singleChatHandle sendVideo:videoPath duration:duration success:^(id message) {
        if ([message isKindOfClass:[JYBIChatMessage class]]) {
            [self addMessage:message];
        }
    } failure:^(NSString *error) {
        [self showHint:error];
    }];
}

#pragma mark - 群聊
- (void)sendGroupTextMessage:(NSString *)text
{
    [_groupChatHandle sendText:text success:^(id message) {
        if ([message isKindOfClass:[JYBIChatMessage class]]) {
            [self addMessage:message];
        }
    } failure:^(NSString *error) {
        [self showHint:error];
    }];
}

- (void)sendGroupAudioMessage:(NSString *)audioPath duration:(NSInteger)duration
{
    [_groupChatHandle sendAudio:audioPath duration:duration success:^(id message) {
        if ([message isKindOfClass:[JYBIChatMessage class]]) {
            [self addMessage:message];
        }
    } failure:^(NSString *error) {
        [self showHint:error];
    }];
}

- (void)sendGroupImageMessage:(UIImage *)image
{
    [_groupChatHandle sendImage:image success:^(id message) {
        if ([message isKindOfClass:[JYBIChatMessage class]]) {
            [self addMessage:message];
        }
    } failure:^(NSString *error) {
        [self showHint:error];
    }];
}

- (void)sendGroupVideoMessage:(NSString *)videoPath duration:(NSInteger)duration
{
    [_groupChatHandle sendVideo:videoPath duration:duration success:^(id message) {
        if ([message isKindOfClass:[JYBIChatMessage class]]) {
            [self addMessage:message];
        }
    } failure:^(NSString *error) {
        [self showHint:error];
    }];
}

#pragma mark - 工单
//- (void)sendBillTextMessage:(NSString *)text;{}

//- (void)sendBillAudioMessage:(NSString *)audioPath duration:(NSInteger)duration;{}

//- (void)sendBillImageMessage:(UIImage *)image;{}

//- (void)sendBillVideoMessage:(NSString *)videoPath duration:(NSInteger)duration;{}
#pragma mark - 质量检查
//- (void)sendQualityCheckTextMessage:(NSString *)text;{}

//- (void)sendQualityCheckAudioMessage:(NSString *)audioPath duration:(NSInteger)duration;{}

//- (void)sendQualityCheckImageMessage:(UIImage *)image;{}

//- (void)sendQualityCheckVideoMessage:(NSString *)videoPath duration:(NSInteger)duration;{}
#pragma mark - 安全检查
//- (void)sendSafetyCheckTextMessage:(NSString *)text;{}

//- (void)sendSafetyCheckAudioMessage:(NSString *)audioPath duration:(NSInteger)duration;{}

//- (void)sendSafetyCheckImageMessage:(UIImage *)image;{}

//- (void)sendSafetyCheckVideoMessage:(NSString *)videoPath duration:(NSInteger)duration;{}
#pragma mark - 日常巡查
//- (void)sendDailyInspectTextMessage:(NSString *)text;{}

//- (void)sendDailyInspectAudioMessage:(NSString *)audioPath duration:(NSInteger)duration;{}

//- (void)sendDailyInspectImageMessage:(UIImage *)image;{}

//- (void)sendDailyInspectVideoMessage:(NSString *)videoPath duration:(NSInteger)duration;{}
#pragma mark - 通知通告
- (void)sendNoticeTextMessage:(NSString *)text
{
    [_noticeChatHandle sendText:text success:^(id message) {
        if ([message isKindOfClass:[JYBIChatMessage class]]) {
            [self addMessage:message];
        }
    } failure:^(NSString *error) {
        [self showHint:error];
    }];
}

- (void)sendNoticeAudioMessage:(NSString *)audioPath duration:(NSInteger)duration
{
    [_noticeChatHandle sendAudio:audioPath duration:duration success:^(id message) {
        if ([message isKindOfClass:[JYBIChatMessage class]]) {
            [self addMessage:message];
        }
    } failure:^(NSString *error) {
        [self showHint:error];
    }];
}

- (void)sendNoticeImageMessage:(UIImage *)image
{
    [_noticeChatHandle sendImage:image success:^(id message) {
        if ([message isKindOfClass:[JYBIChatMessage class]]) {
            [self addMessage:message];
        }
    } failure:^(NSString *error) {
        [self showHint:error];
    }];
}

- (void)sendNoticeVideoMessage:(NSString *)videoPath duration:(NSInteger)duration
{
    [_noticeChatHandle sendVideo:videoPath duration:duration success:^(id message) {
        if ([message isKindOfClass:[JYBIChatMessage class]]) {
            [self addMessage:message];
        }
    } failure:^(NSString *error) {
        [self showHint:error];
    }];
}
//清记录
- (void)clearCache{
    [[BDIMDatabaseUtil sharedInstance] deleteIchatMessageWithMsgs:self.messages success:^{}];
    [self.messages removeAllObjects];
    [self.dataSource removeAllObjects];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
