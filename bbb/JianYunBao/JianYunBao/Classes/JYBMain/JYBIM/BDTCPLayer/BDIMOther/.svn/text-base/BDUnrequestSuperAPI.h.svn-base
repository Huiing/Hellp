//
//  BDUnrequestSuperAPI.h
//  BDSocketIM
//
//  Created by 冰点 on 16/2/23.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDDataInputStream.h"
#import "BDAPIUnrequestScheduleProtocol.h"
#import "BDSocketManager.h"
#import "BDDataOutputStream.h"
#import "BDDataInputStream.h"
#import "BDDataOutputStream+Addition.h"
#import "BDTCPProtocolHeader.h"
#import "JYBMessage.h"
#import "JYBMessageBuilder.h"
#import "JYBIChatMessage.h"

typedef void(^ReceiveData)(id object,NSError* error);
@interface BDUnrequestSuperAPI : NSObject<BDAPIUnrequestScheduleProtocol>
{
    @protected
    int _commandID;
}

@property (nonatomic,copy)ReceiveData receivedData;
- (BOOL)registerAPIInAPIScheduleReceiveData:(ReceiveData)received;
@end
