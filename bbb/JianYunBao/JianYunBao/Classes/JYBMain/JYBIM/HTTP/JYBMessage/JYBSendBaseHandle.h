//
//  JYBSendBaseHandle.h
//  BDSocketIM
//
//  Created by 冰点 on 16/2/27.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
@import CoreLocation;
#import "BDIMDatabaseUtil.h"
#import "JYBIChatMessage.h"
#import "NSString+BDPath.h"
#import "UIImage+BDVideoThumbnail.h"

@interface JYBSendBaseHandle : NSObject

///初始化发送消息所用到的基本参数
- (instancetype)initSendMessageWithEnterpriseCode:(NSString *)enterpriseCode
                                           userid:(NSString *)userId
                                             name:(NSString *)name;

- (instancetype)initSendSingleChatMessageWithEnterpriseCode:(NSString *)enterpriseCode
                                                     userid:(NSString *)userId
                                                       name:(NSString *)name
                                              receiveUserId:(NSString *)receiveUserId;

- (instancetype)initSendGroupChatMessageWithEnterpriseCode:(NSString *)enterpriseCode
                                                    userid:(NSString *)userId
                                                      name:(NSString *)name
                                                   groupId:(NSString *)groupId;

- (instancetype)initSendBillChatMessageWithEnterpriseCode:(NSString *)enterpriseCode
                                                    userid:(NSString *)userId
                                                      name:(NSString *)name
                                                   orderId:(NSString *)orderId
                                                    nodeId:(NSString *)nodeId
                                                  createDt:(NSString *)createDt
                                                coordinate:(CLLocationCoordinate2D)coordinate;

- (instancetype)initSendDailyInspectWithEnterpriseCode:(NSString *)enterpriseCode
                                                userid:(NSString *)userId
                                                  name:(NSString *)name
                                               orderId:(NSString *)orderId
                                              createDt:(NSString *)createDt
                                            coordinate:(CLLocationCoordinate2D)coordinate;

- (instancetype)initSendNoticeWithEnterpriseCode:(NSString *)enterpriseCode
                                                userid:(NSString *)userId
                                                  name:(NSString *)name
                                                 newId:(NSString *)newId;
//public
@property (nonatomic, readonly, copy) NSString *enterpriseCode;
@property (nonatomic, readonly, copy) NSString *sendUserId;
@property (nonatomic, readonly, copy) NSString *sendUserName;



//single chat
@property (nonatomic, readonly, copy) NSString *receiveUserId;

//group chat
@property (nonatomic, readonly, copy) NSString *groupId;

//bill
@property (nonatomic, readonly, copy) NSString *orderId;
@property (nonatomic, readonly, copy) NSString *nodeId;
@property (nonatomic, readonly, copy) NSString *createDt;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

//notice
@property (nonatomic, readonly, copy) NSString *nnewId;

///Override

///发送文本消息
- (void)sendText:(NSString *)text success:(void (^)(id message))success failure:(void (^)(NSString *error))failure;

///发送音频消息
- (void)sendAudio:(NSString *)filePath duration:(NSInteger)duration success:(void (^)(id message))success failure:(void (^)(NSString *error))failure;

///发送图片消息
- (void)sendImage:(UIImage *)image success:(void (^)(id message))success failure:(void (^)(NSString *error))failure;

///发送视频消息
- (void)sendVideo:(NSString *)filePath duration:(NSInteger)duration success:(void (^)(id message))success failure:(void (^)(NSString *error))failure;

@end
