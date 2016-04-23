//
//  BDSocketManager.h
//  BDSocketIM
//
//  Created by 冰点 on 16/2/23.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BDSendBuffer;
@interface BDSocketManager : NSObject<NSStreamDelegate>
{
    @private
    NSInputStream *_inputStream;
    NSOutputStream *_outputStream;
    NSLock *_receiveLock;
    NSMutableData *_receiveBuffer;
    NSLock *_sendLock;
    NSMutableArray *_sendBuffers;
    BDSendBuffer *_lastSendBuffer;
    BOOL _noDataSent;//有无数据是否发送的标记， YES-没有数据 NO-有数据
    int32_t cDataLen;
}

+ (instancetype)sharedInstance;

- (void)connectToHost:(NSString *)host onPort:(NSInteger)port error:(NSError **)errPtr;
- (void)disconnect;
- (void)writeDataToSocket:(NSMutableData *)data;
@end
