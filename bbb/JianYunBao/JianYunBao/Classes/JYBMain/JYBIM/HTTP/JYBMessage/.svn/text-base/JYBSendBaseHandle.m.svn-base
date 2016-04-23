//
//  JYBSendBaseHandle.m
//  BDSocketIM
//
//  Created by 冰点 on 16/2/27.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBSendBaseHandle.h"

@implementation JYBSendBaseHandle
@synthesize enterpriseCode = _enterpriseCode;
@synthesize sendUserId = _sendUserId;
@synthesize sendUserName = _sendUserName;
@synthesize nnewId = _nnewId;
@synthesize groupId = _groupId;
@synthesize orderId = _orderId;
@synthesize nodeId = _nodeId;
@synthesize createDt = _createDt;
@synthesize coordinate = _coordinate;

- (instancetype)initSendMessageWithEnterpriseCode:(NSString *)enterpriseCode userid:(NSString *)userId name:(NSString *)name
{
    if (self = [super init]) {
        _enterpriseCode = enterpriseCode;
        _sendUserId = userId;
        _sendUserName = name;
    }
    return self;
}

- (instancetype)initSendSingleChatMessageWithEnterpriseCode:(NSString *)enterpriseCode userid:(NSString *)userId name:(NSString *)name receiveUserId:(NSString *)receiveUserId
{
    self = [self initSendMessageWithEnterpriseCode:enterpriseCode userid:userId name:name];
    if (self) {
        _receiveUserId = receiveUserId;
    }
    return self;
}

- (instancetype)initSendGroupChatMessageWithEnterpriseCode:(NSString *)enterpriseCode userid:(NSString *)userId name:(NSString *)name groupId:(NSString *)groupId
{
    self = [self initSendMessageWithEnterpriseCode:enterpriseCode userid:userId name:name];
    if (self) {
        _groupId = groupId;
    }
    return self;
}

- (instancetype)initSendBillChatMessageWithEnterpriseCode:(NSString *)enterpriseCode userid:(NSString *)userId name:(NSString *)name orderId:(NSString *)orderId nodeId:(NSString *)nodeId createDt:(NSString *)createDt coordinate:(CLLocationCoordinate2D)coordinate
{
    self = [self initSendMessageWithEnterpriseCode:enterpriseCode userid:userId name:name];
    if (self) {
        _orderId = orderId;
        _nodeId = nodeId;
        _createDt = createDt;
        _coordinate = coordinate;
    }
    return self;
}

- (instancetype)initSendDailyInspectWithEnterpriseCode:(NSString *)enterpriseCode userid:(NSString *)userId name:(NSString *)name orderId:(NSString *)orderId createDt:(NSString *)createDt coordinate:(CLLocationCoordinate2D)coordinate
{
    self = [self initSendMessageWithEnterpriseCode:enterpriseCode userid:userId name:name];
    if (self) {
        _orderId = orderId;
        _createDt = createDt;
        _coordinate = coordinate;
    }
    return self;
}

- (instancetype)initSendNoticeWithEnterpriseCode:(NSString *)enterpriseCode userid:(NSString *)userId name:(NSString *)name newId:(NSString *)newId
{
    self = [self initSendMessageWithEnterpriseCode:enterpriseCode userid:userId name:name];
    if (self) {
        _nnewId = newId;
    }
    return self;
}

#pragma mark - public
- (void)sendText:(NSString *)text success:(void (^)(id message))success failure:(void (^)(NSString *error))failure;
{}

- (void)sendAudio:(NSString *)filePath duration:(NSInteger)duration success:(void (^)(id message))success failure:(void (^)(NSString *error))failure;
{}

- (void)sendImage:(UIImage *)image success:(void (^)(id message))success failure:(void (^)(NSString *error))failure;
{}

- (void)sendVideo:(NSString *)filePath duration:(NSInteger)duration success:(void (^)(id message))success failure:(void (^)(NSString *error))failure;
{}
@end
