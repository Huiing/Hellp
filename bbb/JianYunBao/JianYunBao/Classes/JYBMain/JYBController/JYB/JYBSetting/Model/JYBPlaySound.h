//
//  JYBPlaySound.h
//  JianYunBao
//
//  Created by sks on 23/03/16.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>


@interface JYBPlaySound : NSObject
{
    SystemSoundID soundID;
}

//为震动初始化
- (id)initForPlayingVibrate;

//为播放系统音效初始化   resourceName 系统声音   type系统声音类型
- (id)initForPlayingSystemSoundWith:(NSString *)resourceName ofType:(NSString *)type;

//为播放特定的音频文件初始化（0需要音频文件）fileName 文件路径
- (id)initForPlayingSoundWith:(NSString *)fileName;

//播放音效
- (void)play;




@end
