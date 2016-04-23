//
//  JYBNotificationModule.m
//  JianYunBao
//
//  Created by 冰点 on 16/3/14.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBNotificationModule.h"
#import "BDReceiveNotificationAPI.h"

@implementation JYBNotificationModule

+ (instancetype)sharedInstance {
    static JYBNotificationModule * _someCls = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _someCls = [[JYBNotificationModule alloc] init];
    });
    return _someCls;
}

- (instancetype)init
{
    if (self = [super init]) {
        //注册API
        
    }
    return self;
}

- (void)registerReceiveNotificationAPIWithCommandIDs:(NSArray *)cmds
{
    BDReceiveNotificationAPI *notiAPI = [[BDReceiveNotificationAPI alloc] initWithMessageCommandID:[cmds[0] intValue]];
    [notiAPI registerAPIInAPIScheduleReceiveData:^(id object, NSError *error) {
        
    }];
    
    
}

@end
