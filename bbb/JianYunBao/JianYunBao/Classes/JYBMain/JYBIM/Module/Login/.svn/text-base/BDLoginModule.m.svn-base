//
//  BDLoginModule.m
//  BDSocketIM
//
//  Created by 冰点 on 16/2/24.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "BDLoginModule.h"
#import "BDLoginAPI.h"
#import "JYBAppLoginApi.h"
#import "JYBBuildCloudApi.h"
#import "JYBTCPLoginServer.h"
#import "JYBIMServerUserLogin.h"
#import "BDClientState.h"
#import "JYBUserEntity.h"
#import "JYBBuildCloudEntity.h"
#import "RuntimeStatus.h"

@interface BDLoginModule ()
{
    JYBTCPLoginServer *tcpLoginServer;
    JYBIMServerUserLogin *im_UserLogin;
    
    JYBLoginFailure jyb_loginFailure;
    NSString* _lastLoginPassword;
    NSString* _lastLoginUserName;
    NSString* _enterpriseCode;
    
}


@end

@implementation BDLoginModule

+ (instancetype)sharedInstance {
    static BDLoginModule * _someCls = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _someCls = [[BDLoginModule alloc] init];
    });
    return _someCls;
}

- (instancetype)init
{
    if (self = [super init]) {
        tcpLoginServer = [[JYBTCPLoginServer alloc] init];
        im_UserLogin = [[JYBIMServerUserLogin alloc] init];
    }
    return self;
}

#pragma mark - public M

- (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
           enterpriseCode:(NSString *)enterpriseCode
                  success:(void (^)(JYBUserEntity *userEntity))success
                  failure:(void (^)(NSError *))failure
{
    //Step1: Config Build Cloud.
    JYBBuildCloudApi *buildCloudApi = [[JYBBuildCloudApi alloc] initBuildCloudApiWithEnterpriseCode:enterpriseCode];
    [buildCloudApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        DLog(@"❤️❤️❤️BuildCloud❤️❤️❤️");
        if (!request.responseJSONObject) {
            success(nil);return;
        }
        if ([request.responseJSONObject[@"result"] intValue] == 1) {
            JYBBuildCloudEntity *buildCloudEntity = [JYBBuildCloudEntity mj_objectWithKeyValues:request.responseJSONObject];
            //云配置单利模式
            [RuntimeStatus sharedInstance].buildCloudEntity = buildCloudEntity;
            //云配置归档存储
            JYBConfigItem *configItem = [JYBConfigItem mj_objectWithKeyValues:APIJsonObject];
            [JYBConfigTool saveConfig:configItem];
            
            //Step2: Login App.
            JYBAppLoginApi *loginApi = [[JYBAppLoginApi alloc] initAppLoginApiWithUsername:username password:password enterpriseCode:enterpriseCode];
            [loginApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
                DLog(@"❤️❤️❤️APP Login❤️❤️❤️");
                if (!request.responseJSONObject) {
                    success(nil);return;
                }
                if ([request.responseJSONObject[@"result"] intValue] == 1) {
                    JYBUserEntity *userEntity = [JYBUserEntity mj_objectWithKeyValues:request.responseJSONObject];
                    [RuntimeStatus sharedInstance].userEntity = userEntity;
                    //Step3: Connect To Host By Socket.
                    [tcpLoginServer connectToHost:buildCloudEntity.jyb_domain onPort:buildCloudEntity.jyb_port success:^{
                        
                        //Step4: Login IM to online.
                        [im_UserLogin loginIMServerWithUserid:userEntity.userid success:^(id obj) {
                            DLog(@"%@",obj);
                            _lastLoginUserName = username;
                            _lastLoginPassword = password;
                            _enterpriseCode = enterpriseCode;
                            [BDClientState sharedInstance].userState = JYBUserStateOnline;
                            success(userEntity);
                            [BDNotification postNotification:JYBNotificationUserLoginSuccess userInfo:nil object:userEntity];
                        } failure:^(NSError *error) {
                            failure(error);
                        }];
                    } failure:^{
                        [[NSNotificationCenter defaultCenter] postNotificationName:LOGINFAILDNOTIFICATION object:@"建立TCP连接失败！"];
                    }];
                }else{
                    [[NSNotificationCenter defaultCenter] postNotificationName:LOGINFAILDNOTIFICATION object:request.responseJSONObject[@"message"]];
                }
            } failure:^(__kindof YTKBaseRequest *request) {
                DLog(@"%@",request.requestOperation.error);
                [[NSNotificationCenter defaultCenter] postNotificationName:LOGINFAILDNOTIFICATION object:@"网络异常！"];
            }];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        DLog(@"%@",request.requestOperation.error);
        [[NSNotificationCenter defaultCenter] postNotificationName:LOGINFAILDNOTIFICATION object:@"网络异常！"];
    }];
}

- (void)reloginIMTCPServerSuccess:(void (^)())success failure:(void (^)(NSString *))failure
{
    DLog(@"relogin fun");
    if ([BDClientState sharedInstance].userState == JYBUserStateOffline && _lastLoginUserName && _lastLoginPassword && _enterpriseCode) {
        [self loginWithUsername:_lastLoginUserName password:_lastLoginPassword enterpriseCode:_enterpriseCode success:^(id obj) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloginSuccess" object:nil];
            success(YES);
        } failure:^(NSError *error) {
            failure(error.domain);
        }];
    }
}



@end
