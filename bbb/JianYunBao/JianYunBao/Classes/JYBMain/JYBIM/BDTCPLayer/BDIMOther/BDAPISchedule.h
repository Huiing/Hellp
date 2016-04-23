//
//  BDAPISchedule.h
//  BDSocketIM
//
//  Created by 冰点 on 16/2/23.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDAPIScheduleProtocol.h"
#import "BDAPIUnrequestScheduleProtocol.h"


typedef struct Response_Server_Data_Head {
    int commandID;
}ServerDataType;

NS_INLINE ServerDataType DDMakeServerDataType(int commendID)
{
    ServerDataType type;
    type.commandID = commendID;
    return type;
}


@interface BDAPISchedule : NSObject

@property (nonatomic, readonly) dispatch_queue_t apiScheduleQueue;

+ (instancetype)sharedInstance;

/*!
 *  @brief 注册接口，此接口只应该在DDSuperAPI中被使用
 *
 *  @param api 接口
 *
 *  @return 注册接口状态
 */
- (BOOL)registerApi:(id<BDAPIScheduleProtocol>)api;

/*!
 *  @brief 注册超时的查询表，此接口只应该在DDSuperAPI中被使用
 *
 *  @param api 接口
 */
- (void)registerTimeoutApi:(id<BDAPIScheduleProtocol>)api;

/*!
 *  @brief 接收到服务器端的数据进行解析，对外的接口
 *
 *  @param data 服务器端的数据
 */
- (void)receiveServerData:(NSData *)data forDataType:(ServerDataType)dataType;

/*!
 *  @brief 注册没有请求，只有返回的api
 *
 *  @param api
 */
- (BOOL)registerUnrequestApi:(id<BDAPIUnrequestScheduleProtocol>)api;

/*!
 *  @brief 发送数据包
 *
 *  @param data 数据包
 */
- (void)sendData:(NSMutableData *)data;
@end
