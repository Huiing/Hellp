//
//  NSStream+NSStreamAddition.m
//  BDSocketIM
//
//  Created by 冰点 on 16/2/22.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "NSStream+NSStreamAddition.h"

@implementation NSStream (NSStreamAddition)

+ (void)getStreamsToHostWithName:(NSString *)hostname port:(NSInteger)port inputStream:(NSInputStream * _Nullable __autoreleasing *)inputStream outputStream:(NSOutputStream * _Nullable __autoreleasing *)outputStream
{
    CFHostRef           host;
    CFReadStreamRef     readStream = NULL;
    CFWriteStreamRef    writeStream = NULL;
    
    host = CFHostCreateWithName(NULL, (__bridge CFStringRef _Nonnull)(hostname));
    
    if (host != NULL) {
        (void) CFStreamCreatePairWithSocketToCFHost(NULL, host, (SInt32)port, &readStream, &writeStream);
        CFRelease(host);
    }
    
    if (inputStream == NULL) {
        if (readStream != NULL) {
            CFRelease(readStream);
        }
    } else {
        *inputStream = (__bridge NSInputStream *)(readStream);
    }
    
    if (outputStream == NULL) {
        if (writeStream != NULL) {
            CFRelease(writeStream);
        }
    } else {
        *outputStream = (__bridge NSOutputStream *)(writeStream);
    }
    
    
}

@end
