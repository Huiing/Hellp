//
//  BDReceiveNotificationAPI.m
//  JianYunBao
//
//  Created by 冰点 on 16/3/14.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "BDReceiveNotificationAPI.h"

@implementation BDReceiveNotificationAPI

- (int)responseCommandID
{
    return _commandID;
}

- (BDUnreqeustAPIAnalysis)unrequestAnalysis
{
    BDUnreqeustAPIAnalysis analysis = (id)^(NSData *data, int commandID) {
        JYBIMMessage *message = [JYBIMMessage parseFromData:data commandID:commandID];
        //将解析后的数据封装成消息模型
        (void)message;
        JYBMessageBuilder *builder = [[JYBMessageBuilder alloc] init];
        JYBMessage *im_message = [[JYBMessage alloc] initWithMessage:message];
        JYBIChatMessage *iChatMessage = [im_message createGroup:builder];
        return iChatMessage;
    };
    return analysis;
}

@end
