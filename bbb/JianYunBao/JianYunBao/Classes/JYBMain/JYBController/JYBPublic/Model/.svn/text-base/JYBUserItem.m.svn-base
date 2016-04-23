//
//  JYBUserItem.m
//  JianYunBao
//
//  Created by 宋亚伟 on 16/2/26.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBUserItem.h"
#import "MJExtension.h"

@implementation JYBUserItem

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"userId":@"id"};
}

/**
 归档的实现
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        [self mj_decode:decoder];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [self mj_encode:encoder];
}

@end
