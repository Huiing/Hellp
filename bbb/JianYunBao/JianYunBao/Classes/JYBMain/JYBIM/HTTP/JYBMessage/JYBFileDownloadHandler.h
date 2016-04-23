//
//  JYBFileDownloadManager.h
//  JianYunBao
//
//  Created by 冰点 on 16/3/18.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JYBIChatMessage;
@interface JYBFileDownloadHandler : NSObject

+ (NSString *)downloadAudioWithAudioPath:(NSString *)audioPath finished:(void(^)(NSString *localPath))finished;
+ (NSString *)downloadAudioWithIChatMessage:(JYBIChatMessage *)msg finished:(void(^)(NSString *localPath))finished;

+ (void)downloadImageWithIChatMessage:(JYBIChatMessage *)msg finished:(void(^)(UIImage *image, CGSize size))finished;

+ (void)downloadVideoDataWithIChatMessage:(JYBIChatMessage *)msg finished:(void(^)(NSString *localPath, NSString *videoThumbnailPath, UIImage *image))finished;

@end
