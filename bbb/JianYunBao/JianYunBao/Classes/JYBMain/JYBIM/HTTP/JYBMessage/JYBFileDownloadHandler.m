//
//  JYBFileDownloadManager.m
//  JianYunBao
//
//  Created by 冰点 on 16/3/18.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBFileDownloadHandler.h"
#import "JYBDownloadFileApi.h"
#import "NSString+BDPath.h"
#import "UIImage+BDVideoThumbnail.h"
#import "JYBIChatMessage.h"

@implementation JYBFileDownloadHandler


+ (NSString *)downloadAudioWithAudioPath:(NSString *)audioPath finished:(void(^)(NSString *localPath))finished
{
  __block NSString *_audioLocalPath = nil;
  @autoreleasepool {
    JYBDownloadFileApi *api = [[JYBDownloadFileApi alloc] initWithDownloadFileUrl:audioPath type:JYBDownloadFileTypeMP3];
    //下载音频流
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
      DLog(@"%@",request.responseJSONObject);
      NSString * localPath = [NSString handleInterceptLibraryResourcePath:request.responseJSONObject];
      _audioLocalPath = localPath;
      finished(localPath);
    } failure:^(__kindof YTKBaseRequest *request) {
      DLog(@"%@",request.requestOperation.error);
    }];
    return _audioLocalPath;
  }

}

+ (NSString *)downloadAudioWithIChatMessage:(JYBIChatMessage *)msg finished:(void(^)(NSString *localPath))finished
{
    __block NSString *_audioLocalPath = nil;
    @autoreleasepool {
        JYBDownloadFileApi *api = [[JYBDownloadFileApi alloc] initWithDownloadFileUrl:JYBBcfHttpUrl(msg.remoteUrl) type:JYBDownloadFileTypeMP3];
        //下载音频流
        [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
            DLog(@"%@",request.responseJSONObject);
            NSString * localPath = [NSString handleInterceptLibraryResourcePath:request.responseJSONObject];
            _audioLocalPath = localPath;
            finished(localPath);
        } failure:^(__kindof YTKBaseRequest *request) {
            DLog(@"%@",request.requestOperation.error);
        }];
        return _audioLocalPath;
    }
}

+ (void)downloadImageWithIChatMessage:(JYBIChatMessage *)msg finished:(void(^)(UIImage *image, CGSize size))finished
{
    @autoreleasepool {
        NSURL * url = [NSURL URLWithString:JYBImageUrl(msg.remoteUrl)];
        UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        //获取图片大小
        [imgView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            imgView.image = image;
            finished(image, image.size);
        }];
    }
}

+ (void)downloadVideoDataWithIChatMessage:(JYBIChatMessage *)msg finished:(void(^)(NSString *localPath, NSString *videoThumbnailPath, UIImage *image))finished
{
    @autoreleasepool {
        JYBDownloadFileApi *api = [[JYBDownloadFileApi alloc] initWithDownloadFileUrl:JYBBcfHttpUrl(msg.remoteUrl) type:JYBDownloadFileTypeMP4];
        //获取Video封面图
        UIImage * videoImage = [UIImage thumbnailImageForVideo:[NSURL URLWithString:JYBBcfHttpUrl(msg.remoteUrl)]];
        NSData *dataImg = UIImageJPEGRepresentation(videoImage, .1);
        NSString *imgPath = [NSString createWhiteboardAudioMessageResourcePathOfType:@"jpg"];
        [dataImg writeToFile:imgPath atomically:YES];
        NSString *videoThumbnailPath = [NSString handleInterceptLibraryResourcePath:imgPath];
        finished(nil, videoThumbnailPath, videoImage);
        //下载Video数据流
        [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
            DLog(@"%@",request.responseJSONObject);
            NSString * localPath = [NSString handleInterceptLibraryResourcePath:request.responseJSONObject];
            finished(localPath, videoThumbnailPath, videoImage);
        } failure:^(__kindof YTKBaseRequest *request) {
            DLog(@"%@",request.requestOperation.error);
        }];
    }
}

@end
