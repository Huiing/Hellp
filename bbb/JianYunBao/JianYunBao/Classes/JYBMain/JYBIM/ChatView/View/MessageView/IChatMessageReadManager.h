//
//  IChatMessageReadManager.h
//  JianYunBao
//
//  Created by 冰点 on 16/3/6.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYBIChatMessage.h"
#import <MWPhotoBrowser/MWPhotoBrowser.h>

typedef void (^FinishBlock)(BOOL success);
typedef void (^PlayBlock)(BOOL playing, JYBIChatMessage *messageModel);

@interface IChatMessageReadManager : NSObject<MWPhotoBrowserDelegate>

@property (strong, nonatomic) MWPhotoBrowser *photoBrowser;

@property (strong, nonatomic) FinishBlock finishBlock;

@property (strong, nonatomic) JYBIChatMessage *audioMessageModel;

+ (id)defaultManager;

- (void)showBrowserWithImages:(NSArray *)imageArray;

/**
 *  准备播放语音文件
 *
 *  @param messageModel     要播放的语音文件
 *  @param updateCompletion 需要更新model所在的Cell
 *
 *  @return 若返回NO，则不需要调用播放方法
 *
 */
- (BOOL)prepareMessageAudioModel:(JYBIChatMessage *)messageModel
            updateViewCompletion:(void (^)(JYBIChatMessage *prevAudioModel, JYBIChatMessage *currentAudioModel))updateCompletion;
- (JYBIChatMessage *)stopMessageAudioModel;
@end
