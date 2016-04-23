//
//  BDUnrequestSuperAPI.m
//  BDSocketIM
//
//  Created by 冰点 on 16/2/23.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "BDUnrequestSuperAPI.h"
#import "BDAPISchedule.h"

@implementation BDUnrequestSuperAPI

- (instancetype)initWithMessageCommandID:(int)commandID
{
    if (self = [super init]) {
        _commandID = commandID;
    }
    return self;
}

- (BOOL)registerAPIInAPIScheduleReceiveData:(ReceiveData)received
{
    BOOL registerSuccess = [[BDAPISchedule sharedInstance] registerUnrequestApi:(id<BDAPIUnrequestScheduleProtocol>)self];
    if (registerSuccess) {
        self.receivedData = received;
        return YES;
    } else {
        return NO;
    }
}

- (int)responseCommandID
{
    return 0;
}

- (BDUnreqeustAPIAnalysis)unrequestAnalysis
{
    return nil;
}

@end
