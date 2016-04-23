//
//  NSString+BDPath.h
//  JianYunBao
//
//  Created by 冰点 on 16/3/1.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString * JYB_LibraryDirectoryPath();
@interface NSString (BDPath)

+ (NSString*)userExclusiveDirection;

+ (NSString *)getLibraryAppDataCachePath;
+ (NSString *)createWhiteboardAudioMessageResourcePathOfType:(NSString *)type;
+ (NSString *)copyWhiteboardAudioFilePath:(NSString *)resourcePath;
+ (NSString *)createWhiteboardVideoFilePath;
+ (NSString *)handleInterceptLibraryResourcePath:(NSString *)resourcePath;

@end
