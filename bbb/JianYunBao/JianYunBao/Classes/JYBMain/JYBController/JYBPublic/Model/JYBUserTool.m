//
//  JYBUserTool.m
//  JianYunBao
//
//  Created by 宋亚伟 on 16/2/29.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBUserTool.h"
#import "JYBUserItem.h"
// 账号的配置路径
#define JYBUserItemPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"UserItem.archive"]

@implementation JYBUserTool


+ (void)saveUser:(JYBUserItem *)user
{
    // 自定义对象的存储必须用NSKeyedArchiver，不再有什么writeToFile方法
    [NSKeyedArchiver archiveRootObject:user toFile:JYBUserItemPath];
}

+ (void)removeUser{
    //删除归档文件
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    if ([defaultManager isDeletableFileAtPath:JYBUserItemPath]) {
        [defaultManager removeItemAtPath:JYBUserItemPath error:nil];
    }
}


+ (JYBUserItem *)user
{
    // 加载模型
    JYBUserItem *user = [NSKeyedUnarchiver unarchiveObjectWithFile:JYBUserItemPath];
    return user;
}


@end
