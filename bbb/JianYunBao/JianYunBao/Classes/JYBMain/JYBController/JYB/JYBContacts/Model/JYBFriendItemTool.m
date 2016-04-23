//
//  JYBFriendItemTool.m
//  JianYunBao
//
//  Created by 宋亚伟 on 16/3/3.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBFriendItemTool.h"
#import "FMDB.h"
#import "JYBFriendItem.h"

@implementation JYBFriendItemTool
static FMDatabaseQueue * _queue2;
+ (void)initialize{
    
    // 0.获得沙盒中的数据库文件名
    NSString *filename = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"bcClient.sqlite"];
    
    // 1.创建数据库队列
    _queue2 = [FMDatabaseQueue databaseQueueWithPath:filename];

    // 2.创表
    [_queue2 inDatabase:^(FMDatabase *db) {
        BOOL result = [db executeUpdate:@"create table if not exists t_friend (id integer primary key autoincrement,sex text,iconPaths text,userName text,friendId text,isContact text,phoneNum text,company text,email text,department text,name text,OrderRank text);"];
        
        if (result) {
            NSLog(@"创表成功");
        } else {
            NSLog(@"创表失败");
        }
    }];
}

+ (BOOL)addFriend:(JYBFriendItem *)friendItem{
    __block BOOL result = NO;
    __block BOOL isRollBack = NO;
    [_queue2 inDatabase:^(FMDatabase *db) {
        [db beginTransaction];
        @try {
            result = [db executeUpdate:@"insert into t_friend (sex,iconPaths,userName,friendId,isContact,phoneNum,company,email,department,name,OrderRank) values(?,?,?,?,?,?,?,?,?,?);", friendItem.sex,friendItem.iconPaths,friendItem.userName,friendItem.friendId,friendItem.isContact,friendItem.phoneNum,friendItem.company,friendItem.email,friendItem.department,friendItem.name,friendItem.OrderRank];
            if (!result)
            {
                isRollBack = YES;
            }
        }
        @catch (NSException *exception) {
            [db rollback];
        }
        @finally {
            if (isRollBack)
            {
                [db rollback];
            }
            else
            {
                [db commit];
            }
        }
    }];
    
    return result;
}

+ (BOOL)addFriends:(NSArray *)friends{
    
    __block BOOL result = NO;
    __block BOOL isRollBack = NO;
    [_queue2 inDatabase:^(FMDatabase *db) {
        [db beginTransaction];
        @try {
            [friends enumerateObjectsUsingBlock:^(JYBFriendItem *friendItem, NSUInteger idx, BOOL * _Nonnull stop) {
                // 1.查询数据
                FMResultSet *rs = [db executeQuery:@"select sex,iconPaths,userName,friendId,isContact,phoneNum,company,email,department,name,OrderRank from t_friend where friendId = ?;",friendItem.friendId];
                
                // 2.遍历结果集
                if (rs.next) {
                    result = [db executeUpdate:@"update t_friend set  sex = ?,iconPaths = ?,userName = ?,isContact = ?,phoneNum = ?,company = ?,email = ?,department = ?,name = ?,OrderRank = ? where friendId = ?;", friendItem.sex,friendItem.iconPaths,friendItem.userName,friendItem.isContact,friendItem.phoneNum,friendItem.company,friendItem.email,friendItem.department,friendItem.name,friendItem.OrderRank,friendItem.friendId];
                    
                }else{
                    result = [db executeUpdate:@"insert into t_friend (sex,iconPaths,userName,friendId,isContact,phoneNum,company,email,department,name,OrderRank) values(?,?,?,?,?,?,?,?,?,?,?);", friendItem.sex,friendItem.iconPaths,friendItem.userName,friendItem.friendId,friendItem.isContact,friendItem.phoneNum,friendItem.company,friendItem.email,friendItem.department,friendItem.name,friendItem.OrderRank];
                }
                if (!result)
                {
                    isRollBack = YES;
                    *stop = YES;
                }
             }];
        }
        @catch (NSException *exception) {
            [db rollback];
        }
        @finally {
            if (isRollBack)
            {
                [db rollback];
            }
            else
            {
                [db commit];
            }
        }
}];
    return result;
}

+ (BOOL)updateFriend:(JYBFriendItem *)friendItem{
    __block BOOL result = NO;
    __block BOOL isRollBack = NO;
    [_queue2 inDatabase:^(FMDatabase *db) {
        [db beginTransaction];
        @try {
             result = [db executeUpdate:@"update t_friend set  sex = ?,iconPaths = ?,userName = ?,isContact = ?,phoneNum = ?,company = ?,email = ?,department = ?,name = ?,OrderRank = ? where friendId = ?;", friendItem.sex,friendItem.iconPaths,friendItem.userName,friendItem.isContact,friendItem.phoneNum,friendItem.company,friendItem.email,friendItem.department,friendItem.name,friendItem.OrderRank,friendItem.friendId];
                if (!result)
                {
                    isRollBack = YES;
                }
        }
        @catch (NSException *exception) {
            [db rollback];
        }
        @finally {
            if (isRollBack)
            {
                [db rollback];
            }
            else
            {
                [db commit];
            }
        }
    }];

    return result;
}

+ (NSArray *)friends{
    // 0.定义数组
    NSMutableArray *friends = [NSMutableArray array];
    [_queue2 inDatabase:^(FMDatabase *db) {
        // 1.查询数据
        FMResultSet *rs = [db executeQuery:@"select sex,iconPaths,userName,friendId,isContact,phoneNum,company,email,department,name,OrderRank from t_friend;"];
        
        // 2.遍历结果集
        while (rs.next) {
            JYBFriendItem *friendItem = [[JYBFriendItem alloc]init];
            friendItem.sex =[rs stringForColumn:@"sex"];
            friendItem.iconPaths =[rs stringForColumn:@"iconPaths"];
            friendItem.userName =[rs stringForColumn:@"userName"];
            friendItem.friendId =[rs stringForColumn:@"friendId"];
            friendItem.isContact =[rs stringForColumn:@"isContact"];
            friendItem.phoneNum =[rs stringForColumn:@"phoneNum"];
            friendItem.company =[rs stringForColumn:@"company"];
            friendItem.email =[rs stringForColumn:@"email"];
            friendItem.department =[rs stringForColumn:@"department"];
            friendItem.name =[rs stringForColumn:@"name"];
            friendItem.OrderRank =[rs stringForColumn:@"OrderRank"];
            
            [friends addObject:friendItem];
        }
    }];
    
    return friends;

}

+ (NSArray *)friends:(NSString *)friendId{
    // 0.定义数组
     NSMutableArray *friends = [NSMutableArray array];
    [_queue2 inDatabase:^(FMDatabase *db) {
        // 1.查询数据
        FMResultSet *rs = [db executeQuery:@"select sex,iconPaths,userName,friendId,isContact,phoneNum,company,email,department,name,OrderRank from t_friend where friendId = ?;",friendId];
        
        // 2.遍历结果集
        while (rs.next) {
            JYBFriendItem *friendItem = [[JYBFriendItem alloc]init];
            friendItem.sex =[rs stringForColumn:@"sex"];
            friendItem.iconPaths =[rs stringForColumn:@"iconPaths"];
            friendItem.userName =[rs stringForColumn:@"userName"];
            friendItem.friendId =[rs stringForColumn:@"friendId"];
            friendItem.isContact =[rs stringForColumn:@"isContact"];
            friendItem.phoneNum =[rs stringForColumn:@"phoneNum"];
            friendItem.company =[rs stringForColumn:@"company"];
            friendItem.email =[rs stringForColumn:@"email"];
            friendItem.department =[rs stringForColumn:@"department"];
            friendItem.name =[rs stringForColumn:@"name"];
            friendItem.OrderRank =[rs stringForColumn:@"OrderRank"];
            
            [friends addObject:friendItem];
        }
    }];
    
    return friends;

}

@end
