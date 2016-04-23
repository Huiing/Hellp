//
//  JYBTCPLoginServer.m
//  BDSocketIM
//
//  Created by 冰点 on 16/2/24.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBTCPLoginServer.h"
#import "BDSocketManager.h"

static NSInteger timeoutInterval = 10;

@interface JYBTCPLoginServer ()
{
    JYBClientSuccess jyb_clientSuccess;
    JYBClientFailure jyb_clientFailure;
    BOOL _connecting;//正在连接中...
    NSUInteger _connectTimes;//链接次数
}

- (void)receiveTcpLinkConnectSuccessNotification:(NSNotification*)notification;
- (void)receiveTcpLinkConnectFailureNotification:(NSNotification*)notification;

@end

@implementation JYBTCPLoginServer

- (instancetype)init
{
    if (self = [super init]) {
        _connecting = NO;
        _connectTimes = 0;
        [self registerConnectTCPSocketResponsedNotification];
    }
    return self;
}

- (void)registerConnectTCPSocketResponsedNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTcpLinkConnectSuccessNotification:)
                                                 name:JYBNotificationTcpLinkConnectComplete
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTcpLinkConnectFailureNotification:)
                                                 name:JYBNotificationTcpLinkConnectFailure
                                               object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:JYBNotificationTcpLinkConnectComplete object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:JYBNotificationTcpLinkConnectFailure object:nil];
}

- (void)connectToHost:(NSString *)host onPort:(NSInteger)port success:(void (^)())success failure:(void (^)())failure
{
    if (!_connecting) {
        _connectTimes ++;
        _connecting = YES;
        jyb_clientSuccess = [success copy];
        jyb_clientFailure = [failure copy];
        [[BDSocketManager sharedInstance] disconnect];
        [[BDSocketManager sharedInstance] connectToHost:host onPort:port error:nil];
        //超时处理
        NSUInteger nowTimes = _connectTimes;
        double delayInSeconds = timeoutInterval;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if (_connecting && nowTimes == _connectTimes)
            {
                _connecting = NO;
                jyb_clientFailure(nil);
            }
        });
    }
}

#pragma mark - notification
- (void)receiveTcpLinkConnectSuccessNotification:(NSNotification *)notification
{
    if (_connecting) {
        _connecting = NO;
        dispatch_async(dispatch_get_main_queue(), ^{
            jyb_clientSuccess();
        });
    }
}

- (void)receiveTcpLinkConnectFailureNotification:(NSNotification *)notification
{
    if (_connecting) {
        _connecting = NO;
        dispatch_async(dispatch_get_main_queue(), ^{
            jyb_clientFailure(JYBError(@"tcp连接建立失败"));
        });
    }
}

@end
