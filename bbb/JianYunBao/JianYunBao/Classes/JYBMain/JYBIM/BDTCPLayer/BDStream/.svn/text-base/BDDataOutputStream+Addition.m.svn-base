//
//  BDDataOutputStream+Addition.m
//  BDSocketIM
//
//  Created by 冰点 on 16/2/22.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "BDDataOutputStream+Addition.h"

@implementation BDDataOutputStream (Addition)

- (void)writeTCPProtocolHeader
{
    [self writeTCPProtocolHeader:TCP_Protocol_Version isSubcontract:0 seqNo:0];
}

- (void)writeTCPProtocolHeader:(int8_t)version isSubcontract:(int8_t)subcontract seqNo:(uint16_t)seqNo {
    //帧头
    [self writeFpsHeadTag];
    //协议版本号
    [self writeChar:version];
    //时间
    BDSTime bcdTime = [self getSystemTime];
    [self writeBCDTime:&bcdTime];
    //是否分包
    [self writeSubcontract:subcontract];//1
};

- (BDSTime)getSystemTime
{
    struct BDSTime bcdTime;
    bcdTime.year = [NSDate getCalendar].year;
    bcdTime.month = [NSDate getCalendar].month;
    bcdTime.day = [NSDate getCalendar].day;
    bcdTime.hour = [NSDate getCalendar].hour;
    bcdTime.min = [NSDate getCalendar].minute;
    bcdTime.sec = [NSDate getCalendar].second;
    return bcdTime;
}

@end
