//
//  JYBTCPLoginServer.h
//  BDSocketIM
//
//  Created by 冰点 on 16/2/24.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^JYBClientSuccess)();
typedef void(^JYBClientFailure)(NSError* error);

@interface JYBTCPLoginServer : NSObject

/*!
 *  @brief 链接TCP Socket 服务器
 *
 *  @param host    IP
 *  @param port    端口
 *  @param success success block
 *  @param failure failure block
 */
- (void)connectToHost:(NSString *)host onPort:(NSInteger)port success:(void(^)())success failure:(void(^)())failure;

@end
