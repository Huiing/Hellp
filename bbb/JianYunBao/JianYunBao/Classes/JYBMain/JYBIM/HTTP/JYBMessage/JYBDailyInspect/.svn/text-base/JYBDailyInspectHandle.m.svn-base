//
//  JYBDailyInspectManager.m
//  BDSocketIM
//
//  Created by 冰点 on 16/2/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBDailyInspectHandle.h"
#import "JYBIMSendDailyInspectMessageApi.h"

@implementation JYBDailyInspectHandle
{
    JYBIMSendDailyInspectMessageApi *api;
}

- (instancetype)initSendBillChatMessageWithEnterpriseCode:(NSString *)enterpriseCode userid:(NSString *)userId name:(NSString *)name orderId:(NSString *)orderId nodeId:(NSString *)nodeId createDt:(NSString *)createDt coordinate:(CLLocationCoordinate2D)coordinate
{
    self = [super initSendBillChatMessageWithEnterpriseCode:enterpriseCode userid:userId name:name orderId:orderId nodeId:nodeId createDt:createDt coordinate:coordinate];
    if (self) {
        api = [[JYBIMSendDailyInspectMessageApi alloc] initDailyInspectApiWithEnterpriseCode:enterpriseCode userName:name userid:userId orderId:orderId createDt:createDt coordinate:coordinate];
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
        if ([request.responseJSONObject[@"result"] integerValue] == 1 && ![request.responseJSONObject[@"deleted"] boolValue]) {
            JYBIChatMessage *entity = [[JYBIChatMessage alloc] init];
            entity.commandID = BD_TCP_PROTOCOL_CODE_DAILYINSPECT_RESULT_TEXT_MESSAGE;
            entity.messageID = request.responseJSONObject[@"id"];
            entity.fromUserID = self.sendUserId;
            entity.userName = self.sendUserName;
            entity.conversationChatter = self.groupId;
            entity.toUserID = self.groupId;
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
    
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        DLog(@"%@",request.responseJSONObject);
        if ([request.responseJSONObject[@"result"] intValue] == 1 && ![request.responseJSONObject[@"deleted"] boolValue]) {
            JYBIChatMessage *entity = [[JYBIChatMessage alloc] init];
            entity.commandID = BD_TCP_PROTOCOL_CODE_DAILYINSPECT_RESULT_AUDIO_MESSAGE;
            entity.messageID = request.responseJSONObject[@"id"];
            entity.fromUserID = self.sendUserId;
            entity.userName = self.sendUserName;
            entity.conversationChatter = self.groupId;
            entity.toUserID = self.groupId;
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
    } failure:^(__kindof YTKBaseRequest *request) {
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
        if ([request.responseJSONObject[@"result"] intValue] == 1 && ![request.responseJSONObject[@"deleted"] boolValue]) {
            JYBIChatMessage *entity = [[JYBIChatMessage alloc] init];
            entity.commandID = BD_TCP_PROTOCOL_CODE_DAILYINSPECT_RESULT_IMAGE_MESSAGE;
            entity.messageID = request.responseJSONObject[@"id"];
            entity.fromUserID = self.sendUserId;
            entity.userName = self.sendUserName;
            entity.conversationChatter = self.groupId;
            entity.toUserID = self.groupId;
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
        if ([request.responseJSONObject[@"result"] intValue] == 1 && ![request.responseJSONObject[@"deleted"] boolValue]) {
            JYBIChatMessage *entity = [[JYBIChatMessage alloc] init];
            entity.commandID = BD_TCP_PROTOCOL_CODE_DAILYINSPECT_RESULT_VIDEO_MESSAGE;
            entity.messageID = request.responseJSONObject[@"id"];
            entity.fromUserID = self.sendUserId;
            entity.userName = self.sendUserName;
            entity.conversationChatter = self.groupId;
            entity.toUserID = self.groupId;
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
