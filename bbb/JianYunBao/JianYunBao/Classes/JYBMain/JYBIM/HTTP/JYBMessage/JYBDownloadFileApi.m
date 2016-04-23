//
//  JYBDownAudioApi.m
//  JianYunBao
//
//  Created by 冰点 on 16/3/6.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBDownloadFileApi.h"
#import "NSString+BDPath.h"

@implementation JYBDownloadFileApi
{
    NSString *_fileUrl;
    JYBDownloadFileType _type;
}
- (instancetype)initWithDownloadFileUrl:(NSString *)fileUrl type:(JYBDownloadFileType)type
{
    if (self = [super init]) {
        _fileUrl = fileUrl;
        _type = type;
    }
    return self;
}

- (NSString *)requestUrl
{
    return _fileUrl;
}

- (NSString *)resumableDownloadPath
{
    switch (_type) {
        case JYBDownloadFileTypeMP3:
            return [NSString createWhiteboardAudioMessageResourcePathOfType:@"mp3"];
            break;
        case JYBDownloadFileTypeMP4:
            return [NSString createWhiteboardAudioMessageResourcePathOfType:@"mp4"];
            break;
        default:
            break;
    }
    return nil;
}

@end
