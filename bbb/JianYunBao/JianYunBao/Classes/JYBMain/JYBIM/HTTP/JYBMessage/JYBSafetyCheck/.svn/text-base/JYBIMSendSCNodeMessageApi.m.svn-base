//
//  JYBIMSendSCNodeMessageApi.m
//  BDSocketIM
//
//  Created by 冰点 on 16/2/27.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBIMSendSCNodeMessageApi.h"

@implementation JYBIMSendSCNodeMessageApi
{
    NSString *_enterpriseCode;
    NSString *_username;
    NSString *_userid;
    NSString *_orderId;
    NSString *_nodeId;
    NSString *_createDt;
    NSNumber *_latitude;
    NSNumber *_longitude;
}

- (instancetype)initSafetyCheckNoteApiWithEnterpriseCode:(NSString *)enterpriseCode userName:(NSString *)username userid:(NSString *)userid orderId:(NSString *)orderId nodeId:(NSString *)nodeId createDt:(NSString *)createDt coordinate:(CLLocationCoordinate2D)coordinate
{
    if (self = [super init]) {
        _enterpriseCode = enterpriseCode;
        _username = username;
        _userid = userid;
        _orderId = orderId;
        _nodeId = nodeId;
        _createDt = createDt;
        _latitude = [NSNumber numberWithDouble:coordinate.latitude];
        _longitude = [NSNumber numberWithDouble:coordinate.longitude];
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
            return JYBBCHttpUrl(@"/phone/SafetyInspectNodeResultText!upMessage.action");
            break;
        case JYBIMMessageBodyTypeAudio:
            return JYBBCHttpUrl(@"/phone/SafetyInspectNodeResultPhon!upMessage.action");
            break;
        case JYBIMMessageBodyTypeImage:
            return JYBBCHttpUrl(@"/phone/SafetyInspectNodeResultPhoto!upMessage.action");
            break;
        case JYBIMMessageBodyTypeVideo:
            return JYBBCHttpUrl(@"/phone/SafetyInspectNodeResultVideo!upMessage.action");
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
                     @"nodeId":_nodeId,
                     @"createDt":_createDt,
                     @"lng":_longitude,
                     @"lat":_latitude,
                     @"text":_msg};
            break;
        case JYBIMMessageBodyTypeAudio:
            return @{@"enterpriseCode":_enterpriseCode,
                     @"userId":_userid,
                     @"name":_username,
                     @"orderId":_orderId,
                     @"nodeId":_nodeId,
                     @"fileExtName":JYBIMFileTypeAudio,
                     @"duration":@(_duration),
                     @"createDt":_createDt,
                     @"lng":_longitude,
                     @"lat":_latitude};
            break;
        case JYBIMMessageBodyTypeImage:
            return @{@"enterpriseCode":_enterpriseCode,
                     @"userId":_userid,
                     @"name":_username,
                     @"orderId":_orderId,
                     @"nodeId":_nodeId,
                     @"fileExtName":JYBIMFileExtNameTypeImage,
                     @"createDt":_createDt,
                     @"lng":_longitude,
                     @"lat":_latitude};
            break;
        case JYBIMMessageBodyTypeVideo:
            return @{@"enterpriseCode":_enterpriseCode,
                     @"userId":_userid,
                     @"name":_username,
                     @"orderId":_orderId,
                     @"nodeId":_nodeId,
                     @"fileExtName":JYBIMFileTypeVideo,
                     @"duration":@(_duration),
                     @"createDt":_createDt,
                     @"lng":_longitude,
                     @"lat":_latitude};
            break;
        default:
            return nil;
            break;
    }
    
}
@end
