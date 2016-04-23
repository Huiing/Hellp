//
//  JYBSettingEntity.m
//  JianYunBao
//
//  Created by 冰点 on 16/1/26.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBSettingEntity.h"

@implementation JYBSettingEntity

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"list":@"item"};
}

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [JYBSettingItem class]};
}

@end

@implementation JYBSettingItem

@end


