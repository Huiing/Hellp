//
//  JYBIMSendGroupChatMessageApi.m
//  BDSocketIM
//
//  Created by 冰点 on 16/2/27.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBIMSendGroupChatMessageApi.h"

@implementation JYBIMSendGroupChatMessageApi
{
    NSString *_enterpriseCode;
    NSString *_sendUserName;
    NSString *_sendUserId;
    NSString *_groupId;
}

- (instancetype)initGroupChatApiWithEnterpriseCode:(NSString *)enterpriseCode sendUserName:(NSString *)sendUserName sendUserId:(NSString *)sendUserId groupId:(NSString *)groupId
{
    if (self = [super init]) {
        _enterpriseCode = enterpriseCode;
        _sendUserName = sendUserName;
        _sendUserId = sendUserId;
        _groupId = groupId;
    }
    return self;
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

- (NSString *)requestUrl
{
    switch (_type) {
        case JYBIMMessageBodyTypeText:
            return JYBBCHttpUrl(@"/phone/GroupMessageText!upMessage.action");
            break;
        case JYBIMMessageBodyTypeAudio:
            return JYBBCHttpUrl(@"/phone/GroupMessagePhon!upMessage.action");
            break;
        case JYBIMMessageBodyTypeImage:
            return JYBBCHttpUrl(@"/phone/GroupMessagePhoto!upMessage.action");
            break;
        case JYBIMMessageBodyTypeVideo:
            return JYBBCHttpUrl(@"/phone/GroupMessageVideo!upMessage.action");
            break;
        default:
            return nil;
            break;
    }
}

- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        switch (_type) {
            case JYBIMMessageBodyTypeText:
                break;
            case JYBIMMessageBodyTypeAudio:
                [self configFileMessageFormData:formData withType:JYBIMFileTypeAudio];
                break;
            case JYBIMMessageBodyTypeImage:
                [self configFileMessageFormData:formData withType:JYBIMFileTypeImage];
                break;
            case JYBIMMessageBodyTypeVideo:
                [self configFileMessageFormData:formData withType:JYBIMFileTypeVideo];
                break;
            default:
                break;
        }
    };
}

- (void)configFileMessageFormData:(id<AFMultipartFormData>)formData withType:(NSString *)type
{
    NSData *data = _file;
    NSString *name = @"file";
    NSString *formKey = @"file";
    [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
}

- (id)requestArgument
{
    //这里可以优化下
    switch (_type) {
        case JYBIMMessageBodyTypeText:
            return @{@"enterpriseCode":_enterpriseCode,
                     @"userId":_sendUserId,
                     @"name":_sendUserName,
                     @"groupId":_groupId,
                     @"text":_msg};
            break;
        case JYBIMMessageBodyTypeAudio:
            return @{@"enterpriseCode":_enterpriseCode,
                     @"userId":_sendUserId,
                     @"name":_sendUserName,
                     @"groupId":_groupId,
                     @"fileExtName":JYBIMFileTypeAudio,
                     @"duration":@(_duration)};
            break;
        case JYBIMMessageBodyTypeImage:
            return @{@"enterpriseCode":_enterpriseCode,
                     @"userId":_sendUserId,
                     @"name":_sendUserName,
                     @"groupId":_groupId,
                     @"fileExtName":JYBIMFileExtNameTypeImage};
            break;
        case JYBIMMessageBodyTypeVideo:
            return @{@"enterpriseCode":_enterpriseCode,
                     @"userId":_sendUserId,
                     @"name":_sendUserName,
                     @"groupId":_groupId,
                     @"fileExtName":JYBIMFileTypeVideo,
                     @"duration":@(_duration)};
            break;
        default:
            return nil;
            break;
    }
    
}

@end
