//
//  BDIMQueueCenter.h
//  BDSocketIM
//
//  Created by 冰点 on 16/2/24.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BDIMTask)();

@interface BDIMQueueCenter : NSObject

@property (nonatomic,readonly)dispatch_queue_t serialQueue;
@property (nonatomic,readonly)dispatch_queue_t parallelQueue;

+ (instancetype)sharedInstance;
- (void)pushTaskToSerialQueue:(BDIMTask)task;
- (void)pushTaskToParallelQueue:(BDIMTask)task;
- (void)pushTaskToSynchronizationSerialQUeue:(BDIMTask)task;

@end
