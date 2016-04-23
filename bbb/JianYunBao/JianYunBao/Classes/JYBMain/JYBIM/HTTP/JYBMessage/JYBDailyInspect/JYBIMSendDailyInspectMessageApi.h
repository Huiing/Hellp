//
//  JYBIMSendDailyInspectMessageApi.h
//  BDSocketIM
//
//  Created by 冰点 on 16/2/27.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <YTKNetwork/YTKRequest.h>
@import CoreLocation;

@interface JYBIMSendDailyInspectMessageApi : YTKRequest

//@brief required
@property (nonatomic, copy  ) NSString  *msg;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, strong) NSData    *file;
@property (nonatomic, assign) JYBIMMessageBodyType type;

/*!
 *  @brief 发送日常巡查消息
 *
 *  @param enterpriseCode 企业号
 *  @param username       from_name
 *  @param userid         from_id
 *  @param orderId        工单id
 *  @param createDt       数据产生日期时间
 *  @param coordinate     经纬度
 *
 *  @return `JYBIMSendDailyInspectMessageApi`
 */
- (instancetype)initDailyInspectApiWithEnterpriseCode:(NSString *)enterpriseCode
                                             userName:(NSString *)username
                                               userid:(NSString *)userid
                                              orderId:(NSString *)orderId
                                             createDt:(NSString *)createDt
                                           coordinate:(CLLocationCoordinate2D)coordinate;

@end
