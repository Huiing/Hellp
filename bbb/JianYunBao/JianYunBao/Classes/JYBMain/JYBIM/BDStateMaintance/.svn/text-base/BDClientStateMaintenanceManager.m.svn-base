//
//  BDClientStateMaintenanceManager.m
//  BDSocketIM
//
//  Created by 冰点 on 16/2/22.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "BDClientStateMaintenanceManager.h"
#import "BDClientState.h"
#import "BDHeartBeatAPI.h"
#import "BDLoginModule.h"

static NSInteger const heartBeatTimeinterval = 30;
//static NSInteger const serverHeartBeatTimeinterval = 60;
static NSInteger const reloginTimeinterval = 5;

@interface BDClientStateMaintenanceManager ()
{
    NSTimer *_sendHeartBeatTimer;
    NSTimer *_reloginTimer;
    NSTimer *_serverHeartBeatTimer;
    
    BOOL _receiveServerHeart;
    NSUInteger _reloginInterval;
}

//注册KVO
- (void)registerClientStateObserver;

//检验服务器端的心跳
//- (void)startCheckServerHeartBeat;
//- (void)stopCheckServerHeartBeat;
//- (void)onCheckServerHeartBeatTimer:(NSTimer *)timer;
//- (void)receiveServerHeartBeat;

//客户端心跳
- (void)onSendHeartBeatTimer:(NSTimer *)timer;

//断线重连
- (void)startRelogin;
- (void)onReloginTimer:(NSTimer *)timer;


@end

@implementation BDClientStateMaintenanceManager

+ (instancetype)sharedInstance {
    static BDClientStateMaintenanceManager * _clientStateMaintenanceManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _clientStateMaintenanceManager = [[BDClientStateMaintenanceManager alloc] init];
    });
    return _clientStateMaintenanceManager;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self registerClientStateObserver];
        //对服务端的心跳包监听
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveServerHeartBeat) name:JYBNotificationServerHeartBeat object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[BDClientState sharedInstance] removeObserver:self forKeyPath:kJYBNetworkState];
    [[BDClientState sharedInstance] removeObserver:self forKeyPath:kJYBUserState];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:JYBNotificationServerHeartBeat object:nil];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    BDClientState *clientState = [BDClientState sharedInstance];
    //网络状态的变化
    if ([keyPath isEqualToString:kJYBNetworkState]) {
        if (clientState.networkState != JYBNetworkStateNone)
        {
            
            BOOL shouldRelogin = !_reloginTimer && ![_reloginTimer isValid] && clientState.userState != JYBUserStateOnline && clientState.userState != JYBUserStateOfflineInitiative && clientState.userState != JYBUserStateKickout;
            
            if (shouldRelogin)
            {
                DLog(@"进入重连");
                [self startRelogin];
                _reloginInterval = 0;
            }
        } else {
            clientState.userState = JYBUserStateOffline;
            DLog(@"连接失败");
        }
    }
    
    //用户状态的变化
    if ([keyPath isEqualToString:kJYBUserState]) {
        DLog(@"clientState.userState: %lu",(unsigned long)clientState.userState);
        //order: 0 -> 2 -> 0
        switch (clientState.userState)
        {
            case JYBUserStateKickout:
                DLog(@"未连接");
                [self stopRelogin];
                [self stopHeartBeat];
                [[BDSocketManager sharedInstance] disconnect];
                break;
            case JYBUserStateOffline:
                DLog(@"未连接");
//                [self stopCheckServerHeartBeat];
                [self stopHeartBeat];
                [self startRelogin];
                break;
            case JYBUserStateOfflineInitiative:
                DLog(@"未连接");
//                [self stopCheckServerHeartBeat];
                [self stopHeartBeat];
                break;
            case JYBUserStateOnline:
//                [self startCheckServerHeartBeat];
                [self stopRelogin];
                [self startHeartBeat];
                break;
            case JYBUserStateLogining:
                DLog(@"登录中");
                break;
        }
    }
}

#pragma mark - private M
- (void)registerClientStateObserver
{
    //网络状态
    [[BDClientState sharedInstance] addObserver:self
                                     forKeyPath:kJYBNetworkState
                                        options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                                        context:nil];
    //用户状态
    [[BDClientState sharedInstance] addObserver:self
                                     forKeyPath:kJYBUserState
                                        options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                                        context:nil];
}

/*!
 *  @brief 开启发送心跳的Timer
 */
- (void)startHeartBeat
{
    DLog(@"begin heart beat");
    if (!_sendHeartBeatTimer && ![_sendHeartBeatTimer isValid]) {
        _sendHeartBeatTimer = [NSTimer scheduledTimerWithTimeInterval:heartBeatTimeinterval target:self selector:@selector(onSendHeartBeatTimer:) userInfo:nil repeats:YES];
    }
}

/*!
 *  @brief 关闭发送心跳的Timer
 */
- (void)stopHeartBeat
{
    if (_sendHeartBeatTimer)
    {
        [_sendHeartBeatTimer invalidate];
        _sendHeartBeatTimer = nil;
    }
}

/*!
 *  @brief 开启检验服务器心跳的Timer
 */
//- (void)startCheckServerHeartBeat
//{
//    DLog(@"begin maintenance _serverHeartBeatTimer");
//    if (!_serverHeartBeatTimer) {
//        _serverHeartBeatTimer = [NSTimer scheduledTimerWithTimeInterval:serverHeartBeatTimeinterval target:self selector:@selector(onCheckServerHeartBeatTimer:) userInfo:nil repeats:YES];
//        [_serverHeartBeatTimer fire];
//    }
//}

/*!
 *  @brief 关闭检验服务器心跳的Timer
 */
//- (void)stopCheckServerHeartBeat
//{
//    if (_serverHeartBeatTimer) {
//        [_serverHeartBeatTimer invalidate];
//        _serverHeartBeatTimer = nil;
//    }
//}

//开启重连Timer
- (void)startRelogin
{
    if (!_reloginTimer) {
        _reloginTimer = [NSTimer scheduledTimerWithTimeInterval:reloginTimeinterval target:self selector:@selector(onReloginTimer:) userInfo:nil repeats:YES];
        [_reloginTimer fire];
    }
}

- (void)stopRelogin
{
    if (_reloginTimer) {
        [_reloginTimer invalidate];
        _reloginTimer = nil;
    }
}

//运行在发送心跳的Timer上
- (void)onSendHeartBeatTimer:(NSTimer *)timer
{
    DLog(@" ***❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️***");
    BDHeartBeatAPI *heartBeat = [[BDHeartBeatAPI alloc] init];
    [heartBeat requestWithObject:nil completion:nil];
    
}

//收到服务器端的数据包
//- (void)receiveServerHeartBeat
//{
//    _receiveServerHeart = YES;
//}

//运行在检验服务器端心跳的Timer上
//- (void)onCheckServerHeartBeatTimer:(NSTimer *)timer
//{
//    if (_receiveServerHeart)
//    {
//        _receiveServerHeart = NO;
//    }
//    else
//    {
//        [_serverHeartBeatTimer invalidate];
//        _serverHeartBeatTimer = nil;
//        DLog(@"太久没收到服务器端数据包了~");
//        [BDClientState sharedInstance].userState = JYBUserStateOffline;
//    }
//}

//运行在断线重连的Timer上
- (void)onReloginTimer:(NSTimer *)timer
{
    static NSUInteger time = 0;
    static NSUInteger powN = 0;
    time++;
    if (time >= _reloginInterval) {
        //reLogin api
        [[BDLoginModule sharedInstance] reloginIMTCPServerSuccess:^{
            DLog(@"relogin success");
            [_reloginTimer invalidate];
            _reloginTimer = nil;
            time = 0;
            _reloginInterval = 0;
            powN = 0;
            [BDNotification postNotification:JYBNotificationUserReloginSuccess userInfo:nil object:nil];
        } failure:^(NSString *error) {
            DLog(@"relogin failure:%@",error);
            if ([error isEqualToString:@"网络异常"]) {
                [_reloginTimer invalidate];
                _reloginTimer = nil;
                time = 0;
                _reloginInterval = 0;
                powN = 0;
            } else {
                DLog(@"未连接");
                powN++;
                time = 0;
                _reloginInterval = pow(2, powN);
            }
        }];
    }
}

@end

