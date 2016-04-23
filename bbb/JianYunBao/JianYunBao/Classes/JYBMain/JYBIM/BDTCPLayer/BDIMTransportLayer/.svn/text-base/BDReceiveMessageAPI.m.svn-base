//
//  BDReceiveMessageAPI.m
//  JianYunBao
//
//  Created by 冰点 on 16/3/10.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "BDReceiveMessageAPI.h"

@implementation BDReceiveMessageAPI

- (instancetype)initWithMessageCommandID:(int)commandID
{
    if (self = [super initWithMessageCommandID:commandID]) {
    }
    return self;
}

- (int)responseCommandID
{
    return _commandID;
}

- (BDUnreqeustAPIAnalysis)unrequestAnalysis
{
    BDUnreqeustAPIAnalysis analysis = (id)^(NSData *data, int commandID) {
        JYBIMMessage *im_message = [JYBIMMessage parseFromData:data commandID:commandID];
        //将解析后的数据封装成消息模型
        JYBMessageBuilder *builder = [[JYBMessageBuilder alloc] init];
        JYBMessage *message = [[JYBMessage alloc] initWithMessage:im_message];
        JYBIChatMessage *iChatMessage = [message createIChatMessage:builder];
        return iChatMessage;
    };
    return analysis;
}
@end
