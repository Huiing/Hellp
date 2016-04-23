//
//  JYBChatGroupManager.h
//  BDSocketIM
//
//  Created by 冰点 on 16/2/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYBSendBaseHandle.h"

@class JYBIMSendGroupChatMessageApi;
@interface JYBChatGroupHandle : JYBSendBaseHandle

///发送文本消息
- (void)sendText:(NSString *)text success:(void (^)(id message))success failure:(void (^)(NSString *error))failure;

///发送音频消息
- (void)sendAudio:(NSString *)filePath duration:(NSInteger)duration success:(void (^)(id message))success failure:(void (^)(NSString *error))failure;

///发送图片消息
- (void)sendImage:(UIImage *)image success:(void (^)(id message))success failure:(void (^)(NSString *error))failure;

///发送视频消息
- (void)sendVideo:(NSString *)filePath duration:(NSInteger)duration success:(void (^)(id message))success failure:(void (^)(NSString *error))failure;

@end
