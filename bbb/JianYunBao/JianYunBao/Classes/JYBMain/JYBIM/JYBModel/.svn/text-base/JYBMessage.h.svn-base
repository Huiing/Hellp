//
//  JYBMessage.h
//  JianYunBao
//  消息对象
//  Created by 冰点 on 16/3/10.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYBMessageBuilder.h"
#import "JYBIMMessage.h"

@interface JYBMessage : NSObject
{
    @private
    JYBIMMessage *message_;
}

- (instancetype)initWithMessage:(JYBIMMessage *)message;

@property (nonatomic, readonly) JYBIMMessage *message;

//包含企业白板、群聊、单聊、工单评论/结果、质量评论/结果、安全评论/结果、日常评论/结果的处理
- (JYBIChatMessage *)createIChatMessage:(JYBMessageBuilder *)builder;

//组-群、工单、质量检测单、安全检测单
//创建、更新、删除、继续、暂停、完成、取消、合格、不合格
- (JYBIChatMessage *)createGroup:(JYBMessageBuilder *)builder;

//日常巡查单
@end
