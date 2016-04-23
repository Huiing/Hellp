//
//  JYBMessageEntity.h
//  BDSocketIM
//
//  Created by 冰点 on 16/2/29.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYBIMMessage.h"
#import "BDTCPProtocolHeader.h"

@interface JYBMessageEntity : NSObject

- (instancetype)initWithMessage:(JYBIMMessage *)message;

@property (nonatomic, readonly) JYBIMMessage *message;
/*!
 *  @brief 消息功能码
 */
@property (nonatomic, assign) int commandID;

/*!
 *  @brief 服务器时间戳
 */
@property (nonatomic, assign) NSTimeInterval timestamp;

@end
