//
//  JYBIMSendQCCommentMessageApi.m
//  BDSocketIM
//
//  Created by 冰点 on 16/2/27.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBIMSendQCCommentMessageApi.h"

@implementation JYBIMSendQCCommentMessageApi
{
    NSString *_enterpriseCode;
    NSString *_username;
    NSString *_userid;
    NSString *_orderId;
}

- (instancetype)initQualityCheckCommentApiWithEnterpriseCode:(NSString *)enterpriseCode userName:(NSString *)username userid:(NSString *)userid orderId:(NSString *)orderId
{
    if (self = [super init]) {
        _enterpriseCode = enterpriseCode;
        _username = username;
        _userid = userid;
        _orderId = orderId;
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
            return JYBBCHttpUrl(@"/phone/QualityInspectDiscussText!upMessage.action");
            break;
        case JYBIMMessageBodyTypeAudio:
            return JYBBCHttpUrl(@"/phone/QualityInspectDiscussPhon!upMessage.action");
            break;
        case JYBIMMessageBodyTypeImage:
            return JYBBCHttpUrl(@"/phone/QualityInspectDiscussPhoto!upMessage.action");
            break;
        case JYBIMMessageBodyTypeVideo:
            return JYBBCHttpUrl(@"/phone/QualityInspectDiscussVideo!upMessage.action");
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
            return @{
                     @"userId":_userid,
                     @"name":_username,
                     @"orderId":_orderId,
                     @"text":_msg};
            break;
        case JYBIMMessageBodyTypeAudio:
            return @{@"enterpriseCode":_enterpriseCode,
                     @"userId":_userid,
                     @"name":_username,
                     @"orderId":_orderId,
                     @"fileExtName":JYBIMFileTypeAudio,
                     @"duration":@(_duration)};
            break;
        case JYBIMMessageBodyTypeImage:
            return @{@"enterpriseCode":_enterpriseCode,
                     @"userId":_userid,
                     @"name":_username,
                     @"orderId":_orderId,
                     @"fileExtName":JYBIMFileExtNameTypeImage};
            break;
        case JYBIMMessageBodyTypeVideo:
            return @{@"enterpriseCode":_enterpriseCode,
                     @"userId":_userid,
                     @"name":_username,
                     @"orderId":_orderId,
                     @"fileExtName":JYBIMFileTypeVideo,
                     @"duration":@(_duration)};
            break;
        default:
            return nil;
            break;
    }
    
}
@end
