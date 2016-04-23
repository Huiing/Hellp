//
//  JYBDownAudioApi.h
//  JianYunBao
//
//  Created by 冰点 on 16/3/6.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <YTKNetwork/YTKRequest.h>

typedef enum : NSUInteger {
    JYBDownloadFileTypeMP3,
    JYBDownloadFileTypeMP4,
    JYBDownloadFileTypeImage,
} JYBDownloadFileType;

@interface JYBDownloadFileApi : YTKRequest

- (instancetype)initWithDownloadFileUrl:(NSString *)fileUrl type:(JYBDownloadFileType)type;

@end
