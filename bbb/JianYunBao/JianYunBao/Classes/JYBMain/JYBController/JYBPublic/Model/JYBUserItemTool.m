//
//  JYBUserItemTool.m
//  JianYunBao
//
//  Created by 宋亚伟 on 16/2/26.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBUserItemTool.h"
#import "FMDB.h"
#import "JYBUserItem.h"

@implementation JYBUserItemTool

// static的作用：能保证_queue这个变量只被JYBConfigItemTool.m直接访问
static FMDatabaseQueue * _queue;
+ (void)initialize{
    
    // 0.获得沙盒中的数据库文件名
    NSString *filename = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"bcClient.sqlite"];
    
    // 1.创建数据库队列
    _queue = [FMDatabaseQueue databaseQueueWithPath:filename];
    
    // 2.创表
    [_queue inDatabase:^(FMDatabase *db) {
        BOOL result = [db executeUpdate:@"create table if not exists t_user (id integer primary key autoincrement,userId text,sex text,company text,userName text,phoneNum text,iconPathId text,department text,email text,name text,iconPaths text,message text,result text);"];
        
        if (result) {
            NSLog(@"创表成功");
        } else {
            NSLog(@"创表失败");
        }
    }];
}

/**
 *  添加账号
 */
+ (BOOL)addUser:(JYBUserItem *)user{
    [_queue inDatabase:^(FMDatabase *db) {
        
//        [db executeUpdate:@"delete from t_config;"];
        
        [db executeUpdate:@"insert into t_user (userId,sex,company,userName,phoneNum,iconPathId,department,email,name,iconPaths,message,result) values(?,?,?,?,?,?,?,?,?,?,?,?);", user.userId,user.sex,user.company,user.userName,user.phoneNum,user.iconPathId,user.department,user.email,user.name,user.iconPaths,user.message,user.result];
        
    }];
    return NO;

}

/**
 *  更新账号
 */
+ (BOOL)updateUser:(JYBUserItem *)user{
    [_queue inDatabase:^(FMDatabase *db) {
        
        [db executeUpdate:@"update t_student set  sex = ?,company = ?,userName = ?,phoneNum = ?,iconPathId = ?,department = ?,email = ?,name = ?,iconPaths = ?,message = ?,result = ? where userId = ?;",user.sex,user.company,user.userName,user.phoneNum,user.iconPathId,user.department,user.email,user.name,user.iconPaths,user.message,user.result, user.userId];
        
    }];
    return NO;
    
}

/**
 *  获得所有的账号
 */
+ (NSArray *)users{
    // 0.定义数组
    NSMutableArray *users = [NSMutableArray array];
    [_queue inDatabase:^(FMDatabase *db) {
        // 1.查询数据
        FMResultSet *rs = [db executeQuery:@"select userId,sex,company,userName,phoneNum,iconPathId,department,email,name,iconPaths,message,result from t_user;"];
        
        // 2.遍历结果集
        while (rs.next) {
            JYBUserItem *user = [[JYBUserItem alloc]init];
            user.userId =[rs stringForColumn:@"userId"];
            user.sex =[rs stringForColumn:@"sex"];
            user.company =[rs stringForColumn:@"company"];
            user.userName =[rs stringForColumn:@"userName"];
            user.phoneNum =[rs stringForColumn:@"phoneNum"];
            user.iconPathId =[rs stringForColumn:@"iconPathId"];
            user.department =[rs stringForColumn:@"department"];
            user.email =[rs stringForColumn:@"email"];
            user.name =[rs stringForColumn:@"name"];
            user.iconPaths =[rs stringForColumn:@"iconPaths"];
            user.message =[rs stringForColumn:@"message"];
            user.result =[rs stringForColumn:@"result"];

            [users addObject:user];
        }
    }];
    
    return users;
}
/**
 *  根据搜索条件获得对应的账号项
 */
+ (NSArray *)users:(NSString *)userId{
    // 0.定义数组
    NSMutableArray *users = [NSMutableArray array];
    [_queue inDatabase:^(FMDatabase *db) {
        // 1.查询数据
        FMResultSet *rs = [db executeQuery:@"select userId,sex,company,userName,phoneNum,iconPathId,department,email,name,iconPaths,message,result from t_user where userId = ?;",userId];
        
        // 2.遍历结果集
        while (rs.next) {
            JYBUserItem *user = [[JYBUserItem alloc]init];
            user.userId =[rs stringForColumn:@"userId"];
            user.sex =[rs stringForColumn:@"sex"];
            user.company =[rs stringForColumn:@"company"];
            user.userName =[rs stringForColumn:@"userName"];
            user.phoneNum =[rs stringForColumn:@"phoneNum"];
            user.iconPathId =[rs stringForColumn:@"iconPathId"];
            user.department =[rs stringForColumn:@"department"];
            user.email =[rs stringForColumn:@"email"];
            user.name =[rs stringForColumn:@"name"];
            user.iconPaths =[rs stringForColumn:@"iconPaths"];
            user.message =[rs stringForColumn:@"message"];
            user.result =[rs stringForColumn:@"result"];
            
            [users addObject:user];
        }
    }];
    
    return users;
}

@end
