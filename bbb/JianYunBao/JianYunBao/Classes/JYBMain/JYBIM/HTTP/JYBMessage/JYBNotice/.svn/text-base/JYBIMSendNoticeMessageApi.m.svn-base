//
//  JYBIMSendNoticeMessageApi.m
//  JianYunBao
//
//  Created by 冰点 on 16/3/17.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBIMSendNoticeMessageApi.h"

@implementation JYBIMSendNoticeMessageApi
{
    NSString *_enterpriseCode;
    NSString *_username;
    NSString *_userid;
    NSString *_newsId;
}

- (instancetype)initNoticeApiWithEnterpriseCode:(NSString *)enterpriseCode userName:(NSString *)username userid:(NSString *)userid newsId:(NSString *)newsId
{
    if (self = [super init]) {
        _enterpriseCode = enterpriseCode;
        _username = username;
        _userid = userid;
        _newsId = newsId;
    }
    return self;
}

- (NSString *)requestUrl
{
    return JYBBCHttpUrl(@"/phone/NoticeDiscussText!upMessage.action");
}

- (id)requestArgument
{
    return @{
             @"enterpriseCode":_enterpriseCode,
             @"userId":_userid,
             @"name":_username,
             @"newsId":_newsId,
             @"text":_msg
             };
}
@end
