//
//  JYBSettingEntity.h
//  JianYunBao
//
//  Created by 冰点 on 16/1/26.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYBTypeEntity.h"

@class JYBSettingItem;
@interface JYBSettingEntity : NSObject

@property (nonatomic, assign) NSInteger itemId;

@property (nonatomic, strong) NSArray<JYBSettingItem *> *list;

@end

@interface JYBSettingItem : JYBTypeEntity

@end

