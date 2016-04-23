//
//  JYBSyncGroupModel.h
//  JianYunBao
//
//  Created by 冰点 on 16/3/15.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYBConversation.h"

@interface JYBSyncGroupModel : NSObject

///创建用户ID
@property (nonatomic, copy) NSString *userId;

///创建用户姓名
@property (nonatomic, copy) NSString *userName;

///工单主键ID - - - 群/专题id
@property (nonatomic, copy) NSString *sid;

@property (nonatomic, copy) NSString *enterpriseCode;

///聊天群组版本号
@property (nonatomic, assign) NSInteger version;

@property (nonatomic, copy) NSString *createDate;

///群名称
@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) JYBConversation *conversation;

@property (nonatomic, strong) NSArray *userIds;

@end
