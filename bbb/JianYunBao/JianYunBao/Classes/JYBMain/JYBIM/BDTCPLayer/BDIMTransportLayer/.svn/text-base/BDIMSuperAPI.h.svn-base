//
//  BDIMSuperAPI.h
//  BDSocketIM
//  发送接收的父类API
//  Created by 冰点 on 16/2/23.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDAPIScheduleProtocol.h"
#import "BDSocketManager.h"
#import "BDDataOutputStream.h"
#import "BDDataInputStream.h"
#import "BDDataOutputStream+Addition.h"
#import "BDTCPProtocolHeader.h"

typedef void(^RequestCompletion)(id response, NSError *error);

#define BDTimeOutTimeInterval 10
@interface BDIMSuperAPI : NSObject

@property (nonatomic, copy) RequestCompletion completion;

- (void)requestWithObject:(id)obj completion:(RequestCompletion)completion;

@end
