//
//  JYBFriendItem.m
//  JianYunBao
//
//  Created by 宋亚伟 on 16/2/29.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBFriendItem.h"
#import "NSString+PinYin.h"

@implementation JYBFriendItem

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"friendId":@"id"};
}

- (id)copyWithZone:(NSZone *)zone
{
    JYBFriendItem *itemCopy = [[self class] allocWithZone:zone];
    itemCopy.sex = self.sex;
    itemCopy.iconPaths = self.iconPaths;
    itemCopy.userName = self.userName;
    itemCopy.friendId = self.friendId;
    itemCopy.isContact = self.isContact;
    itemCopy.phoneNum = self.phoneNum;
    itemCopy.company = self.company;
    itemCopy.email = self.email;
    itemCopy.department = self.department;
    itemCopy.name = self.name;
    itemCopy.OrderRank = self.OrderRank;
    return itemCopy;
}
@end
