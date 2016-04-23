//
//  JYBWhiteBoardModel.h
//  JianYunBao
//
//  Created by 冰点 on 16/3/18.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYBIChatMessage.h"

@interface JYBWhiteBoardModel : NSObject

@property (nonatomic, copy) NSString *messageId;

@property (nonatomic, assign) BOOL isDocument;

///字节数组转成的字符串数据
@property (nonatomic, copy) NSString *textStr;

///数据产生时间
@property (nonatomic, copy) NSString *dt;

@property (nonatomic, copy) NSString *documentPath;

///是否为图片
@property (nonatomic, assign) BOOL isPhoto;

@property (nonatomic, copy) NSString *enterpriseCode;

///录音文件存储相对路径
@property (nonatomic, copy) NSString *phonPath;

///图片存储相对路径
@property (nonatomic, copy) NSString *photoPath;

///录像时长
@property (nonatomic, assign) NSInteger videoDuration;

///是否为录像
@property (nonatomic, assign) BOOL isVideo;

///录像文件存储相对路径
@property (nonatomic, copy) NSString *videoPath;

///上传消息用户ID
@property (nonatomic, copy) NSString *userId;

@property (nonatomic, assign) NSInteger documentSize;

///录音时长
@property (nonatomic, assign) NSInteger phonDuration;

///数据产生时间
@property (nonatomic, assign) long long dtLong;

///上传消息用户姓名
@property (nonatomic, copy) NSString *name;

///是否为录音
@property (nonatomic, assign) BOOL isPhon;

// `JYBWhiteBoardModel`->>`JYBIChatMessage`
+ (JYBIChatMessage *)parseFromModel:(JYBWhiteBoardModel *)model;

@end
