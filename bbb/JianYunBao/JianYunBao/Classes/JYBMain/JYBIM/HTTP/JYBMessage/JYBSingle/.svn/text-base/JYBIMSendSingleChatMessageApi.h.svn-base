//
//  JYBIMSendSingleChatMessageApi.h
//  BDSocketIM
//
//  Created by 冰点 on 16/2/27.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <YTKNetwork/YTKRequest.h>

@interface JYBIMSendSingleChatMessageApi : YTKRequest

//@brief required
@property (nonatomic, copy  ) NSString  *msg;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, strong) NSData    *file;
@property (nonatomic, assign) JYBIMMessageBodyType type;

/*!
 *  @brief 发送单聊消息
 *
 *  @param enterpriseCode     企业号
 *  @param sendUserName       from_name
 *  @param sendUserId         from_id
 *  @param receiveUserId      to_id
 *
 *  @return `JYBIMSendSingleChatMessageApi`
 */
- (instancetype)initSingleChatApiWithEnterpriseCode:(NSString *)enterpriseCode
                                       sendUserName:(NSString *)sendUserName
                                         sendUserId:(NSString *)sendUserId
                                      receiveUserId:(NSString *)receiveUserId;

@end
