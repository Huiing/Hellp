//
//  JYBMessageBuilder.m
//  JianYunBao
//
//  Created by 冰点 on 16/3/10.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBMessageBuilder.h"

@implementation JYBMessageBuilder
@synthesize chat_message = chat_message_;

- (JYBMessageBuilder *)buildNewMessagePattern
{
    chat_message_ = [[JYBIChatMessage alloc] init];
    return self;
}

- (JYBMessageBuilder *)buildCommandID:(NSInteger)commandID
{
    chat_message_.commandID = commandID;
    chat_message_.messageBodyType = [self messageBodyTypeWithCmdID:commandID];
//    chat_message_.messageType = [];
    return self;
}

- (JYBMessageBuilder *)buildMessageID:(NSString *)msgID
{
    chat_message_.messageID = msgID;
    return self;
}

- (JYBMessageBuilder *)buildMessageFromUserID:(NSString *)fromUserID
{
    chat_message_.fromUserID = fromUserID;
    return self;
}

- (JYBMessageBuilder *)buildMessageUserName:(NSString *)userName
{
    chat_message_.userName = userName;
    return self;
}

- (JYBMessageBuilder *)buildMessageToUserID:(NSString *)toUserID
{
    chat_message_.toUserID = toUserID;
    return self;
}

- (JYBMessageBuilder *)buildMessageGroupID:(NSString *)groupID
{
    chat_message_.conversationChatter = groupID;
    return self;
}

- (JYBMessageBuilder *)buildMessageNodeID:(NSString *)nodeID
{
    chat_message_.nodeId = nodeID;
    return self;
}

- (JYBMessageBuilder *)buildMessageContent:(NSString *)content
{
    chat_message_.content = content;
    return self;
}

- (JYBMessageBuilder *)buildMessageDuration:(NSInteger)duration
{
    chat_message_.duration = duration;
    return self;
}

- (JYBMessageBuilder *)buildMessageRemoteUrl:(NSString *)remoteUrl
{
    chat_message_.remoteUrl = remoteUrl;
    return self;
}

- (JYBMessageBuilder *)buildMessageFileSize:(NSInteger)size
{
    chat_message_.fileSize = size;
    return self;
}

- (JYBMessageBuilder *)buildMessageLocalPath:(NSString *)localPath
{
    chat_message_.localPath = localPath;
    return self;
}

- (JYBMessageBuilder *)buildMessageImageSize:(CGSize)imageSize
{
    chat_message_.imageSize = imageSize;
    return self;
}

- (JYBMessageBuilder *)buildMessageImage:(UIImage *)image
{
    chat_message_.image = image;
    return self;
}

- (JYBMessageBuilder *)buildMessageVideoThumbnailPath:(NSString *)videoThumbnailPath
{
    chat_message_.videoThumbnailPath = videoThumbnailPath;
    return self;
}

- (JYBMessageBuilder *)buildMessageTimestamp:(NSTimeInterval)timestamp
{
    chat_message_.timestamp = timestamp;
    return self;
}

#pragma mark - Private Method
- (JYBIMMessageBodyType)messageBodyTypeWithCmdID:(NSInteger)commandID
{
    switch (commandID) {
        case BD_TCP_PROTOCOL_CODE_WHITEBOARD_TEXT_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_CHATGROUP_TEXT_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_CHATSINGLE_TEXT_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_BILL_COMMENT_TEXT_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_BILL_RESULT_TEXT_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_QUALITYCHECK_COMMENT_TEXT_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_QUALITYCHECK_RESULT_TEXT_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_SAFETYCHECK_COMMENT_TEXT_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_SAFETYCHECK_RESULT_TEXT_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_DAILYINSPECT_RESULT_TEXT_MESSAGE:
            return JYBIMMessageBodyTypeText;
            break;
        case BD_TCP_PROTOCOL_CODE_WHITEBOARD_AUDIO_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_CHATGROUP_AUDIO_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_CHATSINGLE_AUDIO_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_BILL_COMMENT_AUDIO_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_BILL_RESULT_AUDIO_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_QUALITYCHECK_COMMENT_AUDIO_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_QUALITYCHECK_RESULT_AUDIO_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_SAFETYCHECK_COMMENT_AUDIO_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_SAFETYCHECK_RESULT_AUDIO_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_DAILYINSPECT_RESULT_AUDIO_MESSAGE:
            return JYBIMMessageBodyTypeAudio;
            break;
        case BD_TCP_PROTOCOL_CODE_WHITEBOARD_IMAGE_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_CHATGROUP_IMAGE_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_CHATSINGLE_IMAGE_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_BILL_COMMENT_IMAGE_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_BILL_RESULT_IMAGE_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_QUALITYCHECK_COMMENT_IMAGE_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_QUALITYCHECK_RESULT_IMAGE_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_SAFETYCHECK_COMMENT_IMAGE_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_SAFETYCHECK_RESULT_IMAGE_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_DAILYINSPECT_RESULT_IMAGE_MESSAGE:
            return JYBIMMessageBodyTypeImage;
            break;
        case BD_TCP_PROTOCOL_CODE_WHITEBOARD_VIDEO_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_CHATGROUP_VIDEO_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_CHATSINGLE_VIDEO_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_BILL_COMMENT_VIDEO_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_BILL_RESULT_VIDEO_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_QUALITYCHECK_COMMENT_VIDEO_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_QUALITYCHECK_RESULT_VIDEO_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_SAFETYCHECK_COMMENT_VIDEO_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_SAFETYCHECK_RESULT_VIDEO_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_DAILYINSPECT_RESULT_VIDEO_MESSAGE:
            return JYBIMMessageBodyTypeVideo;
            break;
        case BD_TCP_PROTOCOL_CODE_WHITEBOARD_FILE_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_CHATGROUP_FILE_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_CHATSINGLE_FILE_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_BILL_COMMENT_FILE_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_BILL_RESULT_FILE_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_QUALITYCHECK_COMMENT_FILE_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_QUALITYCHECK_RESULT_FILE_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_SAFETYCHECK_COMMENT_FILE_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_SAFETYCHECK_RESULT_FILE_MESSAGE:
        case BD_TCP_PROTOCOL_CODE_DAILYINSPECT_RESULT_FILE_MESSAGE:
            return JYBIMMessageBodyTypeFile;
            break;
        default:
            return JYBIMMessageBodyTypeNone;
            break;
    }
}



@end
