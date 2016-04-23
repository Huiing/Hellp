//
//  BDIMSendWhiteboardTextApi.m
//  IMDemo
//
//  Created by 冰点 on 16/1/29.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBIMSendWhiteboardMessageApi.h"

@implementation JYBIMSendWhiteboardMessageApi
{
    NSString *_enterpriseCode;
    NSString *_username;
    NSString *_userid;
}

- (instancetype)initWhiteboardApiWithEnterpriseCode:(NSString *)enterpriseCode username:(NSString *)username userid:(NSString *)userid
{
    if (self = [super init]) {
        _enterpriseCode = enterpriseCode;
        _username = username;
        _userid = userid;
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
            return JYBBCHttpUrl(@"/phone/WhiteboardText!upMessage.action");
            break;
        case JYBIMMessageBodyTypeAudio:
            return JYBBCHttpUrl(@"/phone/WhiteboardPhon!upMessage.action");
            break;
        case JYBIMMessageBodyTypeImage:
            return JYBBCHttpUrl(@"/phone/WhiteboardPhoto!upMessage.action");
            break;
        case JYBIMMessageBodyTypeVideo:
            return JYBBCHttpUrl(@"/phone/WhiteboardVideo!upMessage.action");
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

//- (NSString *)resumableDownloadPath
//{
//    return nil;
//}

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
                     @"userId":_userid,
                     @"name":_username,
                     @"text":_msg};
            break;
        case JYBIMMessageBodyTypeAudio:
            return @{@"enterpriseCode":_enterpriseCode,
                     @"userId":_userid,
                     @"name":_username,
                     @"fileExtName":JYBIMFileTypeAudio,
                     @"duration":@(_duration)};
            break;
        case JYBIMMessageBodyTypeImage:
            return @{@"enterpriseCode":_enterpriseCode,
                     @"userId":_userid,
                     @"name":_username,
                     @"fileExtName":JYBIMFileExtNameTypeImage};
            break;
        case JYBIMMessageBodyTypeVideo:
            return @{@"enterpriseCode":_enterpriseCode,
                     @"userId":_userid,
                     @"name":_username,
                     @"fileExtName":JYBIMFileTypeVideo,
                     @"duration":@(_duration)};
            break;
        default:
            return nil;
            break;
    }
    
}


@end
