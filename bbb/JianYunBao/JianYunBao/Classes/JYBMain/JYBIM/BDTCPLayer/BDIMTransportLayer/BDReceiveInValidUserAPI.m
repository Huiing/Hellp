//
//  BDReceiveInValidUserAPI.m
//  JianYunBao
//
//  Created by 冰点 on 16/3/14.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "BDReceiveInValidUserAPI.h"

@implementation BDReceiveInValidUserAPI

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
