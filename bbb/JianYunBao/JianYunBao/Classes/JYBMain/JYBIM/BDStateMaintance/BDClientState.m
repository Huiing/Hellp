//
//  BDClientState.m
//  BDSocketIM
//
//  Created by 冰点 on 16/2/22.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "BDClientState.h"
#import "DDReachability.h"

NSString *const kJYBUserState    = @"userState";
NSString *const kJYBNetworkState = @"networkState";
NSString *const kJYBSocketState  = @"socketState";
NSString *const kJYBUserID       = @"userid";

@interface BDClientState ()

@end

@implementation BDClientState

+ (instancetype)sharedInstance {
    static BDClientState * _clientState = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _clientState = [[BDClientState alloc] init];
    });
    return _clientState;
}

- (instancetype)init
{
    if (self = [super init]) {
        _userState = JYBUserStateOffline;
        _socketState = BDSocketStateDisconnect;
        _reachability = [DDReachability reachabilityForInternetConnection];
        [_reachability startNotifier];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(n_receiveReachabilityChangedNotification:)
                                                     name:kDDReachabilityChangedNotification
                                                   object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)n_receiveReachabilityChangedNotification:(NSNotification*)notification
{
    DDReachability *reach = [notification object];
    NetworkStatus networkStatus = [reach currentReachabilityStatus];
    switch (networkStatus) {
        case NotReachable:
            self.networkState = JYBNetworkStateNone;
            break;
        case ReachableViaWiFi:
            self.networkState = JYBNetworkStateWIFI;
            break;
        case ReachableViaWWAN:
            self.networkState = JYBNetworkState3G;
            break;
        default:
            break;
    }
}
@end
