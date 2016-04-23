//
//  BDIMSendWhiteboardTextApi.m
//  IMDemo
//
//  Created by 冰点 on 16/1/29.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <YTKNetwork/YTKRequest.h>


@interface JYBIMSendWhiteboardMessageApi : YTKRequest

//@brief required
@property (nonatomic, copy  ) NSString  *msg;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, strong) NSData    *file;
@property (nonatomic, assign) JYBIMMessageBodyType type;

/*!
 *  @brief 发送企业白板消息
 *
 *  @param enterpriseCode 企业号
 *  @param username       from_name
 *  @param userid         from_id
 *
 *  @return `JYBIMSendWhiteboardMessageApi`
 */
- (instancetype)initWhiteboardApiWithEnterpriseCode:(NSString *)enterpriseCode
                                           username:(NSString *)username
                                             userid:(NSString *)userid;


@end
