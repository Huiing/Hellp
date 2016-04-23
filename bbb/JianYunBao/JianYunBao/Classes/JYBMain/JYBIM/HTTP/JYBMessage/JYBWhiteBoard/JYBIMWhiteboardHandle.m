//
//  BDIMWhiteboardManager.m
//  BDSocketIM
//
//  Created by 冰点 on 16/2/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBIMWhiteboardHandle.h"
#import "JYBIMSendWhiteboardMessageApi.h"

@implementation JYBIMWhiteboardHandle
{
    JYBIMSendWhiteboardMessageApi *api;
}

- (instancetype)initSendMessageWithEnterpriseCode:(NSString *)enterpriseCode userid:(NSString *)userId name:(NSString *)name
{
    if (self = [super initSendMessageWithEnterpriseCode:enterpriseCode userid:userId name:name]) {
        api = [[JYBIMSendWhiteboardMessageApi alloc] initWhiteboardApiWithEnterpriseCode:enterpriseCode username:name userid:userId];
    }
    return self;
}

- (void)sendText:(NSString *)text success:(void (^)(id message))success failure:(void (^)(NSString *error))failure;
{
    if (!text) {
        return;
    }
    api.type = JYBIMMessageBodyTypeText;
    api.msg = text;
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        DLog(@"%@",request.responseJSONObject);
        if ([request.responseJSONObject[@"result"] intValue] == 1) {
            JYBIChatMessage *entity = [[JYBIChatMessage alloc] init];
            entity.commandID = BD_TCP_PROTOCOL_CODE_WHITEBOARD_TEXT_MESSAGE;
            entity.messageID = request.responseJSONObject[@"id"];
            entity.fromUserID = self.sendUserId;
            entity.userName = self.sendUserName;
            entity.conversationChatter = self.enterpriseCode;
            entity.toUserID = self.enterpriseCode;
            entity.content = text;
            entity.messageBodyType = JYBIMMessageBodyTypeText;
            entity.timestamp = (NSTimeInterval)[NSDate getTimestamp] * 1000;
            [[BDIMDatabaseUtil sharedInstance] insertIChatMessages:@[entity] success:^{
                success(entity);
            } failure:^(NSString *errorDescripe) {
                failure(errorDescripe);
            }];
        } else {
            failure(@"企业白板文本消息发送失败！");
        }
    } failure:^(YTKBaseRequest *request) {
        DLog(@"%@",request.requestOperation.error);
        failure(@"网络异常！");
    }];
}

- (void)sendAudio:(NSString *)filePath duration:(NSInteger)duration success:(void (^)(id message))success failure:(void (^)(NSString *error))failure;
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
            entity.commandID = BD_TCP_PROTOCOL_CODE_WHITEBOARD_AUDIO_MESSAGE;
            entity.messageID = request.responseJSONObject[@"id"];
            entity.fromUserID = self.sendUserId;
            entity.userName = self.sendUserName;
            entity.conversationChatter = self.enterpriseCode;
            entity.toUserID = self.enterpriseCode;
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
            failure(@"企业白板音频消息发送失败！");
        }
    } failure:^(YTKBaseRequest *request) {
        DLog(@"%@",request.requestOperation.error);
        failure(@"网络异常！");
    }];
}

- (void)sendImage:(UIImage *)image success:(void (^)(id message))success failure:(void (^)(NSString *error))failure;
{
    if (!image) {
        return;
    }
    api.type = JYBIMMessageBodyTypeImage;
    api.file = UIImageJPEGRepresentation(image, 0.15);
    
//    JYBIChatMessage *temp_entity = [[JYBIChatMessage alloc] init];
//    temp_entity.messageID = @"10000";
//    temp_entity.senderID = self.sendUserId;
//    temp_entity.userName = self.sendUserName;
//    temp_entity.image = image;
//    temp_entity.image_url = nil;//request.responseJSONObject[@"filePath"];
//    temp_entity.imageSize = image.size;
//    temp_entity.messageBodyType = JYBIMMessageBodyTypeImage;
//    temp_entity.s_timestamp = (NSTimeInterval)[NSDate getTimestamp] * 1000;
    
//    [[BDIMDatabaseUtil sharedInstance] insertWhiteBoardMessages:@[temp_entity] success:^{
//        success(temp_entity);
//    } failure:^(NSString *errorDescripe) {
//    }];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        DLogJSON(request.responseJSONObject);
        if ([request.responseJSONObject[@"result"] intValue] == 1) {
            
//            [[BDIMDatabaseUtil sharedInstance] deleteWhiteBoardMessage:temp_entity.messageID success:^{
//                
//            }];
            
            JYBIChatMessage *entity = [[JYBIChatMessage alloc] init];
            entity.commandID = BD_TCP_PROTOCOL_CODE_WHITEBOARD_IMAGE_MESSAGE;
            entity.messageID = request.responseJSONObject[@"id"];
            entity.fromUserID = self.sendUserId;
            entity.userName = self.sendUserName;
            entity.conversationChatter = self.enterpriseCode;
            entity.toUserID = self.enterpriseCode;
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
            failure(@"企业白板图片消息发送失败！");
        }
    } failure:^(YTKBaseRequest *request) {
        DLog(@"%@",request.requestOperation.error);
        failure(@"网络异常！");
    }];
}

- (void)sendVideo:(NSString *)filePath duration:(NSInteger)duration success:(void (^)(id message))success failure:(void (^)(NSString *error))failure;
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
    
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        DLog(@"%@",request.responseJSONObject);
        if ([request.responseJSONObject[@"result"] intValue] == 1) {
            JYBIChatMessage *entity = [[JYBIChatMessage alloc] init];
            entity.commandID = BD_TCP_PROTOCOL_CODE_WHITEBOARD_VIDEO_MESSAGE;
            entity.messageID = request.responseJSONObject[@"id"];
            entity.fromUserID = self.sendUserId;
            entity.userName = self.sendUserName;
            entity.conversationChatter = self.enterpriseCode;
            entity.toUserID = self.enterpriseCode;
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
            failure(@"企业白板视频消息发送失败！");
        }
    } failure:^(YTKBaseRequest *request) {
        DLog(@"%@",request.requestOperation.error);
        failure(@"网络异常！");
    }];
}

@end
