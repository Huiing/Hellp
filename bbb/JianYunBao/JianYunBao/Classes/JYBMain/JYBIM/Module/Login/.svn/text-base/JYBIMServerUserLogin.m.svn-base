//
//  JYBIMServerUserLogin.m
//  BDSocketIM
//
//  Created by 冰点 on 16/2/24.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBIMServerUserLogin.h"
#import "BDLoginAPI.h"

@implementation JYBIMServerUserLogin

- (void)loginIMServerWithUserid:(NSString *)userid success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    BDLoginAPI *api = [[BDLoginAPI alloc] init];
    
    [api requestWithObject:userid completion:^(id response, NSError *error) {
        if (!error) {
            if (response) {
                success(response);
            }
        } else {
            failure(error);
        }
    }];
}

@end
