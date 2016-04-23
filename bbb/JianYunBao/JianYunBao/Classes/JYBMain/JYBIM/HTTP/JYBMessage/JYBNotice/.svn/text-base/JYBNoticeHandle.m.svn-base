//
//  JYBNoticeManager.m
//  BDSocketIM
//
//  Created by 冰点 on 16/2/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBNoticeHandle.h"
#import "JYBIMSendNoticeMessageApi.h"

@implementation JYBNoticeHandle
{
    JYBIMSendNoticeMessageApi *api;
}

- (instancetype)initSendNoticeWithEnterpriseCode:(NSString *)enterpriseCode userid:(NSString *)userId name:(NSString *)name newId:(NSString *)newId
{
    self = [super initSendNoticeWithEnterpriseCode:enterpriseCode userid:userId name:name newId:newId];
    if (self) {
        api = [[JYBIMSendNoticeMessageApi alloc] initNoticeApiWithEnterpriseCode:enterpriseCode userName:name userid:userId newsId:newId];
    }
    return self;
}

- (void)sendText:(NSString *)text success:(void (^)(id))success failure:(void (^)(NSString *))failure
{
    if (!text) {
        return;
    }
    api.type = JYBIMMessageBodyTypeText;
    api.msg = text;
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        DLog(@"%@", request.responseJSONObject);
        if ([request.responseJSONObject[@"result"] integerValue] == 1) {
            JYBIChatMessage *entity = [[JYBIChatMessage alloc] init];
            entity.commandID = BD_TCP_PROTOCOL_CODE_NOTICE_COMMENT_TEXT;
            entity.messageID = request.responseJSONObject[@"id"];
            entity.fromUserID = self.sendUserId;
            entity.userName = self.sendUserName;
            entity.conversationChatter = self.nnewId;
            entity.toUserID = self.nnewId;
            entity.content = text;
            entity.messageBodyType = JYBIMMessageBodyTypeText;
            entity.timestamp = (NSTimeInterval)[NSDate getTimestamp] * 1000;
            [[BDIMDatabaseUtil sharedInstance] insertIChatMessages:@[entity] success:^{
                success(entity);
            } failure:^(NSString *errorDescripe) {
                failure(errorDescripe);
            }];
        } else {
            failure(@"文本消息发送失败！");
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        DLog(@"%@",request.requestOperation.error);
        failure(@"网络异常！");
    }];
}

@end
