//
//  JYBConversation.m
//  JianYunBao
//
//  Created by 冰点 on 16/3/12.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBConversation.h"
#import "JYBFriendItem.h"
#import "JYBFriendItemTool.h"
#import "BDIMDatabaseUtil.h"

@interface JYBConversation ()

@property (nonatomic, strong) JYBFriendItem *user;
@property (nonatomic, strong) JYBIChatMessage *message;
@end

@implementation JYBConversation

- (instancetype)initWithChatter:(NSString *)chatter conversationtype :(JYBConversationType)type
{
    if (self = [super init]) {
        self.chatter = chatter;
        self.conversationType = type;
        _user = [self getUserWithChatter:chatter];
        self.avatar = [_user.iconPaths length] ? _user.iconPaths : @"";
        self.name = [_user.name length] ? _user.name : @"";
        self.lastMsgId = @"";
        self.lastMsg = @"";
        self.unreadCount = 0;
        self.timestamp = [[NSDate date] timeIntervalSince1970] * 1000;
    }
    return self;
}

- (JYBFriendItem *)getUserWithChatter:(NSString *)chatter
{
    JYBFriendItem *item = [[JYBFriendItemTool friends:chatter] firstObject];
    return item;
}

- (JYBIChatMessage *)message
{
    return [[BDIMDatabaseUtil sharedInstance] getLastIChatMessageWithMessageId:self.lastMsgId];
}

- (id)copyWithZone:(NSZone *)zone
{
    JYBConversation *conversationCopy = [[self class] allocWithZone:zone];
    conversationCopy.chatter = self.chatter;
    conversationCopy.conversationType = self.conversationType;
    conversationCopy.user = [_user copy];
    conversationCopy.avatar = self.avatar;
    conversationCopy.name = self.name;
    conversationCopy.lastMsg = self.lastMsg;
    conversationCopy.lastMsgId = self.lastMsgId;
    conversationCopy.message = [_message copy];
    conversationCopy.unreadCount = self.unreadCount;
    conversationCopy.timestamp = self.timestamp;
    return conversationCopy;
}
@end
