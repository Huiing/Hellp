//
//  BDSocketManager.m
//  BDSocketIM
//
//  Created by 冰点 on 16/2/23.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "BDSocketManager.h"
#import "NSStream+NSStreamAddition.h"
#import "BDSendBuffer.h"
#import "BDClientState.h"
#import "BDDataInputStream.h"
#import "BDTCPProtocolHeader.h"
#import "BDAPISchedule.h"
#import "BDNotification.h"

@implementation BDSocketManager

+ (instancetype)sharedInstance {
    static BDSocketManager * _socketManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _socketManager = [[BDSocketManager alloc] init];
    });
    return _socketManager;
}

#pragma mark - PublicAPI
- (void)connectToHost:(NSString *)host onPort:(NSInteger)port error:(NSError *__autoreleasing *)errPtr
{
    DLog(@"client: connect ip:%@ port:%ld", host, port);
    cDataLen = 0;
    _receiveBuffer = [NSMutableData data];
    _sendBuffers = [NSMutableArray array];
    _noDataSent = NO;
    
    _receiveLock = [[NSLock alloc] init];
    _sendLock = [[NSLock alloc] init];
    
    NSInputStream *tmpInputStream = nil;
    NSOutputStream *tmpOutputStream = nil;
    
    [NSStream getStreamsToHostWithName:host port:port inputStream:&tmpInputStream outputStream:&tmpOutputStream];
    
    _inputStream = tmpInputStream;
    _outputStream = tmpOutputStream;
    
    [_inputStream setDelegate:self];
    [_outputStream setDelegate:self];
    
    [_inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [_outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    [_inputStream open];
    [_outputStream open];
}

- (void)disconnect
{
    DLog(@"client: disconnect");
    cDataLen = 0;
    
    _receiveLock = nil;
    _sendLock = nil;
    if (_inputStream) {
        [_inputStream close];
        [_inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }
    
    _inputStream = nil;
    
    if (_outputStream) {
        [_outputStream close];
        [_outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }
    _outputStream = nil;
    
    _receiveBuffer = nil;
    _sendBuffers = nil;
    _lastSendBuffer = nil;
    //TODO: socket 断开连接的通知
    [BDNotification postNotification:JYBNotificationTcpLinkDisconnect userInfo:nil object:nil];
}

- (void)writeDataToSocket:(NSMutableData *)data
{
    [_sendLock lock];
    @try {
        if (_noDataSent) {
            NSInteger len;
            len = [_outputStream write:[data mutableBytes] maxLength:[data length]];
            _noDataSent = NO;
            DLog(@"WRITE - Written directly to outStream len:%li", (long)len);
            if (len < [data length]) {
                DLog(@"WRITE - Creating a new buffer for remaining data len:%lu", [data length] - len);
                _lastSendBuffer = [BDSendBuffer dataWithData:[data subdataWithRange:NSMakeRange([data length]-len, [data length])]];
                [_sendBuffers addObject:_lastSendBuffer];
            }
            return;
        }
        
        if (_lastSendBuffer) {
            NSInteger lastSendBufferLength;
            NSInteger newDataLength;
            lastSendBufferLength = [_lastSendBuffer length];
            newDataLength = [data length];
            if (lastSendBufferLength <= BUFSIZ) {
                DLog(@"WRITE - Have a buffer with enough space, appending data to it");
                [_lastSendBuffer appendData:data];
                return;
            }
        }
        DLog(@"WRITE - Creating a new buffer");
        _lastSendBuffer = [BDSendBuffer dataWithData:data];
        [_sendBuffers addObject:_lastSendBuffer];
        
    }
    @catch (NSException *exception) {
        DLog(@" ***** NSException:%@ in writeToSocket of MGJMTalkClient *****",exception);
    }
    @finally {
        [_sendLock unlock];
    }
}

#pragma mark - NSStreamDelegate
- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
{
    switch (eventCode) {
        case NSStreamEventNone:
            DLog(@"Event type: EventNone");
            break;
        case NSStreamEventOpenCompleted:
            [self handleConnectOpenCompletedStream:aStream];
            break;
        case NSStreamEventHasBytesAvailable://接收数据
            [self handleEventHasBytesAvailableStream:aStream];
            break;
        case NSStreamEventHasSpaceAvailable://发送数据
            [self handleEventHasSpaceAvailableStream:aStream];
            break;
        case NSStreamEventErrorOccurred:
            [self handleEventErrorOccurredStream:aStream];
            break;
        case NSStreamEventEndEncountered:
            [self handleEventEventEndEncounteredStream:aStream];
            break;
        default:
            break;
    }
}

- (void)handleConnectOpenCompletedStream:(NSStream *)aStream
{
    DLog();
    if (aStream == _outputStream) {
        [BDNotification postNotification:JYBNotificationTcpLinkConnectComplete userInfo:nil object:nil];
        //黑屏状态唤起后Socket重连成功
        [BDClientState sharedInstance].userState = JYBUserStateOnline;
    }
}

- (void)handleEventHasBytesAvailableStream:(NSStream *)aStream
{
    DLog();
    if (!aStream) {
        DLog(@"No Buffer");
    } else {
        uint8_t buf[BUFSIZ];
        NSInteger len = 0;
        len = [(NSInputStream *)aStream read:buf maxLength:BUFSIZ];
        if (len > 0) {
            [_receiveLock lock];
            [_receiveBuffer appendBytes:(const void *)buf length:len];
            /*
             *rev:
             <
             aa → 帧头 1
             00000030 → 帧长 4
             01 → version 1
             2016 → BCD:year 2
             02 → BCD:moth 1
             22 → BCD:day 1
             11 → BCD:h 1
             55 → BCD:min 1
             19 → BCD:second 1
             00 → ispacket是否分包 1
             ------------
             03e9 → code 功能码
             ------------
             00000153 071dff5e #服务器端时钟（ms）→ ms / 1000: 1456113319.774
             <!--1456113319 → 2016-2-22 11:55:19-->
             
             00000000 56ca86a5 #1456113317 → 2016-2-22 11:55:17
             000e → 终端IP长(short)：short 14
             3131 382e3234 342e3235 342e3233 #终端IP (String) → 118.244.254.23
             >
             */
            
//            NSRange ipRange = NSMakeRange(len-14, 14);
//            NSData *ipData  = [_receiveBuffer subdataWithRange:ipRange];
//            NSString *ip    = [[NSString alloc] initWithData:ipData encoding:NSUTF8StringEncoding];
            
            while ([_receiveBuffer length] >= 16) {
                NSRange range = NSMakeRange(0, 16);
                
                NSData *headerData = [_receiveBuffer subdataWithRange:range];
                
                BDDataInputStream *inputData = [BDDataInputStream dataInputStreamWithData:headerData];
                
                int16_t fps = [inputData readFpsHeadTag];
                int32_t fpsl = [inputData readInt];
                int16_t version = [inputData readChar];
                BDSTime bcdTime = [inputData readBCDTime];
                int16_t subcontract = [inputData readSubcontract];
                
                if (fpsl > (uint32_t)[_receiveBuffer length]) {
                    DLog(@"not enough data received");
                    break;
                }
                
                BDTCPProtocolHeader* tcpHeader = [[BDTCPProtocolHeader alloc] init];
                tcpHeader.fps = fps;
                tcpHeader.fpsl = fpsl;
                tcpHeader.version = version;
                tcpHeader.sTime = bcdTime;
                tcpHeader.subcontract = subcontract;
                tcpHeader.commandId = [inputData readShort];
                DLog(@"receive a packet version=%d, commandId=%d", tcpHeader.version, tcpHeader.commandId);
                range = NSMakeRange(16, fpsl - 16);
                NSData *payloadData = [_receiveBuffer subdataWithRange:range];
                uint32_t remainLen = (int)[_receiveBuffer length] - fpsl;
                range = NSMakeRange(fpsl, remainLen);
                NSData *remainData = [_receiveBuffer subdataWithRange:range];
                [_receiveBuffer setData:remainData];
                ServerDataType dataType = DDMakeServerDataType(tcpHeader.commandId);
                DLog(@"***********收到服务端cid:%i",tcpHeader.commandId);
//                if (payloadData.length >0) {
                    [[BDAPISchedule sharedInstance] receiveServerData:payloadData forDataType:dataType];
//                }
                
                //根据指令commandID下发通知
//                [self routerNotificationWithCommandID:tcpHeader.commandId];
//                [BDNotification postNotification:JYBNotificationServerHeartBeat userInfo:nil object:nil];
            }
            
            [_receiveLock unlock];
        } else {
            DLog(@"No buffer!");
        }
    }
    
}

//- (void)routerNotificationWithCommandID:(int)cmdID
//{
//    switch (cmdID) {
//        case BD_TCP_PROTOCOL_CODE_KICOUT:
//            [BDNotification postNotification:JYBNotificationUserKickouted userInfo:nil object:nil];
//            break;
//            
//        default:
//            break;
//    }
//}

- (void)handleEventHasSpaceAvailableStream:(NSStream *)aStream
{
    [_sendLock lock];
    @try {
        if (![_sendBuffers count]) {
            DLog(@"WRITE - No data to send");
            _noDataSent = YES; return;
        }
        
        BDSendBuffer *sendBuffer = [_sendBuffers objectAtIndex:0];
        NSInteger sendBufferLength = [sendBuffer length];
        if (!sendBufferLength) {
            if (sendBuffer == _lastSendBuffer) {
                _lastSendBuffer = nil;
            }
            [_sendBuffers removeObjectAtIndex:0];
            DLog(@"WRITE - No data to send");
            _noDataSent = YES; return;
        }
        
        NSInteger len = ((sendBufferLength - [sendBuffer sendPos] >= 1024) ? 1024: (sendBufferLength - [sendBuffer sendPos]));
        if (!len) {
            if (sendBuffer == _lastSendBuffer) {
                _lastSendBuffer = nil;
            }
            [_sendBuffers removeObjectAtIndex:0];
            DLog(@"WRITE - No data to send");
            _noDataSent = YES; return;
        }
        
        len = [_outputStream write:((const uint8_t *)[sendBuffer mutableBytes] + [sendBuffer sendPos]) maxLength:len];
        DLog(@"WRITE - Written directly to outStream len:%lid", (long)len);
        [sendBuffer consumeData:len];
        if (![sendBuffer length]) {
            if (sendBuffer == _lastSendBuffer) {
                _lastSendBuffer = nil;
            }
            [_sendBuffers removeObjectAtIndex:0];
        }
        _noDataSent = YES; return;
    }
    @catch (NSException *exception) {
        DLog(@" ***** NSException in MGJMTalkCleint :%@  ******* ",exception);
    }
    @finally {
        [_sendLock unlock];
    }
}

- (void)handleEventErrorOccurredStream:(NSStream *)aStream
{
    DLog();
    /*
     每次从黑屏状态唤起APP都会调用此方法
     原因：Error Domain=NSPOSIXErrorDomain Code=57 "Socket is not connected"
     socket断开了，即进入黑屏将会断开Socket
     
     
     //被挤下线后：Connection reset by peer
     
     */
    [self disconnect];
    NSError * error = [aStream streamError];
    if (error.code == 57) {
        [BDClientState sharedInstance].userState = JYBUserStateOffline;
    }
}

- (void)handleEventEventEndEncounteredStream:(NSStream *)aStream
{
    DLog();
    cDataLen = 0;
}

@end
