//
//  JYBIMGetWhiteboardMessageApi.m
//  BDSocketIM
//
//  Created by 冰点 on 16/2/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBIMGetWhiteboardMessageApi.h"

@implementation JYBIMGetWhiteboardMessageApi
{
    NSString *_enterpriseCode;
    NSString *_lastMsgId;
}

- (instancetype)initGetWhiteboardMessageWithLastMsgId:(NSString *)lastMsgId
{
    self = [super init];
    if (self) {
        _enterpriseCode = [RuntimeStatus sharedInstance].buildCloudEntity.enterpriseCode;
        _lastMsgId = lastMsgId;
    }
    return self;
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

- (NSString *)requestUrl
{
    return JYBBCHttpUrl(@"/phone/Whiteboard!getSome.action");
}

- (id)requestArgument
{
    return @{@"enterpriseCode":_enterpriseCode, @"lateId":_lastMsgId};
}

@end
