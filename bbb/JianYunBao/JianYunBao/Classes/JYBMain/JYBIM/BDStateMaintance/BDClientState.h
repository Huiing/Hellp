//
//  BDClientState.h
//  BDSocketIM
//
//  Created by 冰点 on 16/2/22.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>

///用户状态
typedef NS_ENUM(NSUInteger, JYBUserState) {
    JYBUserStateOnline = 0,     //用户在线
    JYBUserStateKickout,  //用户被挤下线
    JYBUserStateOffline,    //用户离线
    JYBUserStateOfflineInitiative,  //用户主动下线
    JYBUserStateLogining    //用户正在登陆
};

typedef NS_ENUM(NSUInteger, JYBNetworkState) {
    JYBNetworkStateWIFI,
    JYBNetworkState3G,
    JYBNetworkState2G,
    JYBNetworkStateNone //无网
};

typedef NS_ENUM(NSUInteger, BDSocketState) {
    BDSocketStateLinkTCPServer, //连接TCP服务器
    BDSocketStateDisconnect //断开连接
};


extern NSString *const kJYBUserState;
extern NSString *const kJYBNetworkState;
extern NSString *const kJYBSocketState;
extern NSString *const kJYBUserID;

@class DDReachability;
@interface BDClientState : NSObject
{
    DDReachability *_reachability;
}

+ (instancetype)sharedInstance;

/*!
 *  @brief 当前用户的状态
 */
@property (nonatomic, assign) JYBUserState userState;

/*!
 *  @brief 网络状态
 */
@property (nonatomic, assign) JYBNetworkState networkState;

/*!
 *  @brief Socket连接状态
 */
@property (nonatomic, assign) BDSocketState socketState;

///当前登录用户的ID
@property (nonatomic, readonly) NSString *userid;


@end
