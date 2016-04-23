//
//  BDHeartBeatAPI.m
//  BDSocketIM
//
//  Created by 冰点 on 16/2/23.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "BDHeartBeatAPI.h"

@implementation BDHeartBeatAPI

- (int)requestTimeOutTimeInterval
{
    return 0;
}

- (int)requstCommendID
{
    return BD_TCP_PROTOCOL_CODE_HEARTBEAT;
}

- (int)responseCommendID
{
    return 0;
}

- (BDAnalysis)analysisReturnData
{
    BDAnalysis analysis = (id)^(NSData *data) {
        
    };
    return analysis;
}

- (BDPackage)packageRequestObject
{
    BDPackage package = (id)^(id obj, uint16_t seqNO) {
        BDDataOutputStream *outputStream = [[BDDataOutputStream alloc] init];
        [outputStream writeTCPProtocolHeader];
        [outputStream writeShort:BD_TCP_PROTOCOL_CODE_HEARTBEAT];
        [outputStream writeFpsLength];
        return [outputStream getBytesArray];
    };
    return package;
}

@end
