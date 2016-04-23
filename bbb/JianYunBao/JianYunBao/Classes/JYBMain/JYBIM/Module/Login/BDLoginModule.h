//
//  BDLoginModule.h
//  BDSocketIM
//
//  Created by 冰点 on 16/2/24.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^JYBLoginFailure)(NSError* error);
@class JYBTCPLoginServer, JYBIMServerUserLogin, JYBUserEntity, JYBBuildCloudEntity;
@interface BDLoginModule : NSObject 

+ (instancetype)sharedInstance;

/*!
 *  @brief APP登录操作
 *
 *  @param username       用户名
 *  @param password       密码
 *  @param enterpriseCode 企业号
 *  @param success        成功block
 *  @param failure        失败block
 */
- (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
           enterpriseCode:(NSString *)enterpriseCode
                  success:(void(^)(JYBUserEntity *userEntity))success
                  failure:(void(^)(NSError *error))failure;

/*!
 *  @brief 重新登录IM
 *
 *  @param success success block
 *  @param failure failure block
 */
- (void)reloginIMTCPServerSuccess:(void(^)())success failure:(void(^)(NSString *error))failure;
@end
