//
//  JYBChatSingleManager.m
//  BDSocketIM
//
//  Created by 冰点 on 16/2/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBIMChatSingleHandle.h"
#import "JYBIMSendSingleChatMessageApi.h"

@implementation JYBIMChatSingleHandle
{
    JYBIMSendSingleChatMessageApi *api;
}

- (instancetype)initSendSingleChatMessageWithEnterpriseCode:(NSString *)enterpriseCode userid:(NSString *)userId name:(NSString *)name receiveUserId:(NSString *)receiveUserId
{
    if (self = [super initSendSingleChatMessageWithEnterpriseCode:enterpriseCode userid:userId name:name receiveUserId:receiveUserId]) {
        api = [[JYBIMSendSingleChatMessageApi alloc] initSingleChatApiWithEnterpriseCode:enterpriseCode sendUserName:name sendUserId:userId receiveUserId:receiveUserId];
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
        DLog(@"%@",request.responseJSONObject);
        if ([request.responseJSONObject[@"result"] intValue] == 1) {
            JYBIChatMessage *entity = [[JYBIChatMessage alloc] init];
            entity.commandID = BD_TCP_PROTOCOL_CODE_CHATSINGLE_TEXT_MESSAGE;
            entity.messageID = request.responseJSONObject[@"id"];
            entity.fromUserID = self.sendUserId;
            entity.userName = self.sendUserName;
            entity.conversationChatter = self.receiveUserId;
            entity.toUserID = self.receiveUserId;
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

- (void)sendAudio:(NSString *)filePath duration:(NSInteger)duration success:(void (^)(id))success failure:(void (^)(NSString *))failure
{
    if (!filePath) {
        return;
    }
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    api.type = JYBIMMessageBodyTypeAudio;
    api.file = data;//音频文件
    api.duration = duration;
    
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        DLog(@"%@",request.responseJSONObject);
        if ([request.responseJSONObject[@"result"] intValue] == 1) {
            JYBIChatMessage *entity = [[JYBIChatMessage alloc] init];
            entity.commandID = BD_TCP_PROTOCOL_CODE_CHATSINGLE_AUDIO_MESSAGE;
            entity.messageID = request.responseJSONObject[@"id"];
            entity.fromUserID = self.sendUserId;
            entity.userName = self.sendUserName;
            entity.conversationChatter = self.receiveUserId;
            entity.toUserID = self.receiveUserId;
            entity.content = kMessageAudioFormatContent;
            entity.remoteUrl = request.responseJSONObject[@"filePath"];
            
            NSString *aFilePath = [NSString copyWhiteboardAudioFilePath:filePath];
            entity.localPath = aFilePath;
            
            entity.duration = duration;
            entity.messageBodyType = JYBIMMessageBodyTypeAudio;
            entity.timestamp = (NSTimeInterval)[NSDate getTimestamp] * 1000;
            [[BDIMDatabaseUtil sharedInstance] insertIChatMessages:@[entity] success:^{
                success(entity);
            } failure:^(NSString *errorDescripe) {
                failure(errorDescripe);
            }];
        } else {
            failure(@"音频消息发送失败！");
        }
    } failure:^(YTKBaseRequest *request) {
        DLog(@"%@",request.requestOperation.error);
        failure(@"网络异常！");
    }];
}

- (void)sendImage:(UIImage *)image success:(void (^)(id))success failure:(void (^)(NSString *))failure
{
    if (!image) {
        return;
    }
    api.type = JYBIMMessageBodyTypeImage;
    api.file = UIImageJPEGRepresentation(image, 0.15);
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        DLog(@"%@",request.responseJSONObject);
        if ([request.responseJSONObject[@"result"] intValue] == 1) {
            JYBIChatMessage *entity = [[JYBIChatMessage alloc] init];
            entity.commandID = BD_TCP_PROTOCOL_CODE_CHATSINGLE_IMAGE_MESSAGE;
            entity.messageID = request.responseJSONObject[@"id"];
            entity.fromUserID = self.sendUserId;
            entity.userName = self.sendUserName;
            entity.conversationChatter = self.receiveUserId;
            entity.toUserID = self.receiveUserId;
            entity.content = kMessageImageFormatContent;
            entity.image = image;
            entity.remoteUrl = request.responseJSONObject[@"filePath"];
            entity.imageSize = image.size;
            entity.messageBodyType = JYBIMMessageBodyTypeImage;
            entity.timestamp = (NSTimeInterval)[NSDate getTimestamp] * 1000;
            [[BDIMDatabaseUtil sharedInstance] insertIChatMessages:@[entity] success:^{
                success(entity);
            } failure:^(NSString *errorDescripe) {
                failure(errorDescripe);
            }];
        } else {
            failure(@"图片消息发送失败！");
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        DLog(@"%@",request.requestOperation.error);
        failure(@"网络异常！");
    }];
}

- (void)sendVideo:(NSString *)filePath duration:(NSInteger)duration success:(void (^)(id))success failure:(void (^)(NSString *))failure
{
    if (!filePath) {
        return;
    }
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    api.type = JYBIMMessageBodyTypeVideo;
    api.file = data;
    api.duration = duration;
    
    UIImage * videoImage = [UIImage thumbnailImageForVideo:[NSURL fileURLWithPath:filePath]];
    NSData *dataImg = UIImageJPEGRepresentation(videoImage, .1);
    NSString *imgPath = [NSString createWhiteboardAudioMessageResourcePathOfType:@"jpg"];
    [dataImg writeToFile:imgPath atomically:YES];
    NSString *videoThumbnailPath = [NSString handleInterceptLibraryResourcePath:imgPath];
    
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        DLog(@"%@",request.responseJSONObject);
        if ([request.responseJSONObject[@"result"] intValue] == 1) {
            JYBIChatMessage *entity = [[JYBIChatMessage alloc] init];
            entity.commandID = BD_TCP_PROTOCOL_CODE_CHATSINGLE_VIDEO_MESSAGE;
            entity.messageID = request.responseJSONObject[@"id"];
            entity.fromUserID = self.sendUserId;
            entity.userName = self.sendUserName;
            entity.conversationChatter = self.receiveUserId;
            entity.toUserID = self.receiveUserId;
            entity.content = kMessageVideoFormatContent;
            entity.remoteUrl = request.responseJSONObject[@"filePath"];
            entity.duration = duration;
            entity.image = videoImage;
            entity.videoThumbnailPath = videoThumbnailPath;
            entity.localPath = [NSString handleInterceptLibraryResourcePath:filePath];
            entity.messageBodyType = JYBIMMessageBodyTypeVideo;
            entity.timestamp = (NSTimeInterval)[NSDate getTimestamp] * 1000;
            [[BDIMDatabaseUtil sharedInstance] insertIChatMessages:@[entity] success:^{
                success(entity);
            } failure:^(NSString *errorDescripe) {
                failure(errorDescripe);
            }];
        } else {
            failure(@"视频消息发送失败！");
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        DLog(@"%@",request.requestOperation.error);
        failure(@"网络异常！");
    }];
}

@end
