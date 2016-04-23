//
//  JYBConversation.h
//  JianYunBao
//
//  Created by 冰点 on 16/3/12.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYBIChatMessage.h"

@class JYBFriendItem;

@interface JYBConversation : NSObject<NSCopying>

- (instancetype)initWithChatter:(NSString *)chatter conversationtype:(JYBConversationType)type;

@property (nonatomic, copy) NSString *chatter;//会话者
@property (nonatomic, assign) JYBConversationType conversationType;

@property (nonatomic, readonly) JYBFriendItem* user;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *lastMsgId;
@property (nonatomic, copy) NSString *lastMsg;
@property (nonatomic, readonly) JYBIChatMessage *message;

@property (nonatomic, assign) NSInteger unreadCount;

@property (nonatomic, assign) NSTimeInterval timestamp;

- (id)copyWithZone:(NSZone *)zone;
@end
