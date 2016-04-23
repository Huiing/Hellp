//
//  BDReceiveKickoffAPI.m
//  JianYunBao
//
//  Created by 冰点 on 16/3/11.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "BDReceiveKickoffAPI.h"

@implementation BDReceiveKickoffAPI

- (instancetype)initWithMessageCommandID:(int)commandID
{
    if (self = [super initWithMessageCommandID:commandID]) {
    }
    return self;
}

- (int)responseCommandID
{
    return _commandID;
}

- (BDUnreqeustAPIAnalysis)unrequestAnalysis
{
    BDUnreqeustAPIAnalysis analysis = (id)^(NSData *data, int commandID) {
        return @(commandID);
    };
    return analysis;
}
@end
