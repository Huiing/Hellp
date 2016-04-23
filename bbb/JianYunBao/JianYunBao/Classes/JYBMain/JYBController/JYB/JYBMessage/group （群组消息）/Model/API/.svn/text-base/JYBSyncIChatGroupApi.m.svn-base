//
//  JYBSyncIChatGroupApi.m
//  JianYunBao
//
//  Created by 冰点 on 16/3/15.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBSyncIChatGroupApi.h"

@implementation JYBSyncIChatGroupApi
{
    JYBIChatType _type;
    NSString *_userId;
    NSString *_name;
    NSString *_startDt;//yyyy-mm-dd
    NSString *_endDt;
    NSInteger _page;
}

- (instancetype)initSyncIChatGroupWithType:(JYBIChatType)type groupName:(NSString *)groupName startDt:(NSString *)startDt endDt:(NSString *)endDt page:(NSInteger)page
{
    if (self = [super init]) {
        _type = type;
        _userId = [RuntimeStatus sharedInstance].userItem.userId;
        _name = bd_isValidKey(groupName) ? groupName : @"";
        _startDt = bd_isValidKey(startDt) ? startDt : @"";
        _endDt = bd_isValidKey(endDt) ? endDt : @"";
        _page = page;
    }
    return self;
}

- (NSString *)requestUrl
{
    return JYBBCHttpUrl(@"/phone/GroupList!list.action");
}

- (id)requestArgument
{
    return @{
             @"userId":_userId,
             @"type":@(_type),
             @"name":_name,
             @"startDt":_startDt,
             @"endDt":_endDt,
             @"page":@(_page)
             };
}

@end
