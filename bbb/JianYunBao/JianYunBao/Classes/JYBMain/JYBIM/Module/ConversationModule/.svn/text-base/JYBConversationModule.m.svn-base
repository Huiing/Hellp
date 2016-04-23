//
//  JYBConversationModule.m
//  JianYunBao
//
//  Created by 冰点 on 16/3/12.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBConversationModule.h"
#import "JYBIChatMessage.h"
#import "BDIMDatabaseUtil.h"

@interface JYBConversationModule ()
{
    NSMutableDictionary *_conversations;
}

- (void)didReceiveIChatMessage:(NSNotification *)notification;

- (NSArray <JYBConversation *> *)getConversationsWithConverationType:(JYBConversationType)conversationType;

@end

@implementation JYBConversationModule

+ (instancetype)sharedInstance {
    static JYBConversationModule * _someCls = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _someCls = [[JYBConversationModule alloc] init];
    });
    return _someCls;
}

- (instancetype)init
{
    if (self = [super init]) {
        _conversations = [NSMutableDictionary dictionary];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveIChatMessage:) name:JYBNotificationReceiveMessage object:nil];
    }
    return self;
}

#pragma mark - private
- (void)didReceiveIChatMessage:(NSNotification *)notification
{
    id message = [notification object];
    if (![message isKindOfClass:[JYBIChatMessage class]]) return;
    [self buildConversationWithIChatMessage:message];
    if ([self.delegate respondsToSelector:@selector(conversationModule:didUnreadMessagesChanged:)]) {
        [self.delegate conversationModule:self didUnreadMessagesChanged:message];
    }
}

- (void)buildConversationWithIChatMessage:(JYBIChatMessage *)message
{
    JYBConversation *conversation = nil;
    
    if ([[_conversations allKeys] containsObject:message.conversationChatter]) {//更新会话
        conversation = [_conversations objectForKey:message.conversationChatter];
        conversation.lastMsgId = message.messageID;
        conversation.lastMsg = message.content;
        conversation.timestamp = message.timestamp;
        //还缺当前会话判断...
        if (![conversation.chatter isEqualToString:[RuntimeStatus sharedInstance].userItem.userId]) {
            conversation.unreadCount += 1;
        }
    } else {//添加会话
        switch (message.messageType) {
            case JYBIMMessageTypeWhiteboard:
                conversation = [[JYBConversation alloc] initWithChatter:message.conversationChatter conversationtype:JYBConversationTypeWhiteboard];
                break;
            case JYBIMMessageTypeSingle:
                 conversation = [[JYBConversation alloc] initWithChatter:message.conversationChatter conversationtype:JYBConversationTypeSingle];
                break;
            case JYBIMMessageTypeGroup:
                conversation = [[JYBConversation alloc] initWithChatter:message.conversationChatter conversationtype:JYBConversationTypeGroup];
                break;
            default:
                break;
        }
        
        if (conversation == nil) {
            return;
        }
       
        conversation.lastMsgId = message.messageID;
        conversation.lastMsg = message.content;
        conversation.timestamp = message.timestamp;
        if (![conversation.chatter isEqualToString:[RuntimeStatus sharedInstance].userItem.userId]) {
            conversation.unreadCount += 1;
        }
        //...
        [self addConversation:conversation];
    }
    //...db
    [[BDIMDatabaseUtil sharedInstance] insertConversations:@[conversation]];
    _conversation = conversation;
}

#pragma mark - public

//- (void)getRecentConversation:(void(^)())complete
//{
//    NSArray <JYBConversation *>*array = [[BDIMDatabaseUtil sharedInstance] getAllConversationsWithType:JYBConversationTypeSingle];
//    [self addConversations:array];
//    if (complete) {
//        complete();
//    }
//}

- (NSArray <JYBConversation *>*)getAllConversation
{
//    NSArray <NSNumber *>*conversationTypes = @[@(JYBConversationTypeSingle), @(JYBConversationTypeWhiteboard)];
//   [conversationTypes enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//       [self getRecentConversationWithConversationType:[obj integerValue]];
//   }];
    
    NSArray <JYBConversation *> *conversations = [[BDIMDatabaseUtil sharedInstance] getAllConversations];
    [self addConversations:conversations];
    return [_conversations allValues];
}

-(void)addConversation:(JYBConversation *)conversation
{
    if (conversation) {
        [_conversations safeSetObject:conversation forKey:conversation.chatter];
    }
}

-(void)addConversations:(NSArray <JYBConversation *>*)conversations
{
    [conversations enumerateObjectsUsingBlock:^(JYBConversation * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addConversation:obj];
    }];
}

-(JYBConversation *)getConversationWithChatter:(NSString *)chatter
{
    return [_conversations safeObjectForKey:chatter];
}

-(void)removeConversationFromDB:(JYBConversation *)conversation;
{
    BOOL ret = [[BDIMDatabaseUtil sharedInstance] deleteConversationWithChatter:conversation.chatter];
    if (!ret) {
        DLog(@"最近会话删除失败：chatter:%@", conversation.chatter);
    }
     [_conversations removeObjectForKey:conversation.chatter];
}

-(void)clearConversations
{
    
    [[_conversations allValues] enumerateObjectsUsingBlock:^(JYBConversation  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self removeConversationFromDB:obj];
    }];
}

-(NSUInteger)getAllUnreadMessageCount
{
    NSArray <JYBConversation *>*allConversation = [self getAllConversation];
    [self addConversations:allConversation];
    return [self unreadCountWithConversations:allConversation];
}

- (NSUInteger)getUnreadMessageCountWith:(JYBConversationType)conversationType
{
    return [self unreadCountWithConversations:[self getConversationsWithConverationType:conversationType]];
}

#pragma mark - private
- (NSUInteger)unreadCountWithConversations:(NSArray *)conversations
{
    __block NSUInteger count = 0;
    [conversations enumerateObjectsUsingBlock:^(JYBConversation * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSUInteger unreadCount = obj.unreadCount;
        count += unreadCount;
    }];
    return count;
}

- (NSArray<JYBConversation *> *)getConversationsWithConverationType:(JYBConversationType)conversationType
{
    return [[BDIMDatabaseUtil sharedInstance] getAllConversationsWithType:conversationType];
}

///获取对应的会话列表
- (NSArray <JYBConversation *>*)getRecentConversationWithConversationType:(JYBConversationType)conversationType
{
    NSArray <JYBConversation *>*array = [[BDIMDatabaseUtil sharedInstance] getAllConversationsWithType:conversationType];
    [self addConversations:array];
    return array;
}

@end
