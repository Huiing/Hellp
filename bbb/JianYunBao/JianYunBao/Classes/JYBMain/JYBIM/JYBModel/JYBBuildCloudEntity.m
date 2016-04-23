//
//  JYBBuildCloudEntity.m
//  BDSocketIM
//
//  Created by 冰点 on 16/2/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBBuildCloudEntity.h"

@implementation JYBBuildCloudEntity
{
    NSString *_domain;
    NSInteger _port;
}

- (void)setBcTcpUrl:(NSString *)bcTcpUrl
{
    _bcTcpUrl = bcTcpUrl;
    NSArray *arr = [bcTcpUrl componentsSeparatedByString:@":"];
    if ([arr count]) {
        _domain = [arr firstObject];
        _port = [[arr lastObject] integerValue];
    }
}


- (NSString *)jyb_domain
{
    return _domain;
}

- (NSInteger)jyb_port
{
    return _port;
}

@end
