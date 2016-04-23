//
//  JYBWhiteBoardModel.m
//  JianYunBao
//
//  Created by 冰点 on 16/3/18.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBWhiteBoardModel.h"
#import "JYBFileDownloadHandler.h"

@implementation JYBWhiteBoardModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"messageId": @"id"};
}

+ (JYBIChatMessage *)parseFromModel:(JYBWhiteBoardModel *)model
{
    JYBIChatMessage *message = [[JYBIChatMessage alloc] init];
    message.messageID = model.messageId;
    message.timestamp = model.dtLong;
    message.fromUserID = model.userId;
    message.userName = model.name;
    message.toUserID = model.enterpriseCode;
    message.conversationChatter = model.enterpriseCode;
    message.messageType = JYBIMMessageTypeWhiteboard;
    
    if (model.isPhon) {
        message.commandID = BD_TCP_PROTOCOL_CODE_WHITEBOARD_AUDIO_MESSAGE;
        message.messageBodyType = JYBIMMessageBodyTypeAudio;
        message.content = kMessageAudioFormatContent;
        message.duration = model.phonDuration;
        message.remoteUrl = model.phonPath;
//        [JYBFileDownloadHandler downloadAudioWithIChatMessage:message finished:^(NSString *localPath) {
//            message.localPath = localPath;
//        }];
    } else if (model.isPhoto) {
        message.commandID = BD_TCP_PROTOCOL_CODE_WHITEBOARD_IMAGE_MESSAGE;
        message.messageBodyType = JYBIMMessageBodyTypeImage;
        message.content = kMessageImageFormatContent;
        message.remoteUrl = model.photoPath;
//        [JYBFileDownloadHandler downloadImageWithIChatMessage:message finished:^(UIImage *image, CGSize size) {
//            message.image = image;
//            message.imageSize = size;
//        }];
    } else if (model.isVideo) {
        message.commandID = BD_TCP_PROTOCOL_CODE_WHITEBOARD_VIDEO_MESSAGE;
        message.messageBodyType = JYBIMMessageBodyTypeVideo;
        message.content = kMessageVideoFormatContent;
        message.duration = model.videoDuration;
        message.remoteUrl = model.videoPath;
        [JYBFileDownloadHandler downloadVideoDataWithIChatMessage:message finished:^(NSString *localPath, NSString *videoThumbnailPath, UIImage *image) {
            message.localPath = localPath;
            message.videoThumbnailPath = videoThumbnailPath;
            message.image = image;
        }];
    } else if (model.isDocument) {
        message.commandID = BD_TCP_PROTOCOL_CODE_WHITEBOARD_FILE_MESSAGE;
        message.messageBodyType = JYBIMMessageBodyTypeFile;
        message.content = kMessageFileFormatContent;
        message.remoteUrl = model.documentPath;
        message.fileSize = model.documentSize;
        //download file...
    } else {
        message.commandID = BD_TCP_PROTOCOL_CODE_WHITEBOARD_TEXT_MESSAGE;
        message.messageBodyType = JYBIMMessageBodyTypeText;
        message.content = model.textStr;
    }

    message.isRead = YES;
    message.isPlayed = YES;
    return message;
}

@end
