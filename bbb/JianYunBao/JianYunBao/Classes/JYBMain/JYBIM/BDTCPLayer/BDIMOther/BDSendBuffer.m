//
//  BDSendBuffer.m
//  BDSocketIM
//
//  Created by 冰点 on 16/2/23.
//  Copyright © 2016年 冰点. All rights reserved.
//  发送数据的缓冲区
//

#import "BDSendBuffer.h"

@implementation BDSendBuffer
@synthesize sendPos;

- (instancetype)initWithData:(NSData *)newData
{
    if (self = [super init]) {
        outputData = [NSMutableData dataWithData:newData];
        sendPos = 0;
    }
    return self;
}

+ (instancetype)dataWithData:(NSData *)newData
{
    return [[BDSendBuffer alloc] initWithData:newData];
}

- (void)consumeData:(NSInteger)length
{
    sendPos += length;
}

- (const void *)bytes
{
    return [outputData bytes];
}

- (NSUInteger)length
{
    return [outputData length];
}

- (void *)mutableBytes
{
    return [outputData mutableBytes];
}

- (void)setLength:(NSUInteger)length
{
    [outputData setLength:length];
}


@end
