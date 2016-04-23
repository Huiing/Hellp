//
//  BDIMQueueCenter.m
//  BDSocketIM
//
//  Created by 冰点 on 16/2/24.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "BDIMQueueCenter.h"

@implementation BDIMQueueCenter

+ (instancetype)sharedInstance {
    static BDIMQueueCenter * _someCls = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _someCls = [[BDIMQueueCenter alloc] init];
    });
    return _someCls;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _serialQueue = dispatch_queue_create("com.bd.JianYunBao.BDIMserialQueue", NULL);
        _parallelQueue = dispatch_queue_create("com.bd.JianYunBao.BDImparallelQueue", NULL);
    }
    return self;
}

- (void)pushTaskToSerialQueue:(BDIMTask)task
{
    dispatch_async(self.serialQueue, ^{
        task();
    });
}

- (void)pushTaskToParallelQueue:(BDIMTask)task
{
    dispatch_async(self.parallelQueue, ^{
        task();
    });
}

- (void)pushTaskToSynchronizationSerialQUeue:(BDIMTask)task
{
    dispatch_sync(self.serialQueue, ^{
        task();
    });
}


@end
