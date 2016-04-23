//
//  JYBSafetyCheckManager.m
//  BDSocketIM
//
//  Created by 冰点 on 16/2/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBSafetyCheckHandle.h"
#import "JYBIMSendSCCommentMessageApi.h"
#import "JYBIMSendSCNodeMessageApi.h"

@implementation JYBSafetyCheckHandle
{
    JYBIMSendSCCommentMessageApi *commentApi;
    JYBIMSendSCNodeMessageApi *nodeApi;
}

- (instancetype)initSendBillChatMessageWithEnterpriseCode:(NSString *)enterpriseCode userid:(NSString *)userId name:(NSString *)name orderId:(NSString *)orderId nodeId:(NSString *)nodeId createDt:(NSString *)createDt coordinate:(CLLocationCoordinate2D)coordinate
{
    self = [super initSendBillChatMessageWithEnterpriseCode:enterpriseCode userid:userId name:name orderId:orderId nodeId:nodeId createDt:createDt coordinate:coordinate];
    if (self) {
        commentApi = [[JYBIMSendSCCommentMessageApi alloc] initSafetyCheckCommentApiWithEnterpriseCode:enterpriseCode userName:name userid:userId orderId:orderId];
        nodeApi = [[JYBIMSendSCNodeMessageApi alloc] initSafetyCheckNoteApiWithEnterpriseCode:enterpriseCode userName:name userid:userId orderId:orderId nodeId:nodeId createDt:createDt coordinate:coordinate];
    }
    return self;
}

- (void)sendText:(NSString *)text success:(void (^)(id))success failure:(void (^)(NSString *))failure
{
    if (!text) {
        return;
    }
    if (self.billType == JYBBillTypeComment) {
        commentApi.type = JYBIMMessageBodyTypeText;
        commentApi.msg = text;
        [commentApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
            DLog(@"%@",request.responseJSONObject);
            if ([request.responseJSONObject[@"result"] integerValue] == 1 && ![request.responseJSONObject[@"deleted"] boolValue]) {
                JYBIChatMessage *entity = [[JYBIChatMessage alloc] init];
                entity.commandID = BD_TCP_PROTOCOL_CODE_SAFETYCHECK_COMMENT_TEXT_MESSAGE;
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
    } else {
        nodeApi.type = JYBIMMessageBodyTypeText;
        nodeApi.msg = text;
        [nodeApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
            DLog(@"%@",request.responseJSONObject);
            if ([request.responseJSONObject[@"result"] integerValue] == 1 && ![request.responseJSONObject[@"deleted"] boolValue]) {
                JYBIChatMessage *entity = [[JYBIChatMessage alloc] init];
                entity.commandID = BD_TCP_PROTOCOL_CODE_SAFETYCHECK_RESULT_TEXT_MESSAGE;
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
}

- (void)sendAudio:(NSString *)filePath duration:(NSInteger)duration success:(void (^)(id))success failure:(void (^)(NSString *))failure
{
    if (!filePath) {
        return;
    }
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    if (self.billType == JYBBillTypeComment) {
        commentApi.type = JYBIMMessageBodyTypeAudio;
        commentApi.file = data;
        commentApi.duration = duration;
        [commentApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
            DLog(@"%@",request.responseJSONObject);
            if ([request.responseJSONObject[@"result"] intValue] == 1 && ![request.responseJSONObject[@"deleted"] boolValue]) {
                JYBIChatMessage *entity = [[JYBIChatMessage alloc] init];
                entity.commandID = BD_TCP_PROTOCOL_CODE_SAFETYCHECK_COMMENT_AUDIO_MESSAGE;
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
    } else {
        nodeApi.type = JYBIMMessageBodyTypeAudio;
        nodeApi.file = data;
        nodeApi.duration = duration;
        [nodeApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
            DLog(@"%@",request.responseJSONObject);
            if ([request.responseJSONObject[@"result"] intValue] == 1 && ![request.responseJSONObject[@"deleted"] boolValue]) {
                JYBIChatMessage *entity = [[JYBIChatMessage alloc] init];
                entity.commandID = BD_TCP_PROTOCOL_CODE_SAFETYCHECK_RESULT_AUDIO_MESSAGE;
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
}

- (void)sendImage:(UIImage *)image success:(void (^)(id))success failure:(void (^)(NSString *))failure
{
    if (!image) {
        return;
    }
    if (self.billType == JYBBillTypeComment) {
        commentApi.type = JYBIMMessageBodyTypeImage;
        commentApi.file = UIImageJPEGRepresentation(image, 0.15);
        [commentApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
            DLog(@"%@",request.responseJSONObject);
            if ([request.responseJSONObject[@"result"] intValue] == 1 && ![request.responseJSONObject[@"deleted"] boolValue]) {
                JYBIChatMessage *entity = [[JYBIChatMessage alloc] init];
                entity.commandID = BD_TCP_PROTOCOL_CODE_SAFETYCHECK_COMMENT_IMAGE_MESSAGE;
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
    } else {
        nodeApi.type = JYBIMMessageBodyTypeImage;
        nodeApi.file = UIImageJPEGRepresentation(image, 0.15);
        [nodeApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
            DLog(@"%@",request.responseJSONObject);
            if ([request.responseJSONObject[@"result"] intValue] == 1 && ![request.responseJSONObject[@"deleted"] boolValue]) {
                JYBIChatMessage *entity = [[JYBIChatMessage alloc] init];
                entity.commandID = BD_TCP_PROTOCOL_CODE_SAFETYCHECK_RESULT_IMAGE_MESSAGE;
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
}

- (void)sendVideo:(NSString *)filePath duration:(NSInteger)duration success:(void (^)(id))success failure:(void (^)(NSString *))failure
{
    if (!filePath) {
        return;
    }
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    UIImage * videoImage = [UIImage thumbnailImageForVideo:[NSURL fileURLWithPath:filePath]];
    NSData *dataImg = UIImageJPEGRepresentation(videoImage, .1);
    NSString *imgPath = [NSString createWhiteboardAudioMessageResourcePathOfType:@"jpg"];
    [dataImg writeToFile:imgPath atomically:YES];
    NSString *videoThumbnailPath = [NSString handleInterceptLibraryResourcePath:imgPath];
    
    if (self.billType == JYBBillTypeComment) {
        commentApi.type = JYBIMMessageBodyTypeVideo;
        commentApi.file = data;
        commentApi.duration = duration;
        [commentApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
            DLog(@"%@",request.responseJSONObject);
            if ([request.responseJSONObject[@"result"] intValue] == 1 && ![request.responseJSONObject[@"deleted"] boolValue]) {
                JYBIChatMessage *entity = [[JYBIChatMessage alloc] init];
                entity.commandID = BD_TCP_PROTOCOL_CODE_SAFETYCHECK_COMMENT_VIDEO_MESSAGE;
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
    } else {
        nodeApi.type = JYBIMMessageBodyTypeVideo;
        nodeApi.file = data;
        nodeApi.duration = duration;
        [nodeApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
            DLog(@"%@",request.responseJSONObject);
            if ([request.responseJSONObject[@"result"] intValue] == 1 && ![request.responseJSONObject[@"deleted"] boolValue]) {
                JYBIChatMessage *entity = [[JYBIChatMessage alloc] init];
                entity.commandID = BD_TCP_PROTOCOL_CODE_SAFETYCHECK_RESULT_VIDEO_MESSAGE;
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
}

@end
