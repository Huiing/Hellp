//
//  JYBIMSendQCNodeMessageApi.h
//  BDSocketIM
//
//  Created by 冰点 on 16/2/27.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <YTKNetwork/YTKRequest.h>
@import CoreLocation;

@interface JYBIMSendQCNodeMessageApi : YTKRequest

//@brief required
@property (nonatomic, copy  ) NSString  *msg;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, strong) NSData    *file;
@property (nonatomic, assign) JYBIMMessageBodyType type;

/*!
 *  @brief 发送质量检查单节点消息
 *
 *  @param enterpriseCode 企业号
 *  @param username       from_name
 *  @param userid         from_id
 *  @param orderId        工单id
 *  @param nodeId         节点id
 *  @param createDt       数据产生日期时间
 *  @param coordinate     经纬度
 *
 *  @return `JYBIMSendQCNodeMessageApi`
 */
- (instancetype)initQualityCheckNoteApiWithEnterpriseCode:(NSString *)enterpriseCode
                                                 userName:(NSString *)username
                                                   userid:(NSString *)userid
                                                  orderId:(NSString *)orderId
                                                   nodeId:(NSString *)nodeId
                                                 createDt:(NSString *)createDt
                                               coordinate:(CLLocationCoordinate2D)coordinate;

@end
