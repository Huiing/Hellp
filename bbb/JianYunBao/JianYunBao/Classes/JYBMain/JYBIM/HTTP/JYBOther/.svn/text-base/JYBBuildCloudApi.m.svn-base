//
//  BDBuildCloudApi.m
//  BDSocketIM
//
//  Created by 冰点 on 16/2/24.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBBuildCloudApi.h"

@implementation JYBBuildCloudApi
{
    NSString *_enterpriseCode;
}

- (instancetype)initBuildCloudApiWithEnterpriseCode:(NSString *)enterpriseCode
{
    if (self = [super init]) {
        _enterpriseCode = enterpriseCode;
    }
    return self;
}

- (NSString *)requestUrl
{
    return [[NSString alloc] initWithFormat:@"%@/DataService/JianyunBao.aspx",BD_JYBBaseUrl];
}

- (id)requestArgument
{
    return @{@"method":@"GetConfig",
             @"enterpriseCode":_enterpriseCode};
}

@end
