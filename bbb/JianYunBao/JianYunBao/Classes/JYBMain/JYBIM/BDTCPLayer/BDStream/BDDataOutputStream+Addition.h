//
//  BDDataOutputStream+Addition.h
//  BDSocketIM
//
//  Created by 冰点 on 16/2/22.
//  Copyright © 2016年 冰点. All rights reserved.
//

/************************************************************
 * summery       tcp服务器协议头
 *
     packet data unit header format:
     fps        -- 1 byte
     fpsl       -- 4 byte
     version    -- 1 byte
     time       --
     year       -- 2 byte
     moth       -- 1 byte
     day        -- 1 byte
     hour       -- 1 byte
     minu       -- 1 byte
     secd       -- 1 byte
     ispackage  -- 1 byte
 ************************************************************/

#import "BDDataOutputStream.h"

@interface BDDataOutputStream (Addition)

- (void)writeTCPProtocolHeader;
- (void)writeTCPProtocolHeader:(int8_t)version isSubcontract:(int8_t)subcontract seqNo:(uint16_t)seqNo;
@end
