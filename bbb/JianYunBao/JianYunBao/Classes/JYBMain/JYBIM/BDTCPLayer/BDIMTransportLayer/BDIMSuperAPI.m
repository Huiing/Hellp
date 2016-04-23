//
//  BDIMSuperAPI.m
//  BDSocketIM
//
//  Created by 冰点 on 16/2/23.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "BDIMSuperAPI.h"
#import "BDAPISchedule.h"

@implementation BDIMSuperAPI

- (void)requestWithObject:(id)obj completion:(RequestCompletion)completion
{
    //注册接口
    BOOL registerApi = [[BDAPISchedule sharedInstance] registerApi:(id<BDAPIScheduleProtocol>)self];
    if (!registerApi) {
        return;
    }
    
    //注册请求超时
    if ([(id<BDAPIScheduleProtocol>)self requestTimeOutTimeInterval] > 0) {
        [[BDAPISchedule sharedInstance] registerTimeoutApi:(id<BDAPIScheduleProtocol>)self];
    }
    
    //保存完成块
    self.completion = completion;
    
    BDPackage package = [(id<BDAPIScheduleProtocol>)self packageRequestObject];
    NSMutableData *requestObject = package(obj);
    
    if (requestObject) {
        [[BDAPISchedule sharedInstance] sendData:requestObject];
    }
}

@end
