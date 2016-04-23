//
//  JYBIMLogin.m
//  BDSocketIM
//
//  Created by 冰点 on 16/2/26.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBIMLogin.h"
#import "BDDataInputStream.h"

@implementation JYBIMLogin
{
    NSData *_data;
    BDDataInputStream *_inputStream;
}

+ (JYBIMLogin *)parseFromData:(NSData *)data
{
    return [[JYBIMLogin alloc] initWithData:data];
}

- (instancetype)initWithData:(NSData *)data
{
    if (self = [super init]) {
        _data = data;
        _inputStream = [[BDDataInputStream alloc] initWithData:data];
    }
    return self;
}

- (NSTimeInterval)s_timestamp
{
    return [_inputStream readLong];
}

- (NSTimeInterval)c_timestamp
{
    return [_inputStream readLong];
}

- (NSString *)port
{
    return [_inputStream readPort];
}


@end
