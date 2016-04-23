//
//  BDAPIScheduleProtocol.h
//  BDSocketIM
//
//  Created by 冰点 on 16/2/23.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id(^BDAnalysis)(NSData *data);
typedef NSMutableData *(^BDPackage)(id obj);

@protocol BDAPIScheduleProtocol <NSObject>
@required

/*!
 *  @brief 请求超时时间
 *
 *  @return 超时时间
 */
- (int)requestTimeOutTimeInterval;

- (int)requstCommendID;
- (int)responseCommendID;

/*!
 *  @brief 解析数据的block
 *
 *  @return 解析数据的block
 */
- (BDAnalysis)analysisReturnData;

/*!
 *  @brief 打包数据的block
 *
 *  @return 打包数据的block
 */
- (BDPackage)packageRequestObject;
@end
