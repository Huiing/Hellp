//
//  JYBConfigTool.h
//  JianYunBao
//
//  Created by 宋亚伟 on 16/2/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JYBConfigItem;

@interface JYBConfigTool : NSObject
/**
 *  存储云配置信息
 *
 *  @param config 配置模型
 */
+ (void)saveConfig:(JYBConfigItem *)config;

/**
 *  返回配置信息
 *
 *  @return 配置模型
 */
+ (JYBConfigItem *)config;

/**
 *  删除配置信息
 *
 */
+ (void)removeConfig;

@end
