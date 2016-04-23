//
//  JYBPlaySound.m
//  JianYunBao
//
//  Created by sks on 23/03/16.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBPlaySound.h"

@implementation JYBPlaySound


- (id)initForPlayingVibrate
{
    self = [super init];
    if (self)
    {
        soundID = kSystemSoundID_Vibrate;
    }
    return self;
}
- (id)initForPlayingSystemSoundWith:(NSString *)resourceName ofType:(NSString *)type
{
    self = [super init];
    if (self)
    {
        NSString *path = [NSString stringWithFormat:@"/System/Library/Audio/UISounds/%@.%@",resourceName,type];
//        NSString *path = [[NSBundle bundleWithIdentifier:@"com.apple.UIKit"] pathForResource:resourceName ofType:type];
        if (path)
        {
            SystemSoundID theSoundID;
             OSStatus error =  AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &theSoundID);
            if (error==kAudioServicesNoError)
            {
                soundID = theSoundID;
            }
            else{
                NSLog(@"创建声音失败");
            }
        }
    }
    return self;
}

- (id)initForPlayingSoundWith:(NSString *)fileName
{
    self = [super init];
    if (self)
    {
        NSURL *filURL = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
        if (filURL != nil)
        {
            SystemSoundID theSoundID;
            OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)filURL, &theSoundID);
            if (error == kAudioServicesNoError)
            {
                soundID = theSoundID;
            }else
            {
                NSLog(@"创建声音失败");
            }
        }
    }
    return self;
}

- (void)play
{
    AudioServicesPlaySystemSound(soundID);
}
- (void)dealloc
{
    AudioServicesDisposeSystemSoundID(soundID);
}

@end
