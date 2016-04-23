//
//  JYBConversationModule.h
//  JianYunBao
//  最近会话管理类
//  Created by 冰点 on 16/3/12.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYBConversation.h"

@class JYBConversationModule;
@protocol ConversationModuleDelegate <NSObject>

@optional
- (void)conversationModule:(JYBConversationModule *)module didUnreadMessagesChanged:(JYBIChatMessage *)message;
@end

@interface JYBConversationModule : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, assign) id <ConversationModuleDelegate> delegate;

@property (nonatomic, readonly, strong) JYBConversation *conversation;

- (NSArray <JYBConversation *>*)getAllConversation;
- (void)addConversation:(JYBConversation *)conversation;
- (void)addConversations:(NSArray <JYBConversation *>*)conversations;
- (JYBConversation *)getConversationWithChatter:(NSString *)chatter;
- (void)removeConversationFromDB:(JYBConversation *)conversation;
- (void)clearConversations;

//获取所有的未读消息
- (NSUInteger)getAllUnreadMessageCount;

///根据条件获取相应的未读消息
- (NSUInteger)getUnreadMessageCountWith:(JYBConversationType)conversationType;

- (NSArray <JYBConversation *>*)getRecentConversationWithConversationType:(JYBConversationType)conversationType;
@end
