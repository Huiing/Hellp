//
//  JYBMessageModule.m
//  JianYunBao
//
//  Created by 冰点 on 16/3/1.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBMessageModule.h"
#import "BDIMDatabaseUtil.h"
#import "BDReceiveMessageAPI.h"
#import "BDTCPProtocolHeader.h"

@implementation JYBMessageModule

+ (instancetype)sharedInstance {
    static JYBMessageModule * _someCls = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _someCls = [[JYBMessageModule alloc] init];
    });
    return _someCls;
}

- (instancetype)init
{
    if (self = [super init]) {
        //注册API
        [self registerReceiveIChatMessageAPIWithCommandIDs:[self iChatWhiteboardMessageCommandIDs]];
        [self registerReceiveIChatMessageAPIWithCommandIDs:[self iChatGroupChatMessageCommandIDs]];
        [self registerReceiveIChatMessageAPIWithCommandIDs:[self iChatSingleChatMessageCommandIDs]];
        //以下待测
        [self registerReceiveIChatMessageAPIWithCommandIDs:[self iChatBillCommentCommandIDs]];
        [self registerReceiveIChatMessageAPIWithCommandIDs:[self iChatBillResultCommandIDs]];
        [self registerReceiveIChatMessageAPIWithCommandIDs:[self iChatQualityCheckCommentCommandIDs]];
        [self registerReceiveIChatMessageAPIWithCommandIDs:[self iChatQualityCheckResultCommandIDs]];
        [self registerReceiveIChatMessageAPIWithCommandIDs:[self iChatSafetyCheckCommentCommandIDs]];
        [self registerReceiveIChatMessageAPIWithCommandIDs:[self iChatSafetyCheckResultCommandIDs]];
        [self registerReceiveIChatMessageAPIWithCommandIDs:[self iChatDailuInspectResultCommandIDs]];
    }
    return self;
}

///企业白板消息指令集
- (NSArray *)iChatWhiteboardMessageCommandIDs
{
    //依次：文本、音频、图片、视频、文件（顺序勿动）
    return @[@(BD_TCP_PROTOCOL_CODE_WHITEBOARD_TEXT_MESSAGE),
             @(BD_TCP_PROTOCOL_CODE_WHITEBOARD_AUDIO_MESSAGE),
             @(BD_TCP_PROTOCOL_CODE_WHITEBOARD_IMAGE_MESSAGE),
             @(BD_TCP_PROTOCOL_CODE_WHITEBOARD_VIDEO_MESSAGE),
             @(BD_TCP_PROTOCOL_CODE_WHITEBOARD_FILE_MESSAGE)];
}

///群组消息指令集
- (NSArray *)iChatGroupChatMessageCommandIDs
{
    //依次：文本、音频、图片、视频、文件（顺序勿动）
    return @[@(BD_TCP_PROTOCOL_CODE_CHATGROUP_TEXT_MESSAGE),
             @(BD_TCP_PROTOCOL_CODE_CHATGROUP_AUDIO_MESSAGE),
             @(BD_TCP_PROTOCOL_CODE_CHATGROUP_IMAGE_MESSAGE),
             @(BD_TCP_PROTOCOL_CODE_CHATGROUP_VIDEO_MESSAGE),
             @(BD_TCP_PROTOCOL_CODE_CHATGROUP_FILE_MESSAGE)];
}

///单聊消息指令集
- (NSArray *)iChatSingleChatMessageCommandIDs
{
    //依次：文本、音频、图片、视频、文件（顺序勿动）
    return @[@(BD_TCP_PROTOCOL_CODE_CHATSINGLE_TEXT_MESSAGE),
             @(BD_TCP_PROTOCOL_CODE_CHATSINGLE_AUDIO_MESSAGE),
             @(BD_TCP_PROTOCOL_CODE_CHATSINGLE_IMAGE_MESSAGE),
             @(BD_TCP_PROTOCOL_CODE_CHATSINGLE_VIDEO_MESSAGE),
             @(BD_TCP_PROTOCOL_CODE_CHATSINGLE_FILE_MESSAGE)];
}

///工单评论消息指令集
- (NSArray *)iChatBillCommentCommandIDs
{
    return @[@(BD_TCP_PROTOCOL_CODE_BILL_COMMENT_TEXT_MESSAGE),
             @(BD_TCP_PROTOCOL_CODE_BILL_COMMENT_AUDIO_MESSAGE),
             @(BD_TCP_PROTOCOL_CODE_BILL_COMMENT_IMAGE_MESSAGE),
             @(BD_TCP_PROTOCOL_CODE_BILL_COMMENT_VIDEO_MESSAGE),
             @(BD_TCP_PROTOCOL_CODE_BILL_COMMENT_FILE_MESSAGE)];
}

///工单节点消息指令集
- (NSArray *)iChatBillResultCommandIDs
{
    return @[@(BD_TCP_PROTOCOL_CODE_BILL_RESULT_TEXT_MESSAGE),
             @(BD_TCP_PROTOCOL_CODE_BILL_RESULT_AUDIO_MESSAGE),
             @(BD_TCP_PROTOCOL_CODE_BILL_RESULT_IMAGE_MESSAGE),
             @(BD_TCP_PROTOCOL_CODE_BILL_RESULT_VIDEO_MESSAGE),
             @(BD_TCP_PROTOCOL_CODE_BILL_RESULT_FILE_MESSAGE)];
}

///质量检查单评论消息指令集
- (NSArray *)iChatQualityCheckCommentCommandIDs
{
    return @[@(BD_TCP_PROTOCOL_CODE_QUALITYCHECK_COMMENT_TEXT_MESSAGE),
             @(BD_TCP_PROTOCOL_CODE_QUALITYCHECK_COMMENT_AUDIO_MESSAGE),
             @(BD_TCP_PROTOCOL_CODE_QUALITYCHECK_COMMENT_IMAGE_MESSAGE),
             @(BD_TCP_PROTOCOL_CODE_QUALITYCHECK_COMMENT_VIDEO_MESSAGE),
             @(BD_TCP_PROTOCOL_CODE_QUALITYCHECK_COMMENT_FILE_MESSAGE)];
}

///质量检查单执行结果消息指令集
- (NSArray *)iChatQualityCheckResultCommandIDs
{
    return @[@(BD_TCP_PROTOCOL_CODE_QUALITYCHECK_RESULT_TEXT_MESSAGE),
             @(BD_TCP_PROTOCOL_CODE_QUALITYCHECK_RESULT_AUDIO_MESSAGE),
             @(BD_TCP_PROTOCOL_CODE_QUALITYCHECK_RESULT_IMAGE_MESSAGE),
             @(BD_TCP_PROTOCOL_CODE_QUALITYCHECK_RESULT_VIDEO_MESSAGE),
             @(BD_TCP_PROTOCOL_CODE_QUALITYCHECK_RESULT_FILE_MESSAGE)];
}

///安全检查单评论消息指令集
- (NSArray *)iChatSafetyCheckCommentCommandIDs
{
    return @[@(BD_TCP_PROTOCOL_CODE_SAFETYCHECK_COMMENT_TEXT_MESSAGE),
             @(BD_TCP_PROTOCOL_CODE_SAFETYCHECK_COMMENT_AUDIO_MESSAGE),
             @(BD_TCP_PROTOCOL_CODE_SAFETYCHECK_COMMENT_IMAGE_MESSAGE),
             @(BD_TCP_PROTOCOL_CODE_SAFETYCHECK_COMMENT_VIDEO_MESSAGE),
             @(BD_TCP_PROTOCOL_CODE_SAFETYCHECK_COMMENT_FILE_MESSAGE)];
}

///安全检查单执行结果消息指令集
- (NSArray *)iChatSafetyCheckResultCommandIDs
{
    return @[@(BD_TCP_PROTOCOL_CODE_SAFETYCHECK_RESULT_TEXT_MESSAGE),
             @(BD_TCP_PROTOCOL_CODE_SAFETYCHECK_RESULT_AUDIO_MESSAGE),
             @(BD_TCP_PROTOCOL_CODE_SAFETYCHECK_RESULT_IMAGE_MESSAGE),
             @(BD_TCP_PROTOCOL_CODE_SAFETYCHECK_RESULT_VIDEO_MESSAGE),
             @(BD_TCP_PROTOCOL_CODE_SAFETYCHECK_RESULT_FILE_MESSAGE)];
}

///日常巡查执行结果消息指令集
- (NSArray *)iChatDailuInspectResultCommandIDs
{
    return @[@(BD_TCP_PROTOCOL_CODE_DAILYINSPECT_RESULT_TEXT_MESSAGE),
                    @(BD_TCP_PROTOCOL_CODE_DAILYINSPECT_RESULT_AUDIO_MESSAGE),
                    @(BD_TCP_PROTOCOL_CODE_DAILYINSPECT_RESULT_IMAGE_MESSAGE),
                    @(BD_TCP_PROTOCOL_CODE_DAILYINSPECT_RESULT_VIDEO_MESSAGE),
                    @(BD_TCP_PROTOCOL_CODE_DAILYINSPECT_RESULT_FILE_MESSAGE)];
}


///注册监听聊天消息
- (void)registerReceiveIChatMessageAPIWithCommandIDs:(NSArray *)cmds
{
    if (![cmds count]) return;
    
    __weak __typeof(self)weakSelf = self;
    //TODO: 文本消息
    BDReceiveMessageAPI *textMessage = [[BDReceiveMessageAPI alloc] initWithMessageCommandID:[cmds[0] intValue]];
    [textMessage registerAPIInAPIScheduleReceiveData:^(id object, NSError *error) {
        if (!error) {
            [weakSelf addIChatMessageToDB:object];
        }
    }];
    
    //TODO: 音频消息
    BDReceiveMessageAPI *audioMessage = [[BDReceiveMessageAPI alloc] initWithMessageCommandID:[cmds[1] intValue]];
    [audioMessage registerAPIInAPIScheduleReceiveData:^(id object, NSError *error) {
        if (!error) {
            [weakSelf addIChatMessageToDB:object];
        }
    }];
    
    //TODO: 图片消息
    BDReceiveMessageAPI *imageMessage = [[BDReceiveMessageAPI alloc] initWithMessageCommandID:[cmds[2] intValue]];
    [imageMessage registerAPIInAPIScheduleReceiveData:^(id object, NSError *error) {
        if (!error) {
            [weakSelf addIChatMessageToDB:object];
        }
    }];
    
    //TODO: 视频消息
    BDReceiveMessageAPI *videoMessage = [[BDReceiveMessageAPI alloc] initWithMessageCommandID:[cmds[3] intValue]];
    [videoMessage registerAPIInAPIScheduleReceiveData:^(id object, NSError *error) {
        if (!error) {
            [self addIChatMessageToDB:object];
        }
    }];
    
    //TODO: 文件消息
    BDReceiveMessageAPI *fileMessage = [[BDReceiveMessageAPI alloc] initWithMessageCommandID:[cmds[4] intValue]];
    [fileMessage registerAPIInAPIScheduleReceiveData:^(id object, NSError *error) {
        if (!error) {
            [self addIChatMessageToDB:object];
        }
    }];
    
}

- (void)addIChatMessageToDB:(id)object
{
    //处理数据插入DB
    [[BDIMDatabaseUtil sharedInstance] insertIChatMessages:@[object] success:^{} failure:^(NSString *errorDescripe) {}];
    [BDNotification postNotification:JYBNotificationReceiveMessage userInfo:nil object:object];
}



@end
