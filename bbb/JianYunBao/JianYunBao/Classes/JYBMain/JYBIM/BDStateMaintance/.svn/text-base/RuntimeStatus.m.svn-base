//
//  RuntimeStatus.m
//  BDSocketIM
//
//  Created by 冰点 on 16/2/27.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "RuntimeStatus.h"
#import "JYBUserEntity.h"
#import "JYBBuildCloudEntity.h"
#import "JYBUserItem.h"
#import "JYBMessageModule.h"
#import "BDClientStateMaintenanceManager.h"
#import "BDReceiveKickoffAPI.h"
#import "BDIMDatabaseUtil.h"
#import "NSString+BDPath.h"
#import "BDReceiveInValidUserAPI.h"

@implementation RuntimeStatus

+ (instancetype)sharedInstance {
    static RuntimeStatus * _someCls = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _someCls = [[RuntimeStatus alloc] init];
    });
    return _someCls;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.userEntity = [JYBUserEntity new];
        self.buildCloudEntity = [JYBBuildCloudEntity new];
        [self registerAPI];
    }
    return self;
}

- (void)registerAPI
{
    BDReceiveKickoffAPI *kickoffAPI = [[BDReceiveKickoffAPI alloc] initWithMessageCommandID:BD_TCP_PROTOCOL_CODE_KICOUT];
    [kickoffAPI registerAPIInAPIScheduleReceiveData:^(id object, NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:JYBNotificationUserKickouted object:nil];
    }];
    
    BDReceiveInValidUserAPI *inValidUserAPI = [[BDReceiveInValidUserAPI alloc] initWithMessageCommandID:BD_TCP_PROTOCOL_CODE_INVALIDUSER];
    [inValidUserAPI registerAPIInAPIScheduleReceiveData:^(id object, NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:JYBNotificationInvalidUser object:nil];
    }];
    
}

#pragma mark - Public M

- (NSString *)conversationForChatter:(NSString *)chatter conversationType:(JYBConversationType)type
{
    return nil;
}


- (void)updateUserEntity:(JYBUserEntity *)user withBuildCloudEntity:(JYBBuildCloudEntity *)buildCloud
{
    if (user) {
        self.userEntity = user;
    }
    
    if (buildCloud) {
        self.buildCloudEntity = buildCloud;
    }
}

- (void)updateData
{
    [JYBMessageModule sharedInstance];
    [BDClientStateMaintenanceManager sharedInstance];
}

- (void)clearCache
{
    [[BDIMDatabaseUtil sharedInstance] deleteAllDB];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *appdataPath = [NSString getLibraryAppDataCachePath];
    if ([fm fileExistsAtPath:appdataPath]) {
        NSError *error = nil;
        [fm removeItemAtPath:appdataPath error:&error];
    }
}

@end
