//
//  BDLoginAPI.m
//  BDSocketIM
//
//  Created by 冰点 on 16/2/23.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "BDLoginAPI.h"
//#import "BDIMLogin.pb.h"
#import "JYBIMLogin.h"

@implementation BDLoginAPI

- (int)requestTimeOutTimeInterval
{
    return 5;
}

- (int)requstCommendID
{
    return BD_TCP_PROTOCOL_CODE_LOGIN;
}

- (int)responseCommendID
{
    return BD_TCP_PROTOCOL_CODE_LOGIN_RES;
}

- (BDAnalysis)analysisReturnData
{
    BDAnalysis analysis = (id)^(NSData *data) {
        NSDictionary *responseObject = nil;
        if (data == nil) {
            return responseObject;
        }
        //解析登录的`Stream`
        JYBIMLogin *login = [JYBIMLogin parseFromData:data];
        NSTimeInterval s_timestamp = login.s_timestamp;
        NSTimeInterval c_timestamp = login.c_timestamp;
        NSString *port = login.port;
        responseObject = @{@"s_timestamp":@(s_timestamp),
                           @"c_timestamp":@(c_timestamp),
                           @"port":port};
        return responseObject;
    };
    return analysis;
}

- (BDPackage)packageRequestObject
{
    BDPackage package = (id)^(id obj, uint16_t seqNO) {
        BDDataOutputStream *outputStream = [[BDDataOutputStream alloc] init];
        [outputStream writeTCPProtocolHeader];
        //功能码
        [outputStream writeShort:BD_TCP_PROTOCOL_CODE_LOGIN];
        //终端id
        [outputStream writeUTF8:obj];
        //时间戳
        long timestamp = [NSDate getTimestamp];
        [outputStream writeLong:timestamp];
        //帧长度
        [outputStream writeFpsLength];
        return [outputStream getBytesArray];
    };
    return package;
}

@end
