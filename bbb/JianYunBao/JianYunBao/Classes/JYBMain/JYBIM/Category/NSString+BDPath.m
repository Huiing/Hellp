//
//  NSString+BDPath.m
//  JianYunBao
//
//  Created by 冰点 on 16/3/1.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "NSString+BDPath.h"
#import "RuntimeStatus.h"
#import "JYBUserEntity.h"

NSString *JYB_LibraryDirectoryPath()
{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

@implementation NSString (BDPath)

+ (NSString*)userExclusiveDirection
{
    NSString* myName = [RuntimeStatus sharedInstance].userEntity.userid;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString* directorPath = [documentsDirectory stringByAppendingPathComponent:myName];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:directorPath])
    {
        [fileManager createDirectoryAtPath:directorPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return directorPath;
}

+ (NSString *)createFileName
{
    int x = arc4random() % 100000;
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    NSString *fileName = [NSString stringWithFormat:@"%d%d",(int)time,x];
    return fileName;
}

+ (NSString *)createWhiteboardVideoFilePath
{
    NSString *aFilePath = [self getLibraryAppDataCachePath];
    aFilePath = [aFilePath stringByAppendingFormat:@"/chatbuffer/%@.mp4", [self createFileName]];
    NSFileManager *fm = [NSFileManager defaultManager];
    if(![fm fileExistsAtPath:[aFilePath stringByDeletingLastPathComponent]]){
        [fm createDirectoryAtPath:[aFilePath stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return aFilePath;
}

+ (NSString *)createWhiteboardAudioMessageResourcePathOfType:(NSString *)type
{
    NSString *fileName = [self createFileName];
    NSString *aFilePath = [self getLibraryAppDataCachePath];
     aFilePath = [aFilePath stringByAppendingFormat:@"/%@/chat/whiteboard/messages/%@.%@",[RuntimeStatus sharedInstance].userItem.userId,fileName,type];
    NSFileManager *fm = [NSFileManager defaultManager];
    if(![fm fileExistsAtPath:[aFilePath stringByDeletingLastPathComponent]]){
        [fm createDirectoryAtPath:[aFilePath stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return aFilePath;
}

+ (NSString *)copyWhiteboardAudioFilePath:(NSString *)resourcePath
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *toFilePath = [self createWhiteboardAudioMessageResourcePathOfType:@"amr"];
    NSError *error = JYBError(@"音频文件copy失败！");
    BOOL ret = [fm copyItemAtPath:resourcePath toPath:toFilePath error:&error];
    if (ret) {
        return [self handleInterceptLibraryResourcePath:toFilePath];
    } else {
        return nil;
    }
}

+ (NSString *)handleInterceptLibraryResourcePath:(NSString *)resourcePath
{
    NSString *aFilePath = JYB_LibraryDirectoryPath();
    NSRange range = [resourcePath rangeOfString:aFilePath];
    return [resourcePath substringFromIndex:range.length];
}

+ (NSString *)getLibraryAppDataCachePath
{
    NSString *aFilePath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [aFilePath stringByAppendingString:@"/appdata"];
}

@end
