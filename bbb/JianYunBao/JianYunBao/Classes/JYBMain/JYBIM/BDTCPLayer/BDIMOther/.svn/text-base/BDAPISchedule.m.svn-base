//
//  BDAPISchedule.m
//  BDSocketIM
//
//  Created by 冰点 on 16/2/23.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "BDAPISchedule.h"
#import "BDSocketManager.h"
#import "BDIMSuperAPI.h"
#import "BDUnrequestSuperAPI.h"
#import "BDIMQueueCenter.h"
#import "BDHeartBeatAPI.h"

//static NSInteger const timeInterval = 1;
//typedef NS_ENUM(NSInteger, APIErrorCode){
//    Timeout = -1001,
//    Result = 1002
//};

#define MAP_REQUEST_KEY(api)                                [NSString stringWithFormat:@"%i-%i",[api requstCommendID],[api responseCommendID]]

#define MAP_RESPONSE_KEY(api)                               [NSString stringWithFormat:@"response_%i",[api responseCommendID]]

#define MAP_DATA_RESPONSE_KEY(serverData)                   [NSString stringWithFormat:@"response_%i",serverData.commandID]

#define MAP_UNREQUEST_KEY(api)                              [NSString stringWithFormat:@"%i",[api responseCommandID]]

#define MAP_DATA_UNREQUEST_KEY(serverData)                  [NSString stringWithFormat:@"%i",serverData.commandID]

@interface BDAPISchedule ()
{
    NSMutableDictionary* _apiRequestMap;
    NSMutableDictionary* _apiResponseMap;
    
    NSMutableDictionary* _unrequestMap;
    NSMutableDictionary* _timeoutMap;
    
    NSTimer* _timeOutTimer;
}

- (void)requestCompletion:(id<BDAPIScheduleProtocol>)api;
- (void)timeoutOnTimer:(id)timer;
@end
@implementation BDAPISchedule

+ (instancetype)sharedInstance {
    static BDAPISchedule * _apiSchedule = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _apiSchedule = [[BDAPISchedule alloc] init];
    });
    return _apiSchedule;
}

- (instancetype)init
{
    if (self = [super init]) {
        _apiRequestMap = [[NSMutableDictionary alloc] init];
        _apiResponseMap = [[NSMutableDictionary alloc] init];
        _unrequestMap = [[NSMutableDictionary alloc] init];
        _timeoutMap = [[NSMutableDictionary alloc] init];
        _apiScheduleQueue = dispatch_queue_create("com.JianYunBao.JYB.apiSchedule", NULL);
    }
    return self;
}

#pragma mark - public
///同步注册Api
- (BOOL)registerApi:(id<BDAPIScheduleProtocol>)api
{
    __block BOOL registSuccess = NO;
    dispatch_sync(self.apiScheduleQueue, ^{
        if (![api analysisReturnData])
        {
            registSuccess = YES;
        }
        DLog(@"key %@", MAP_REQUEST_KEY(api));
        if (![[_apiRequestMap allKeys] containsObject:MAP_REQUEST_KEY(api)])
        {
            [_apiRequestMap setObject:api forKey:MAP_REQUEST_KEY(api)];
            registSuccess = YES;
        }
        else
        {
            registSuccess = NO;
        }
        
        //注册返回数据处理
        if (![[_apiResponseMap allKeys] containsObject:MAP_RESPONSE_KEY(api)])
        {
            [_apiResponseMap setObject:api forKey:MAP_RESPONSE_KEY(api)];
        }
        if ([api isKindOfClass:[BDHeartBeatAPI class]]) {
            [self requestCompletion:api];
        }
    });
    return registSuccess;
    
}

- (void)registerTimeoutApi:(id<BDAPIScheduleProtocol>)api
{
    double delayInSeconds = [api requestTimeOutTimeInterval];
    if (delayInSeconds == 0)
    {
        return;
    }
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if ([[_apiRequestMap allKeys] containsObject:MAP_REQUEST_KEY(api)])
        {
            [[BDIMQueueCenter sharedInstance] pushTaskToSerialQueue:^{
                RequestCompletion completion = [(BDIMSuperAPI*)api completion];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    if (completion) {
                        completion(nil,JYBError(@"请求超时"));
                    }
                });
                [self requestCompletion:api];
            }];
        }
    });
}

- (void)receiveServerData:(NSData *)data forDataType:(ServerDataType)dataType
{
    dispatch_async(self.apiScheduleQueue, ^{
        NSString* key = MAP_DATA_RESPONSE_KEY(dataType);
        //根据key去调用注册api的completion
        id<BDAPIScheduleProtocol> api = _apiResponseMap[key];
        if (api)
        {
            RequestCompletion completion = [(BDIMSuperAPI*)api completion];
            BDAnalysis analysis = [api analysisReturnData];
            id response = analysis(data);
            [self requestCompletion:api];
            dispatch_async(dispatch_get_main_queue(), ^{
                @try {
                    completion(response,nil);
                }
                @catch (NSException *exception) {
                    DLog(@"completion,response is nil");
                }
            });
        }
        else
        {
            NSString* unrequestKey = MAP_DATA_UNREQUEST_KEY(dataType);
            id<BDAPIUnrequestScheduleProtocol> unrequestAPI = _unrequestMap[unrequestKey];
            if (unrequestAPI)
            {
                BDUnreqeustAPIAnalysis unrequestAnalysis = [unrequestAPI unrequestAnalysis];
                id object = unrequestAnalysis(data, dataType.commandID);
                ReceiveData received = [(BDUnrequestSuperAPI*)unrequestAPI receivedData];
                dispatch_async(dispatch_get_main_queue(), ^{
                    received(object,nil);
                    
                });
            }
        }
    });
}

- (BOOL)registerUnrequestApi:(id<BDAPIUnrequestScheduleProtocol>)api
{
    __block BOOL registerSuccess = NO;
    dispatch_sync(self.apiScheduleQueue, ^{
        NSString* key = MAP_UNREQUEST_KEY(api);
        if ([[_unrequestMap allKeys] containsObject:key])
        {
            registerSuccess = NO;
        }
        else
        {
            [_unrequestMap setObject:api forKey:key];
            registerSuccess = YES;
        }
    });
    return registerSuccess;
}

- (void)sendData:(NSMutableData *)data
{
    dispatch_async(self.apiScheduleQueue, ^{
        [[BDSocketManager sharedInstance] writeDataToSocket:data];
    });
}

#pragma mark - privateAPI
- (void)requestCompletion:(id<BDAPIScheduleProtocol>)api
{
    [_apiRequestMap removeObjectForKey:MAP_REQUEST_KEY(api)];
    
    [_apiResponseMap removeObjectForKey:MAP_RESPONSE_KEY(api)];
}

- (void)timeoutOnTimer:(id)timer
{
    NSDate* date = [NSDate date];
    NSInteger count = [_timeoutMap count];
    if (count == 0)
    {
        return;
    }
    NSArray* allKeys = [_timeoutMap allKeys];
    for (int index = 0; index < count; index ++)
    {
        NSDate* key = allKeys[index];
        id<BDAPIScheduleProtocol> api = (id<BDAPIScheduleProtocol>)[_timeoutMap objectForKey:key];
        NSDate* beginDate = (NSDate*)key;
        NSInteger gap = [date timeIntervalSinceDate:beginDate];
        
        NSInteger apitimeval = [api requestTimeOutTimeInterval];
        if (gap > apitimeval)
        {
            if ([[_apiRequestMap allKeys] containsObject:MAP_REQUEST_KEY(api)])
            {
                RequestCompletion completion = [(BDIMSuperAPI*)api completion];
                completion(nil,JYBError(@"请求超时"));
            }
            
        }
    }
    [_timeoutMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
    }];
}

@end
