//
//  JYBFriendItemTool.h
//  JianYunBao
//
//  Created by 宋亚伟 on 16/3/3.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JYBFriendItem;

@interface JYBFriendItemTool : NSObject

+ (BOOL)addFriend:(JYBFriendItem *)friendItem;

+ (BOOL)addFriends:(NSArray *)friends;

+ (BOOL)updateFriend:(JYBFriendItem *)friendItem;

+ (NSArray *)friends;

+ (NSArray *)friends:(NSString *)friendId;

@end
