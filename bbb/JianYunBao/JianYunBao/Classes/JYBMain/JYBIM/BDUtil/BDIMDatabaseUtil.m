//
//  BDIMDatabaseUtil.m
//  JianYunBao
//
//  Created by 冰点 on 16/3/1.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "BDIMDatabaseUtil.h"
#import "NSString+BDPath.h"
#import "JYBUserEntity.h"
#import "JYBIChatMessage.h"
#import "JYBConversation.h"
#import "JYBSyncGroupModel.h"
#import "NSString+BDExtension.h"

#define DB_FILE_NAME             @"JianYunBao.sqlite"

/** 数据库表 名称**/
#define DB_TABLE_ICHAT_MESSAGE @"tb_IChatMessage"
#define DB_TABLE_CONVERSATION       @"tb_conversation"
#define DB_TABLE_GROUP              @"tb_group"

/*
 ------- 消息数据库 -------
 messageID - - - 消息id
 commandID - - - 指令id
 fromUserID - - - 发送方id
 userName - - - 发送方用户名
 toUserID - - - 接收方id
 conversationChatter - - - 会话者
 nodeId - - - 节点id
 content - - - 消息内容
 timestamp - - - 服务器时间戳
 messageBodyType - - - 消息体类型
 remoteUrl - - - 网络网址
 duration - - - 文件时长
 videoThumbnailPath - - - 视频封面图本地缓存地址
 localPath - - - 本地缓存地址
 fileSize - - - 文件大小
 isRead - - - 是否已读 NO-未读
 
 NOTE: add nodeId string
 */
#define SQL_CREATE_ICHAT_MESSAGE              [NSString stringWithFormat:@"create table if not exists %@ (\
messageID text, commandID integer, fromUserID text, userName text, toUserID text, \
conversationChatter text, nodeId text, content text, timestamp integer, \
messageBodyType integer, remoteUrl text, duration integer, \
videoThumbnailPath text, localPath text, fileSize integer, isRead integer, primary key (messageID));", DB_TABLE_ICHAT_MESSAGE]

/*
 ------- 最近会话数据库 -------
 chatter- - - 会话id
 conversationType - - - 会话类型
 avatar - - - 用户头像
 name - - - 昵称
 lastMsgId - - - 消息id
 lastMsg - - - 消息内容
 unreadCount
 timestamp - - - 时间戳13位
 */
#define SQL_CREATE_CONVERSATION [NSString stringWithFormat:@"create table if not exists %@ (\
chatter text, conversationType integer, avatar text, name text, lastMsgId text, \
lastMsg text, unreadCount integer, timestamp integer, primary key (chatter));", DB_TABLE_CONVERSATION]

/*
 ------- 群组数据库 -------
 userId- - - 创建用户ID
 userName - - - 创建用户姓名
 sid - - - 工单主键ID
 enterpriseCode - - - 企业号
 version - - - 聊天群组版本号
 createDate - - - 创建时间 yyyy-mm-dd
 name - - - 群名称
 userIds
 */
#define SQL_CREATE_GROUP [NSString stringWithFormat:@"create table if not exists %@ (\
userId text, userName text, sid text, enterpriseCode text, version integer, createDate text,\
name text,  userIds text, primary key (sid));", DB_TABLE_GROUP]

@implementation BDIMDatabaseUtil
{
    FMDatabase* _database;
    FMDatabaseQueue* _dataBaseQueue;
}

+ (instancetype)sharedInstance {
    static BDIMDatabaseUtil * _someCls = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _someCls = [[BDIMDatabaseUtil alloc] init];
    });
    return _someCls;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self openCurrentUserDB];
    }
    return self;
}

- (void)openCurrentUserDB
{
    if (_database) {
        [_database close];
        _database = nil;
    }
    _dataBaseQueue  = [FMDatabaseQueue databaseQueueWithPath:[BDIMDatabaseUtil dbFilePath]];
    _database = [FMDatabase databaseWithPath:[BDIMDatabaseUtil dbFilePath]];
    if (![_database open]) {
        DLog(@"打开数据库失败");
    } else {
        [_dataBaseQueue inDatabase:^(FMDatabase *db) {
            if (![_database tableExists:SQL_CREATE_ICHAT_MESSAGE]) {
                [self createTable:SQL_CREATE_ICHAT_MESSAGE];
            }
            
            if (![_database tableExists:SQL_CREATE_CONVERSATION]) {
                [self createTable:SQL_CREATE_CONVERSATION];
            }
            
            if (![_database tableExists:SQL_CREATE_GROUP]) {
                [self createTable:SQL_CREATE_GROUP];
            }
        }];
    }
    
}

///待完善
- (void)deleteAllDB
{
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:[BDIMDatabaseUtil dbFilePath]]) {
        NSError *err = nil;
       BOOL ret = [fm removeItemAtPath:[BDIMDatabaseUtil dbFilePath] error:&err];
        if (ret) {
            [self openCurrentUserDB];
        }
    }
    
}

+(NSString *)dbFilePath
{
    NSString* directorPath = [NSString userExclusiveDirection];
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    
    //该用户的db是否存在，若不存在则创建相应的DB目录
    BOOL isDirector = NO;
    BOOL isExiting = [fileManager fileExistsAtPath:directorPath isDirectory:&isDirector];
    
    if (!(isExiting && isDirector))
    {
        BOOL createDirection = [fileManager createDirectoryAtPath:directorPath
                                      withIntermediateDirectories:YES
                                                       attributes:nil
                                                            error:nil];
        if (!createDirection)
        {
            DLog(@"创建DB目录失败");
        }
    }
    
    NSString *dbPath = [directorPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_%@",[RuntimeStatus sharedInstance].userEntity.userid,DB_FILE_NAME]];
    return dbPath;
}

-(BOOL)createTable:(NSString *)sql
{
    BOOL result = NO;
    [_database setShouldCacheStatements:YES];
    NSString *tempSql = [NSString stringWithFormat:@"%@",sql];
    result = [_database executeUpdate:tempSql];
    
    return result;
}

-(BOOL)clearTable:(NSString *)tableName
{
    BOOL result = NO;
    [_database setShouldCacheStatements:YES];
    NSString *tempSql = [NSString stringWithFormat:@"delete from %@",tableName];
    result = [_database executeUpdate:tempSql];
    return result;
}

#pragma mark - public M

#pragma mark - ***** 消息 *****
- (void)insertIChatMessages:(NSArray<JYBIChatMessage *> *)messages success:(void (^)())success failure:(void (^)(NSString *))failure
{
    [_dataBaseQueue inDatabase:^(FMDatabase *db) {
        [_database beginTransaction];
        __block BOOL isRollBack = NO;
        @try {
            [messages enumerateObjectsUsingBlock:^(JYBIChatMessage *message, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString* sql = [NSString stringWithFormat:@"insert or replace into %@ values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",DB_TABLE_ICHAT_MESSAGE];
                BOOL result = [_database executeUpdate:sql, message.messageID, @(message.commandID), message.fromUserID, message.userName, message.toUserID, message.conversationChatter, message.nodeId,message.content, @(message.timestamp), @(message.messageBodyType), message.remoteUrl, @(message.duration), message.videoThumbnailPath, message.localPath, @(message.fileSize), @(message.isRead)];
                if (!result)
                {
                    isRollBack = YES;
                    *stop = YES;
                }
            }];
        }
        @catch (NSException *exception) {
            [_database rollback];
            failure(@"插入数据失败");
        }
        @finally {
            if (isRollBack)
            {
                [_database rollback];
                DLog(@"insert to database failure content");
                failure(@"插入数据失败");
            }
            else
            {
                [_database commit];
                success();
            }
        }
    }];
}

- (void)deleteIChatMessageWithMsgID:(NSString *)msgID success:(void (^)())success
{
    [_dataBaseQueue inDatabase:^(FMDatabase *db) {
        NSString* sql = [NSString stringWithFormat:@"delete from %@ where messageID = ?", DB_TABLE_ICHAT_MESSAGE];
        BOOL result = [_database executeUpdate:sql,msgID];
        dispatch_async(dispatch_get_main_queue(), ^{
            success(result);
        });
    }];
}
- (void)deleteIchatMessageWithMsgs:(NSArray *)msgs success:(void (^)())success{
    for (JYBIChatMessage * msg in msgs){
        [self deleteIChatMessageWithMsgID:msg.messageID success:^{}];
    }
}

- (void)updateIChatMessageWithIChatMessage:(JYBIChatMessage *)message success:(void (^)())success
{
    [_dataBaseQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"update %@ set videoThumbnailPath = ?, localPath = ? , isRead = ? WHERE messageID = ?", DB_TABLE_ICHAT_MESSAGE];
        BOOL result = [_database executeUpdate:sql, message.videoThumbnailPath, message.localPath, @(message.isRead), message.messageID];
        dispatch_async(dispatch_get_main_queue(), ^{
            success(result);
        });
    }];
}

- (NSArray *)getIChatMessagesWithConversationChatter:(NSString *)conversationChatter page:(NSInteger)page count:(NSInteger)count success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    __block NSMutableArray* array = [[NSMutableArray alloc] init];
    [_dataBaseQueue inDatabase:^(FMDatabase *db) {
        
        if ([_database tableExists:DB_TABLE_ICHAT_MESSAGE])
        {
            [_database setShouldCacheStatements:YES];
            
            NSString* sqlString = [NSString stringWithFormat:@"select * from %@ where conversationChatter = ? order by messageID DESC limit ?,?", DB_TABLE_ICHAT_MESSAGE];
            FMResultSet* result = [_database executeQuery:sqlString, conversationChatter, @((page-1) * count) , @(count)];
            while ([result next])
            {
                JYBIChatMessage* message = [self messageFromResult:result];
                [array addObject:message];
            }
            NSEnumerator *enumerator = [array reverseObjectEnumerator];
            id obj;
            NSMutableArray *arr = [NSMutableArray array];
            while ((obj = [enumerator nextObject]) != nil) {
                [arr addObject:obj];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                success(arr);
            });
        }
    }];
    return array;
}

- (JYBIChatMessage *)getLastIChatMessageWithMessageId:(NSString *)messageId
{
    __block JYBIChatMessage *message = nil;
    [_dataBaseQueue inDatabase:^(FMDatabase *db) {
        if ([_database tableExists:DB_TABLE_ICHAT_MESSAGE]) {
            [_database setShouldCacheStatements:YES];
            NSString *sql = [NSString stringWithFormat:@"select * from %@ where messageID = ?", DB_TABLE_ICHAT_MESSAGE];
            FMResultSet *result = [_database executeQuery:sql, messageId];
            while ([result next]) {
                message = [self messageFromResult:result];
            }
        }
    }];
    return message;
}

#pragma mark - *****最近会话*****
- (BOOL)insertConversations:(NSArray *)conversations
{
    __block BOOL ret = NO;
    [_dataBaseQueue inDatabase:^(FMDatabase *db) {
        [_database beginTransaction];
        __block BOOL isRollBack = NO;
        @try {
            
            [conversations enumerateObjectsUsingBlock:^(JYBConversation *conversation, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString *sql = [NSString stringWithFormat:@"insert or replace into %@ values (?,?,?,?,?,?,?,?);", DB_TABLE_CONVERSATION];
                BOOL result = [_database executeUpdate:sql, conversation.chatter, @(conversation.conversationType), conversation.avatar, conversation.name, conversation.lastMsgId, conversation.lastMsg, @(conversation.unreadCount), @(conversation.timestamp)];
                if (!result) {
                    isRollBack = YES;
                    *stop = YES;
                }
            }];
        }
        @catch (NSException *exception) {
            [_database rollback];
            DLog(@"插入数据失败");
            ret = NO;
        }
        @finally {
            if (isRollBack)
            {
                [_database rollback];
                DLog(@"插入数据失败");
                ret = NO;
            }
            else
            {
                [_database commit];
                ret = YES;
            }
        }
    }];
    return ret;
}

- (BOOL)deleteConversationWithChatter:(NSString *)chatter
{
    __block BOOL ret = NO;
    [_dataBaseQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"delete from %@ where chatter = ?", DB_TABLE_CONVERSATION];
        ret = [_database executeUpdate:sql, chatter];
    }];
    return ret;
}

- (BOOL)updateConversation:(JYBConversation *)conversation
{
    __block BOOL ret = NO;
    [_dataBaseQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"update %@ set chatter = ?, conversationType = ? , avatar = ?, name = ?, lastMsgId = ?, lastMsg = ?, unreadCount = ?, timestamp = ? WHERE chatter = ?", DB_TABLE_CONVERSATION];
        ret = [_database executeUpdate:sql, conversation.chatter, @(conversation.conversationType), conversation.avatar, conversation.name, conversation.lastMsgId, conversation.lastMsg, @(conversation.unreadCount), @(conversation.timestamp), conversation.chatter];
    }];
    return ret;
}

- (NSArray <JYBConversation *>*)getAllConversations
{
    __block NSMutableArray *conversations = [NSMutableArray array];
    [_dataBaseQueue inDatabase:^(FMDatabase *db) {
        if ([_database tableExists:DB_TABLE_CONVERSATION]) {
            [_database setShouldCacheStatements:YES];
            NSString *sql = [NSString stringWithFormat:@"select * from %@ order by timestamp DESC", DB_TABLE_CONVERSATION];
            FMResultSet *rset = [_database executeQuery:sql];
            while ([rset next]) {
                JYBConversation *conversation = [self conversationFromResult:rset];
                [conversations addObject:conversation];
            }
        }
    }];
    return conversations;
}

- (NSArray <JYBConversation *>*)getAllConversationsWithType:(JYBConversationType)conversationType
{
    __block NSMutableArray *conversations = [NSMutableArray array];
    [_dataBaseQueue inDatabase:^(FMDatabase *db) {
        if ([_database tableExists:DB_TABLE_CONVERSATION]) {
            [_database setShouldCacheStatements:YES];
            NSString *sql = [NSString stringWithFormat:@"select * from %@ where conversationType = ? order by timestamp DESC", DB_TABLE_CONVERSATION];
            FMResultSet *rset = [_database executeQuery:sql, @(conversationType)];
            while ([rset next]) {
                JYBConversation *conversation = [self conversationFromResult:rset];
                [conversations addObject:conversation];
            }
        }
    }];
    return conversations;
}

#pragma mark - ***** 群组 *****
- (BOOL)insertGroup:(NSArray <JYBSyncGroupModel *>*)groups
{
    __block BOOL ret = NO;
    [_dataBaseQueue inDatabase:^(FMDatabase *db) {
        [_database beginTransaction];
        __block BOOL isRollBack = NO;
        @try {
            
            [groups enumerateObjectsUsingBlock:^(JYBSyncGroupModel *group, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString *sql = [NSString stringWithFormat:@"insert or replace into %@ values (?,?,?,?,?,?,?,?);", DB_TABLE_GROUP];
                BOOL result = [_database executeUpdate:sql, group.userId, group.userName, group.sid, group.enterpriseCode, @(group.version), group.createDate, group.name, [NSString objToJson:group.userIds]];
                if (!result) {
                    isRollBack = YES;
                    *stop = YES;
                }
            }];
        }
        @catch (NSException *exception) {
            [_database rollback];
            DLog(@"插入数据失败");
            ret = NO;
        }
        @finally {
            if (isRollBack)
            {
                [_database rollback];
                DLog(@"插入数据失败");
                ret = NO;
            }
            else
            {
                [_database commit];
                ret = YES;
            }
        }
    }];
    return ret;
}

- (BOOL)deleteGroupWithSid:(NSString *)sid
{
    __block BOOL ret = NO;
    [_dataBaseQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"delete from %@ where sid = ?", DB_TABLE_GROUP];
        ret = [_database executeUpdate:sql, sid];
    }];
    return ret;
}

- (BOOL)updateGroup:(JYBSyncGroupModel *)group
{
    __block BOOL ret = NO;
    [_dataBaseQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"update %@ set userId = ?, userName = ? , sid = ?, enterpriseCode = ?, version = ?, createDate = ?, name = ?, userIds = ? WHERE sid = ?", DB_TABLE_GROUP];
        ret = [_database executeUpdate:sql, group.userId, group.userName, group.sid, group.enterpriseCode, @(group.version), group.createDate, group.name, group.sid, [NSString objToJson:group.userIds]];
    }];
    return ret;
}

- (NSArray<JYBSyncGroupModel *> *)getAllGroups
{
    __block NSMutableArray *groups = [NSMutableArray array];
    [_dataBaseQueue inDatabase:^(FMDatabase *db) {
        if ([_database tableExists:DB_TABLE_GROUP]) {
            [_database setShouldCacheStatements:YES];
            NSString *sql = [NSString stringWithFormat:@"select * from %@", DB_TABLE_GROUP];
            FMResultSet *rset = [_database executeQuery:sql];
            while ([rset next]) {
                JYBSyncGroupModel *group = [self groupFromREsult:rset];
                [groups addObject:group];
            }
        }
    }];
    return groups;
}

- (JYBSyncGroupModel *)getGroupWithSid:(NSString *)sid
{
    __block JYBSyncGroupModel *group = nil;
    [_dataBaseQueue inDatabase:^(FMDatabase *db) {
        if ([_database tableExists:DB_TABLE_GROUP]) {
            [_database setShouldCacheStatements:YES];
            NSString *sql = [NSString stringWithFormat:@"select * from %@ where sid = ?", DB_TABLE_GROUP];
            FMResultSet *rset = [_database executeQuery:sql, sid];
            while ([rset next]) {
                group = [self groupFromREsult:rset];
            }
        }
    }];
    return group;
}

#pragma mark - private
- (JYBIChatMessage *)messageFromResult:(FMResultSet *)result
{
    @autoreleasepool {
        JYBIChatMessage *messageEntity = [[JYBIChatMessage alloc] init];
        messageEntity.commandID = [result intForColumn:@"commandID"];
        messageEntity.messageID = [result stringForColumn:@"messageID"];
        messageEntity.fromUserID = [result stringForColumn:@"fromUserId"];
        messageEntity.userName = [result stringForColumn:@"userName"];
        messageEntity.toUserID = [result stringForColumn:@"toUserID"];
        messageEntity.conversationChatter = [result stringForColumn:@"conversationChatter"];
        messageEntity.nodeId = [result stringForColumn:@"nodeId"];
        messageEntity.content = [result stringForColumn:@"content"];
        messageEntity.timestamp = [result doubleForColumn:@"timestamp"];
        messageEntity.messageBodyType = [result intForColumn:@"messageBodyType"];
        messageEntity.remoteUrl = [result stringForColumn:@"remoteUrl"];
        messageEntity.duration = [result intForColumn:@"duration"];
        messageEntity.videoThumbnailPath = [result stringForColumn:@"videoThumbnailPath"];
        messageEntity.localPath = [result stringForColumn:@"localPath"];
        messageEntity.fileSize = [result intForColumn:@"fileSize"];
        messageEntity.isRead = [result boolForColumn:@"isRead"];
        return messageEntity;
    }
}

- (JYBConversation *)conversationFromResult:(FMResultSet *)result
{
    @autoreleasepool {
        JYBConversation *conversation = [[JYBConversation alloc] init];
        conversation.chatter = [result stringForColumn:@"chatter"];
        conversation.conversationType = [result intForColumn:@"conversationType"];
        conversation.avatar = [result stringForColumn:@"avatar"];
        conversation.name = [result stringForColumn:@"name"];
        conversation.lastMsgId = [result stringForColumn:@"lastMsgId"];
        conversation.lastMsg = [result stringForColumn:@"lastMsg"];
        conversation.unreadCount = [result intForColumn:@"unreadCount"];
        conversation.timestamp = [result doubleForColumn:@"timestamp"];
        return conversation;
    }
}

- (JYBSyncGroupModel *)groupFromREsult:(FMResultSet *)result
{
    @autoreleasepool {
        JYBSyncGroupModel *group = [[JYBSyncGroupModel alloc] init];
        group.userId = [result stringForColumn:@"userId"];
        group.userName = [result stringForColumn:@"userName"];
        group.sid = [result stringForColumn:@"sid"];
        group.enterpriseCode = [result stringForColumn:@"enterpriseCode"];
        group.version = [result intForColumn:@"version"];
        group.createDate = [result stringForColumn:@"createDate"];
        group.name = [result stringForColumn:@"name"];
        group.userIds = [NSString arrayWithJsonString:[result stringForColumn:@"userIds"]];
        return group;
    }
}

@end
