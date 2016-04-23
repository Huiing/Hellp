//
//  BDIMDatabaseUtil.h
//  JianYunBao
//
//  Created by 冰点 on 16/3/1.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@class JYBIChatMessage;
@class JYBConversation;
@class JYBSyncGroupModel;

@interface BDIMDatabaseUtil : NSObject

+ (instancetype)sharedInstance;

- (void)openCurrentUserDB;

- (void)deleteAllDB;

@end

@interface BDIMDatabaseUtil (Message)

/************************* 消息 *************************/
/*!
 *  @brief 批量插入message，需要用户必须在线，避免插入离线时阅读的消息
 *
 *  @param messages `JYBIChatMessage`集合
 *  @param success  插入成功
 *  @param failure  插入失败
 */

- (void)insertIChatMessages:(NSArray <JYBIChatMessage *>*)messages success:(void(^)())success failure:(void(^)(NSString *errorDescripe))failure;

/*!
 *  @brief 删除指定的消息
 *
 *  @param messageID 消息id
 *  @param success   删除成功
 */
- (void)deleteIChatMessageWithMsgID:(NSString *)msgID success:(void(^)())success;

/*!
 *  @brief 删除所有消息
 *
 *  @param msgs 所有消息
 *  @param success   删除成功
 */
- (void)deleteIchatMessageWithMsgs:(NSArray *)msgs success:(void (^)())success;

- (void)updateIChatMessageWithIChatMessage:(JYBIChatMessage *)message success:(void(^)())success;

/*!
 *  @brief 分页获取聊天记录
 *
 *  @param conversationChatter 会话者
 *  @param page                页数 1开始
 *  @param count               每页消息数
 *  @param success             获取消息成功
 *  @param failure             获取消息失败
 *
 *  @return `JYBIChatMessage`集合
 */
- (NSArray *)getIChatMessagesWithConversationChatter:(NSString *)conversationChatter page:(NSInteger)page count:(NSInteger)count success:(void(^)(NSArray *))success failure:(void(^)(NSError *))failure;
- (JYBIChatMessage *)getLastIChatMessageWithMessageId:(NSString *)messageId;

/************************* 最近会话 *************************/

- (BOOL)insertConversations:(NSArray *)conversations;
- (BOOL)deleteConversationWithChatter:(NSString *)chatter;
- (BOOL)updateConversation:(JYBConversation *)conversation;
- (NSArray <JYBConversation *>*)getAllConversations;
- (NSArray <JYBConversation *>*)getAllConversationsWithType:(JYBConversationType)conversationType;

/************************* 群组 *************************/
- (BOOL)insertGroup:(NSArray <JYBSyncGroupModel *>*)groups;
- (BOOL)deleteGroupWithSid:(NSString *)sid;
- (BOOL)updateGroup:(JYBSyncGroupModel *)group;
- (NSArray <JYBSyncGroupModel *> *)getAllGroups;
- (JYBSyncGroupModel *)getGroupWithSid:(NSString *)sid;

@end
