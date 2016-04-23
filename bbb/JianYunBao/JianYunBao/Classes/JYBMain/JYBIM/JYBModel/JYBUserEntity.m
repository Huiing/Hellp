//
//  JYBUserEntity.m
//  BDSocketIM
//
//  Created by 冰点 on 16/2/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBUserEntity.h"

@implementation JYBUserEntity

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"userid":@"id"};
}

@end
