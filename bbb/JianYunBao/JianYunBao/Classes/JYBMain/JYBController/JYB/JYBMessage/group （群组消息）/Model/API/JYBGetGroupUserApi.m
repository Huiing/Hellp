//
//  JYBGetGroupUserApi.m
//  JianYunBao
//
//  Created by 冰点 on 16/3/19.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBGetGroupUserApi.h"

@implementation JYBGetGroupUserApi
{
    NSString *_groupId;
}

- (instancetype)initWithGroupId:(NSString *)groupId
{
    if (self = [super init]) {
        _groupId = groupId;
    }
    return self;
}

- (NSString *)requestUrl
{
    return JYBBCHttpUrl(@"/phone/Group!getUsers.action");
}

- (id)requestArgument
{
    return @{
             @"po.id":_groupId,
             };
}

@end
