//
//  BDAppLoginApi.m
//  BDSocketIM
//
//  Created by 冰点 on 16/2/24.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBAppLoginApi.h"

@implementation JYBAppLoginApi
{
    NSString *_username;
    NSString *_password;
    NSString *_enterpriseCode;
}

- (instancetype)initAppLoginApiWithUsername:(NSString *)username password:(NSString *)password enterpriseCode:(NSString *)enterpriseCode
{
    if (self = [super init]) {
        _username = username;
        _password = password;
        _enterpriseCode = enterpriseCode;
    }
    return self;
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

- (NSString *)requestUrl
{
    return JYBErpHttpUrl(@"/jianyunbao.aspx?");;
}

- (id)requestArgument
{
    NSDictionary *param = @{@"method":@"login",
                            @"enterpriseCode":_enterpriseCode,
                            @"label":_username,
                            @"password":_password};
    return param;
}

@end
