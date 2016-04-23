//
//  JYBIMMessage.m
//  BDSocketIM
//
//  Created by 冰点 on 16/2/29.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBIMMessage.h"
#import "BDDataInputStream.h"

@implementation JYBIMMessage
{
    NSData *_data;
    BDDataInputStream *_inputStream;
}

+ (JYBIMMessage *)parseFromData:(NSData *)data commandID:(int)commandID
{
    return [[JYBIMMessage alloc] initWithData:data commandID:commandID];
}

- (instancetype)initWithData:(NSData *)data commandID:(int)commandID
{
    if (self = [super init]) {
        _data = data;
        _commandID = commandID;
        _inputStream = [[BDDataInputStream alloc] initWithData:data];
    }
    return self;
}

- (NSString *)readDataToStringWith:(int)len
{
    NSData *d = [_inputStream readDataWithLength:len];
    return [[NSString alloc] initWithData:d encoding:NSUTF8StringEncoding];
}

- (int)commandID
{
    return _commandID;
}

- (NSString *)messageID
{
    return [self readDataToStringWith:[_inputStream readShort]];
}

- (NSString *)fromUserID
{
    return [self readDataToStringWith:[_inputStream readShort]];
}

- (NSString *)userName
{
    return [self readDataToStringWith:[_inputStream readShort]];
}

- (NSString *)content
{
    return [self readDataToStringWith:[_inputStream readInt]];
}

- (NSTimeInterval)timestamp
{
    return [_inputStream readLong];
}

- (int)duration
{
    return [_inputStream readInt];
}

- (NSString *)fileURL
{
    return [self readDataToStringWith:[_inputStream readInt]];
}

- (int)fileSize
{
    return [_inputStream readInt];
}

- (NSString *)groupID
{
    return [self readDataToStringWith:[_inputStream readShort]];
}

- (NSString *)nodeId
{
    return [self readDataToStringWith:[_inputStream readShort]];
}

- (NSString *)toUserID
{
    return [self readDataToStringWith:[_inputStream readShort]];
}

//- (NSString *)billID
//{
//    return [self readDataToStringWith:[_inputStream readShort]];
//}
@end
