//
//  JYBIMServerUserLogin.h
//  BDSocketIM
//
//  Created by 冰点 on 16/2/24.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYBIMServerUserLogin : NSObject

/*!
 *  @brief TCP IM 上线登录
 *  功能码 1000 `BD_TCP_PROTOCOL_CODE_LOGIN`
 *  @param userid  用户id
 *  @param success success block
 *  @param failure failure block
 */
- (void)loginIMServerWithUserid:(NSString *)userid
                        success:(void(^)(id obj))success
                        failure:(void(^)(NSError *error))failure;


@end
