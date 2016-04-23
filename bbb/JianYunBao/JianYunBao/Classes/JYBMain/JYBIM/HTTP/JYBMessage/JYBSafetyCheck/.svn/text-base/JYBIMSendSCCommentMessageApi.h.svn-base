//
//  JYBIMSendSCCommentMessageApi.h
//  BDSocketIM
//
//  Created by 冰点 on 16/2/27.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <YTKNetwork/YTKRequest.h>

@interface JYBIMSendSCCommentMessageApi : YTKRequest

//@brief required
@property (nonatomic, copy  ) NSString  *msg;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, strong) NSData    *file;
@property (nonatomic, assign) JYBIMMessageBodyType type;

/*!
 *  @brief 发送安全检查单评论消息
 *
 *  @param enterpriseCode 企业号
 *  @param username       from_name
 *  @param userid         from_id
 *  @param orderId        工单id
 *
 *  @return `JYBIMSendSCCommentMessageApi`
 */
- (instancetype)initSafetyCheckCommentApiWithEnterpriseCode:(NSString *)enterpriseCode
                                                   userName:(NSString *)username
                                                     userid:(NSString *)userid
                                                    orderId:(NSString *)orderId;

@end
