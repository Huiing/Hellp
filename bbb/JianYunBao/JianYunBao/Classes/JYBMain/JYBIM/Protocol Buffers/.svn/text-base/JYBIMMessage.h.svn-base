//
//  JYBIMMessage.h
//  BDSocketIM
//
//  Created by 冰点 on 16/2/29.
//  Copyright © 2016年 冰点. All rights reserved.
//  解析数据的类
//

#import <Foundation/Foundation.h>

@interface JYBIMMessage : NSObject

+ (JYBIMMessage *)parseFromData:(NSData *)data commandID:(int)commandID;

@property (nonatomic, assign) int commandID;
//企业白板
@property (nonatomic, readonly, copy) NSString *messageID;
@property (nonatomic, readonly, copy) NSString *fromUserID;
@property (nonatomic, readonly, copy) NSString *userName;
@property (nonatomic, readonly, assign) NSTimeInterval timestamp;

@property (nonatomic, readonly, copy) NSString *content;
@property (nonatomic, readonly, assign) int duration;//文件时长
@property (nonatomic, readonly, copy) NSString *fileURL;//文件路径
@property (nonatomic, readonly, assign) int fileSize;

//单聊
@property (nonatomic, readonly, copy) NSString *toUserID;
//组id-群、工单、质量检测单、安全检测单、日常巡查单
@property (nonatomic, readonly, copy) NSString *groupID;

@property (nonatomic, readonly, copy) NSString *nodeId;

//群聊
//@property (nonatomic, readonly, copy) NSString *groupID;

//工单
//@property (nonatomic, readonly, copy) NSString *billID;

//质量检测单
//安全检测单
//日常巡查单

@end
