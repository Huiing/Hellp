//
//  JYBConfigTool.m
//  JianYunBao
//
//  Created by 宋亚伟 on 16/2/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBConfigTool.h"
#import "JYBConfigItem.h"
// 账号的配置路径
#define JYBConfigItemPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"ConfigItem.archive"]

@implementation JYBConfigTool


+ (void)saveConfig:(JYBConfigItem *)config
{
    // 自定义对象的存储必须用NSKeyedArchiver，不再有什么writeToFile方法
    [NSKeyedArchiver archiveRootObject:config toFile:JYBConfigItemPath];
}

+ (void)removeConfig{
    //删除归档文件
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    if ([defaultManager isDeletableFileAtPath:JYBConfigItemPath]) {
        [defaultManager removeItemAtPath:JYBConfigItemPath error:nil];
    }
}


+ (JYBConfigItem *)config
{
    // 加载模型
    JYBConfigItem *config = [NSKeyedUnarchiver unarchiveObjectWithFile:JYBConfigItemPath];
      return config;
}


@end
