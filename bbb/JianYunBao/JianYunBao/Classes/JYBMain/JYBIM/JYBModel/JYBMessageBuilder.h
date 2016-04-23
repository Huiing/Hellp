//
//  JYBMessageBuilder.h
//  JianYunBao
//  消息建造者
//  Created by 冰点 on 16/3/10.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYBIChatMessage.h"
#import "JYBIMMessage.h"

@interface JYBMessageBuilder : NSObject
{
    @protected
    JYBIChatMessage *chat_message_;
}

@property (nonatomic, readonly) JYBIChatMessage *chat_message;

- (JYBMessageBuilder *)buildNewMessagePattern;
- (JYBMessageBuilder *)buildCommandID:(NSInteger)commandID;

- (JYBMessageBuilder *)buildMessageID:(NSString *)msgID;
- (JYBMessageBuilder *)buildMessageFromUserID:(NSString *)fromUserID;
- (JYBMessageBuilder *)buildMessageUserName:(NSString *)userName;
- (JYBMessageBuilder *)buildMessageToUserID:(NSString *)toUserID;

//
- (JYBMessageBuilder *)buildMessageGroupID:(NSString *)groupID;
- (JYBMessageBuilder *)buildMessageNodeID:(NSString *)nodeID;


//文本
- (JYBMessageBuilder *)buildMessageContent:(NSString *)content;

- (JYBMessageBuilder *)buildMessageDuration:(NSInteger)duration;
- (JYBMessageBuilder *)buildMessageRemoteUrl:(NSString *)remoteUrl;
- (JYBMessageBuilder *)buildMessageFileSize:(NSInteger)size;

- (JYBMessageBuilder *)buildMessageLocalPath:(NSString *)localPath;
- (JYBMessageBuilder *)buildMessageImageSize:(CGSize)imageSize;
- (JYBMessageBuilder *)buildMessageImage:(UIImage *)image;
- (JYBMessageBuilder *)buildMessageVideoThumbnailPath:(NSString *)videoThumbnailPath;

//语音
//- (JYBMessageBuilder *)buildMessageAudioDuration:(NSInteger)audioDuration;
//- (JYBMessageBuilder *)buildMessageAudioUrl:(NSString *)audioUrl;

//图片
//- (JYBMessageBuilder *)buildMessageImageUrl:(NSString *)imageUrl;

//视频


//文件

//服务器时间戳
- (JYBMessageBuilder *)buildMessageTimestamp:(NSTimeInterval)timestamp;

@end
