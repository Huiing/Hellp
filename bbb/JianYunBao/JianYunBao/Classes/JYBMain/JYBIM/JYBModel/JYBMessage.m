//
//  JYBMessage.m
//  JianYunBao
//
//  Created by 冰点 on 16/3/10.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBMessage.h"
#import "JYBDownloadFileApi.h"
#import "NSString+BDPath.h"
#import "UIImage+BDVideoThumbnail.h"
#import "JYBFileDownloadHandler.h"

@interface JYBMessage ()

- (JYBIChatMessage *)createWhiteboardMessage:(JYBMessageBuilder *)builder;
- (JYBIChatMessage *)createSingleChatMessage:(JYBMessageBuilder *)builder;
- (JYBIChatMessage *)createGroupChatMessage:(JYBMessageBuilder *)builder;
- (JYBIChatMessage *)createBillCommentMessage:(JYBMessageBuilder *)builder;
- (JYBIChatMessage *)createBillResultMessage:(JYBMessageBuilder *)builder;
- (JYBIChatMessage *)createQualityCheckCommentMessage:(JYBMessageBuilder *)builder;
- (JYBIChatMessage *)createQualityCheckResultMessage:(JYBMessageBuilder *)builder;
- (JYBIChatMessage *)createSafetyCheckCommentMessage:(JYBMessageBuilder *)builder;
- (JYBIChatMessage *)createSafetyCheckResultMessage:(JYBMessageBuilder *)builder;
- (JYBIChatMessage *)createDailuInspectResultMessage:(JYBMessageBuilder *)builder;

@end

@implementation JYBMessage
@synthesize message = message_;

- (instancetype)initWithMessage:(JYBIMMessage *)message
{
    if (self = [super init]) {
        message_ = message;
    }
    return self;
}

- (JYBIChatMessage *)createIChatMessage:(JYBMessageBuilder *)builder
{
    //通过指令构建相关消息对象
    switch ([message_ commandID]) {
            //TODO: 企业白板
        case BD_TCP_PROTOCOL_CODE_WHITEBOARD_TEXT_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_WHITEBOARD_AUDIO_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_WHITEBOARD_IMAGE_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_WHITEBOARD_VIDEO_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_WHITEBOARD_FILE_MESSAGE:
            return [self createWhiteboardMessage:builder];
            break;
            
            //TODO: 群聊
        case BD_TCP_PROTOCOL_CODE_CHATGROUP_TEXT_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_CHATGROUP_AUDIO_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_CHATGROUP_IMAGE_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_CHATGROUP_VIDEO_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_CHATGROUP_FILE_MESSAGE:
            return [self createGroupChatMessage:builder];
            break;
            
            //TODO: 单聊
        case BD_TCP_PROTOCOL_CODE_CHATSINGLE_TEXT_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_CHATSINGLE_AUDIO_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_CHATSINGLE_IMAGE_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_CHATSINGLE_VIDEO_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_CHATSINGLE_FILE_MESSAGE:
            return [self createSingleChatMessage:builder];
            break;
            
            //TODO: 工单评论
        case BD_TCP_PROTOCOL_CODE_BILL_COMMENT_TEXT_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_BILL_COMMENT_AUDIO_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_BILL_COMMENT_IMAGE_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_BILL_COMMENT_VIDEO_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_BILL_COMMENT_FILE_MESSAGE:
            return [self createBillCommentMessage:builder];
            break;
            
            //TODO: 工单节点
        case BD_TCP_PROTOCOL_CODE_BILL_RESULT_TEXT_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_BILL_RESULT_AUDIO_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_BILL_RESULT_IMAGE_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_BILL_RESULT_VIDEO_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_BILL_RESULT_FILE_MESSAGE:
            return [self createBillResultMessage:builder];
            break;
            
            //TODO: 质量检查单评论
        case BD_TCP_PROTOCOL_CODE_QUALITYCHECK_COMMENT_TEXT_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_QUALITYCHECK_COMMENT_AUDIO_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_QUALITYCHECK_COMMENT_IMAGE_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_QUALITYCHECK_COMMENT_VIDEO_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_QUALITYCHECK_COMMENT_FILE_MESSAGE:
            return [self createQualityCheckCommentMessage:builder];
            break;
            
            //TODO: 质量检查单执行结果-节点
        case BD_TCP_PROTOCOL_CODE_QUALITYCHECK_RESULT_TEXT_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_QUALITYCHECK_RESULT_AUDIO_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_QUALITYCHECK_RESULT_IMAGE_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_QUALITYCHECK_RESULT_VIDEO_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_QUALITYCHECK_RESULT_FILE_MESSAGE:
            return [self createQualityCheckResultMessage:builder];
            break;
            
            //TODO: 安全检查单评论
        case BD_TCP_PROTOCOL_CODE_SAFETYCHECK_COMMENT_TEXT_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_SAFETYCHECK_COMMENT_AUDIO_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_SAFETYCHECK_COMMENT_IMAGE_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_SAFETYCHECK_COMMENT_VIDEO_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_SAFETYCHECK_COMMENT_FILE_MESSAGE:
            return [self createSafetyCheckCommentMessage:builder];
            break;
            
            //TODO: 安全检查单执行结果-节点
        case BD_TCP_PROTOCOL_CODE_SAFETYCHECK_RESULT_TEXT_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_SAFETYCHECK_RESULT_AUDIO_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_SAFETYCHECK_RESULT_IMAGE_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_SAFETYCHECK_RESULT_VIDEO_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_SAFETYCHECK_RESULT_FILE_MESSAGE:
            return [self createSafetyCheckResultMessage:builder];
            break;
            
            //TODO: 日常巡查
        case BD_TCP_PROTOCOL_CODE_DAILYINSPECT_RESULT_TEXT_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_DAILYINSPECT_RESULT_AUDIO_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_DAILYINSPECT_RESULT_IMAGE_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_DAILYINSPECT_RESULT_VIDEO_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_DAILYINSPECT_RESULT_FILE_MESSAGE:
            return [self createSafetyCheckResultMessage:builder];
            break;
        default:
            break;
    }
    return [builder chat_message];
}

- (JYBIChatMessage *)createGroup:(JYBMessageBuilder *)builder
{
    [[[builder buildNewMessagePattern]
      buildCommandID:message_.commandID]
     buildMessageGroupID:message_.groupID];
    
    switch ([message_ commandID]) {
            //群组
        case BD_TCP_PROTOCOL_CODE_CHATGROUP_CREATE:
            builder.chat_message.messageActionStatus = JYBMessageActionStatusGroupCreate;
            break;
        case BD_TCP_PROTOCOL_CODE_CHATGROUP_UPDATE:
            builder.chat_message.messageActionStatus = JYBMessageActionStatusGroupUpdate;
            break;
        case BD_TCP_PROTOCOL_CODE_CHATGROUP_DELETE:
            builder.chat_message.messageActionStatus = JYBMessageActionStatusGroupDelete;
            break;
           
            //工单
        case BD_TCP_PROTOCOL_CODE_BILL_CREATE:
            builder.chat_message.messageActionStatus = JYBMessageActionStatusBillCreate;
            break;
        case BD_TCP_PROTOCOL_CODE_BILL_UPDATE:
            builder.chat_message.messageActionStatus = JYBMessageActionStatusBillUpdate;
            break;
        case BD_TCP_PROTOCOL_CODE_BILL_DELETE:
            builder.chat_message.messageActionStatus = JYBMessageActionStatusBillDelete;
            break;
        case BD_TCP_PROTOCOL_CODE_BILL_STATUS_CONTINUE:
            builder.chat_message.messageActionStatus = JYBMessageActionStatusBillContinue;
            break;
        case BD_TCP_PROTOCOL_CODE_BILL_STATUS_PAUSE:
            builder.chat_message.messageActionStatus = JYBMessageActionStatusBillPause;
            break;
        case BD_TCP_PROTOCOL_CODE_BILL_STATUS_FINISH:
            builder.chat_message.messageActionStatus = JYBMessageActionStatusBillFinished;
            break;
        case BD_TCP_PROTOCOL_CODE_BILL_STATUS_CANCEL:
            builder.chat_message.messageActionStatus = JYBMessageActionStatusBillCancel;
            break;
            
            //质量
        case BD_TCP_PROTOCOL_CODE_QUALITYCHECK_CREATE:
            builder.chat_message.messageActionStatus = JYBMessageActionStatusQualityCreate;
            break;
        case BD_TCP_PROTOCOL_CODE_QUALITYCHECK_UPDATE:
            builder.chat_message.messageActionStatus = JYBMessageActionStatusQualityUpdate;
            break;
        case BD_TCP_PROTOCOL_CODE_QUALITYCHECK_DELETE:
            builder.chat_message.messageActionStatus = JYBMessageActionStatusQualityDelete;
            break;
        case BD_TCP_PROTOCOL_CODE_QUALITYCHECK_STATUS_CONTINUE:
            builder.chat_message.messageActionStatus = JYBMessageActionStatusQualityContinue;
            break;
        case BD_TCP_PROTOCOL_CODE_QUALITYCHECK_STATUS_PAUSE:
            builder.chat_message.messageActionStatus = JYBMessageActionStatusQualityPause;
            break;
        case BD_TCP_PROTOCOL_CODE_QUALITYCHECK_STATUS_FINISH:
            builder.chat_message.messageActionStatus = JYBMessageActionStatusQualityFinished;
            break;
        case BD_TCP_PROTOCOL_CODE_QUALITYCHECK_STATUS_CANCEL:
            builder.chat_message.messageActionStatus = JYBMessageActionStatusQualityCancel;
            break;
        case BD_TCP_PROTOCOL_CODE_QUALITYCHECK_STATUS_QUALIFY:
            builder.chat_message.messageActionStatus = JYBMessageActionStatusQualityQualify;
            break;
        case BD_TCP_PROTOCOL_CODE_QUALITYCHECK_STATUS_UNQUALIFY:
            builder.chat_message.messageActionStatus = JYBMessageActionStatusQualityUnQualify;
            break;
           
            //安全
        case BD_TCP_PROTOCOL_CODE_SAFETYCHECK_CREATE:
            builder.chat_message.messageActionStatus = JYBMessageActionStatusSafetyCreate;
            break;
        case BD_TCP_PROTOCOL_CODE_SAFETYCHECK_UPDATE:
            builder.chat_message.messageActionStatus = JYBMessageActionStatusSafetyUpdate;
            break;
        case BD_TCP_PROTOCOL_CODE_SAFETYCHECK_DELETE:
            builder.chat_message.messageActionStatus = JYBMessageActionStatusSafetyDelete;
            break;
        case BD_TCP_PROTOCOL_CODE_SAFETYCHECK_STATUS_CONTINUE:
            builder.chat_message.messageActionStatus = JYBMessageActionStatusSafetyContinue;
            break;
        case BD_TCP_PROTOCOL_CODE_SAFETYCHECK_STATUS_PAUSE:
            builder.chat_message.messageActionStatus = JYBMessageActionStatusSafetyPause;
            break;
        case BD_TCP_PROTOCOL_CODE_SAFETYCHECK_STATUS_FINISH:
            builder.chat_message.messageActionStatus = JYBMessageActionStatusSafetyFinished;
            break;
        case BD_TCP_PROTOCOL_CODE_SAFETYCHECK_STATUS_CANCEL:
            builder.chat_message.messageActionStatus = JYBMessageActionStatusSafetyCancel;
            break;
        case BD_TCP_PROTOCOL_CODE_SAFETYCHECK_STATUS_QUALIFY:
            builder.chat_message.messageActionStatus = JYBMessageActionStatusSafetyQualify;
            break;
        case BD_TCP_PROTOCOL_CODE_SAFETYCHECK_STATUS_UNQUALIFY:
            builder.chat_message.messageActionStatus = JYBMessageActionStatusSafetyUnQualify;
            break;
            
        default:
            break;
    }
    
    
    return [builder chat_message];
}

#pragma mark - Private Method
///企业白板
- (JYBIChatMessage *)createWhiteboardMessage:(JYBMessageBuilder *)builder
{
    [[[[[builder buildNewMessagePattern]
        buildCommandID:message_.commandID]
       buildMessageID:message_.messageID]
      buildMessageFromUserID:message_.fromUserID]
     buildMessageUserName:message_.userName];
    
    [self buildMessageBodyWithBuilder:builder];
    
    [builder buildMessageTimestamp:message_.timestamp];
    builder.chat_message.toUserID = @"10005";
    builder.chat_message.conversationChatter = @"10005";
    builder.chat_message.messageType = JYBIMMessageTypeWhiteboard;
    return [builder chat_message];
}

///单聊
- (JYBIChatMessage *)createSingleChatMessage:(JYBMessageBuilder *)builder
{
    [[[[[[builder buildNewMessagePattern]
         buildCommandID:message_.commandID]
        buildMessageID:message_.messageID]
       buildMessageFromUserID:message_.fromUserID]
      buildMessageUserName:message_.userName]
     buildMessageToUserID:message_.toUserID];
    
    [self buildMessageBodyWithBuilder:builder];
    
    [builder buildMessageTimestamp:message_.timestamp];
    builder.chat_message.conversationChatter = builder.chat_message.fromUserID;
    builder.chat_message.messageType = JYBIMMessageTypeSingle;
    return [builder chat_message];
}

///群聊
- (JYBIChatMessage *)createGroupChatMessage:(JYBMessageBuilder *)builder
{
    [[self buildGroupCommonMessageWithBuilder:builder]
     buildMessageTimestamp:message_.timestamp];
    
    builder.chat_message.messageType = JYBIMMessageTypeGroup;
    
    return [builder chat_message];
}

///工单评论
- (JYBIChatMessage *)createBillCommentMessage:(JYBMessageBuilder *)builder
{
    [[self buildGroupCommonMessageWithBuilder:builder]
     buildMessageTimestamp:message_.timestamp];
    
    builder.chat_message.messageType = JYBIMMessageTypeBillComment;
    
    return [builder chat_message];
}

///工单节点
- (JYBIChatMessage *)createBillResultMessage:(JYBMessageBuilder *)builder
{
    [[self buildGroupNodeCommonMessageWithBuilder:builder]
     buildMessageTimestamp:message_.timestamp];
    
    builder.chat_message.messageType = JYBIMMessageTypeBillResult;
    
    return [builder chat_message];
}

///质量检查单评论
- (JYBIChatMessage *)createQualityCheckCommentMessage:(JYBMessageBuilder *)builder
{
    [[self buildGroupCommonMessageWithBuilder:builder]
     buildMessageTimestamp:message_.timestamp];
    
    builder.chat_message.messageType = JYBIMMessageTypeQualityComment;
    
    return [builder chat_message];
}

///质量检查单执行结果-节点
- (JYBIChatMessage *)createQualityCheckResultMessage:(JYBMessageBuilder *)builder
{
    [[self buildGroupNodeCommonMessageWithBuilder:builder]
     buildMessageTimestamp:message_.timestamp];
    
    builder.chat_message.messageType = JYBIMMessageTypeQualityResult;
    
    return [builder chat_message];
}

///安全检查单评论
- (JYBIChatMessage *)createSafetyCheckCommentMessage:(JYBMessageBuilder *)builder
{
    [[self buildGroupCommonMessageWithBuilder:builder]
     buildMessageTimestamp:message_.timestamp];
    
    builder.chat_message.messageType = JYBIMMessageTypeSafetyComment;
    
    return [builder chat_message];
}

///安全检查单执行结果-节点
- (JYBIChatMessage *)createSafetyCheckResultMessage:(JYBMessageBuilder *)builder
{
    [[self buildGroupNodeCommonMessageWithBuilder:builder]
     buildMessageTimestamp:message_.timestamp];
    
    builder.chat_message.messageType = JYBIMMessageTypeSafetyResult;
    
    return [builder chat_message];
}

///日常巡查
- (JYBIChatMessage *)createDailuInspectResultMessage:(JYBMessageBuilder *)builder
{
    [[self buildGroupCommonMessageWithBuilder:builder]
     buildMessageTimestamp:message_.timestamp];
    
    builder.chat_message.messageType = JYBIMMessageTypeDaily;
    
    return [builder chat_message];
}

- (JYBMessageBuilder *)buildGroupCommonMessageWithBuilder:(JYBMessageBuilder *)builder
{
    [[[[[[builder buildNewMessagePattern]
         buildCommandID:message_.commandID]
        buildMessageID:message_.messageID]
       buildMessageFromUserID:message_.fromUserID]
      buildMessageUserName:message_.userName]
     buildMessageGroupID:message_.groupID];
    
     [self buildMessageBodyWithBuilder:builder];
//    builder.chat_message.conversationChatter = builder.chat_message.fromUserID;
    builder.chat_message.toUserID = builder.chat_message.conversationChatter;
    return builder;
}

- (JYBMessageBuilder *)buildGroupNodeCommonMessageWithBuilder:(JYBMessageBuilder *)builder
{
    [[[[[[[builder buildNewMessagePattern]
         buildCommandID:message_.commandID]
        buildMessageID:message_.messageID]
       buildMessageFromUserID:message_.fromUserID]
      buildMessageUserName:message_.userName]
     buildMessageGroupID:message_.groupID] buildMessageNodeID:message_.nodeId];
    
    [self buildMessageBodyWithBuilder:builder];
    //    builder.chat_message.conversationChatter = builder.chat_message.fromUserID;
    builder.chat_message.toUserID = builder.chat_message.conversationChatter;
    return builder;
}

//构建消息体部分
- (void)buildMessageBodyWithBuilder:(JYBMessageBuilder *)builder
{
    switch (builder.chat_message.messageBodyType) {
        case JYBIMMessageBodyTypeText:
            [builder buildMessageContent:message_.content];
            break;
        case JYBIMMessageBodyTypeAudio:
        {
            [builder buildMessageContent:kMessageAudioFormatContent];
            [builder buildMessageDuration:message_.duration];
            [builder buildMessageRemoteUrl:message_.fileURL];
            //下载语音...
//            [self downloadAudioWithIChatMessage:builder.chat_message finished:^(NSString *localPath) {
//                [builder buildMessageLocalPath:localPath];
//            }];
            [JYBFileDownloadHandler downloadAudioWithIChatMessage:builder.chat_message finished:^(NSString *localPath) {
                [builder buildMessageLocalPath:localPath];
            }];
        }
            break;
        case JYBIMMessageBodyTypeImage:
        {
            [builder buildMessageContent:kMessageImageFormatContent];
            [builder buildMessageRemoteUrl:message_.fileURL];
            //下载图片...
//            [self downloadImageWithIChatMessage:builder.chat_message finished:^(UIImage *image, CGSize size) {
//                [[builder buildMessageImage:image] buildMessageImageSize:size];
//            }];
            [JYBFileDownloadHandler downloadImageWithIChatMessage:builder.chat_message finished:^(UIImage *image, CGSize size) {
                [[builder buildMessageImage:image] buildMessageImageSize:size];
            }];
        }
            break;
        case JYBIMMessageBodyTypeVideo:
        {
            [builder buildMessageContent:kMessageVideoFormatContent];
            [builder buildMessageDuration:message_.duration];
            [builder buildMessageRemoteUrl:message_.fileURL];
            //下载视频...
//            [self downloadVideoDataWithIChatMessage:builder.chat_message finished:^(NSString *localPath, NSString *videoThumbnailPath, UIImage *image) {
//                [[[builder buildMessageLocalPath:localPath] buildMessageVideoThumbnailPath:videoThumbnailPath] buildMessageImage:image];
//            }];
            [JYBFileDownloadHandler downloadVideoDataWithIChatMessage:builder.chat_message finished:^(NSString *localPath, NSString *videoThumbnailPath, UIImage *image) {
                [[[builder buildMessageLocalPath:localPath] buildMessageVideoThumbnailPath:videoThumbnailPath] buildMessageImage:image];
            }];

        }
            break;
        case JYBIMMessageBodyTypeFile:
            [builder buildMessageContent:kMessageFileFormatContent];
            [builder buildMessageRemoteUrl:message_.fileURL];
            [builder buildMessageFileSize:message_.fileSize];
            //下载文件...
            break;
        default:
            break;
    }
}

/*
- (void)downloadAudioWithIChatMessage:(JYBIChatMessage *)msg finished:(void(^)(NSString *localPath))finished
{
    JYBDownloadFileApi *api = [[JYBDownloadFileApi alloc] initWithDownloadFileUrl:JYBBcfHttpUrl(msg.remoteUrl) type:JYBDownloadFileTypeMP3];
    //下载音频流
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        DLog(@"%@",request.responseJSONObject);
        NSString * localPath = [NSString handleInterceptLibraryResourcePath:request.responseJSONObject];
        finished(localPath);
    } failure:^(__kindof YTKBaseRequest *request) {
        DLog(@"%@",request.requestOperation.error);
    }];
    
}

- (void)downloadImageWithIChatMessage:(JYBIChatMessage *)msg finished:(void(^)(UIImage *image, CGSize size))finished
{
    NSURL * url = [NSURL URLWithString:JYBImageUrl(msg.remoteUrl)];
    UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    //获取图片大小
    [imgView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        imgView.image = image;
        finished(image, image.size);
    }];
}

- (void)downloadVideoDataWithIChatMessage:(JYBIChatMessage *)msg finished:(void(^)(NSString *localPath, NSString *videoThumbnailPath, UIImage *image))finished
{
    JYBDownloadFileApi *api = [[JYBDownloadFileApi alloc] initWithDownloadFileUrl:JYBBcfHttpUrl(msg.remoteUrl) type:JYBDownloadFileTypeMP4];
    //获取Video封面图
    UIImage * videoImage = [UIImage thumbnailImageForVideo:[NSURL URLWithString:JYBBcfHttpUrl(msg.remoteUrl)]];
    NSData *dataImg = UIImageJPEGRepresentation(videoImage, .1);
    NSString *imgPath = [NSString createWhiteboardAudioMessageResourcePathOfType:@"jpg"];
    [dataImg writeToFile:imgPath atomically:YES];
    NSString *videoThumbnailPath = [NSString handleInterceptLibraryResourcePath:imgPath];
    finished(nil, videoThumbnailPath, videoImage);
    //下载Video数据流
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        DLog(@"%@",request.responseJSONObject);
        NSString * localPath = [NSString handleInterceptLibraryResourcePath:request.responseJSONObject];
        finished(localPath, videoThumbnailPath, videoImage);
    } failure:^(__kindof YTKBaseRequest *request) {
        DLog(@"%@",request.requestOperation.error);
    }];
}
*/
@end
