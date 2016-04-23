//
//  JYBIChatMessage.h
//  JianYunBao
//  消息模型--属性集合
//  Created by 冰点 on 16/3/10.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYBIMMessage.h"
#import "BDTCPProtocolHeader.h"

@interface JYBIChatMessage : NSObject<NSCopying>

///消息功能码
@property (nonatomic, assign) NSInteger commandID;

///服务器时间戳
@property (nonatomic, assign) NSTimeInterval timestamp;

///聊天消息ID
@property (nonatomic, copy) NSString *messageID;

///发送方id
@property (nonatomic, copy) NSString *fromUserID;

///发送方用户名
@property (nonatomic, copy) NSString *userName;

//对方id、单聊特有，完全可用conversationChatter替代
@property (nonatomic, copy) NSString *toUserID;
//与xxx的会话，单聊即用户id，群聊即群组id，以此类推工单等.....
@property (nonatomic, copy) NSString *conversationChatter;
//@property (nonatomic, copy) NSString *groupID;
//@property (nonatomic, copy) NSString *billID;

@property (nonatomic, copy) NSString *nodeId;

///聊天消息类型
@property (nonatomic, assign) JYBIMMessageBodyType messageBodyType;
@property (nonatomic, assign) JYBIMMessageType messageType;
@property (nonatomic, assign) JYBMessageActionStatus messageActionStatus;

///聊天消息文本内容
@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) NSInteger duration;//语音、视频公用
@property (nonatomic, copy) NSString *remoteUrl;//语音、图片、视频、文件公用

//语音
@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, assign) BOOL isPlayed;

//图片
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) CGSize imageSize;

//视频
@property (nonatomic, copy) NSString *videoThumbnailPath;//视频封面图地址

//语音、视频的本地地址
@property (nonatomic, copy) NSString *localPath;

//文件
@property (nonatomic, assign) NSInteger fileSize;

//暂时没处理
@property (nonatomic, assign) BOOL isRead;//Default NO 未读消息


//头像url
@property (nonatomic, copy) NSString *avatar;

- (id)copyWithZone:(NSZone *)zone;
@end
