//
//  JYBSignInItemTool.m
//  JianYunBao
//
//  Created by 宋亚伟 on 16/3/12.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBSignInItemTool.h"
#import "FMDB.h"
@implementation JYBSignInItemTool

// static的作用：能保证_queue这个变量只被JYBConfigItemTool.m直接访问
static FMDatabaseQueue * _queue1;
+ (void)initialize{
    
    // 0.获得沙盒中的数据库文件名
    NSString *filename = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"bcClient.sqlite"];
    
    // 1.创建数据库队列
    _queue1 = [FMDatabaseQueue databaseQueueWithPath:filename];
    
    // 2.创表
    [_queue1 inDatabase:^(FMDatabase *db) {
        BOOL result = [db executeUpdate:@"create table if not exists t_signIn (id integer primary key autoincrement,createDate text,lable text);"];
        
        if (result) {
            NSLog(@"创表成功");
        } else {
            NSLog(@"创表失败");
        }
    }];
}

/**
 *  添加
 */
+ (BOOL)addSignInItem:(JYBSignInItem *)signInItem{
    [_queue1 inDatabase:^(FMDatabase *db) {
        BOOL result = [db executeUpdate:@"insert into t_signIn (createDate,lable) values(?,?);", signInItem.createDate, signInItem.lable];
        NSLog(@"%d",result);
        
    }];
    return NO;
    
}

/**
 *  添加
 */
+ (BOOL)addSignInItems:(NSArray *)signInItems{
    [_queue1 inDatabase:^(FMDatabase *db) {
    [db executeUpdate:@"delete from t_signIn;"];
        for (int i = 0; i < [signInItems count]; i ++ ) {
            JYBSignInItem *signInItem = signInItems[i];
            BOOL result = [db executeUpdate:@"insert into t_signIn (createDate,lable) values(?,?);", signInItem.createDate, signInItem.lable];
            NSLog(@"%d",result);
        }

        
    }];
    return NO;
    
}

/**
 *  根据搜索条件获得对应的项
 */
+ (NSArray *)signInItems:(NSString *)creatData{
    // 0.定义数组
    NSMutableArray *signInItems = [NSMutableArray array];
    [_queue1 inDatabase:^(FMDatabase *db) {
        // 1.查询数据
        FMResultSet *rs = [db executeQuery:@"select createDate,lable from t_signIn where createDate like ? order by createDate desc;",[NSString stringWithFormat:@"%%%@%%", creatData]];
        
        // 2.遍历结果集
        while (rs.next) {
            JYBSignInItem *signIn = [[JYBSignInItem alloc]init];
            signIn.createDate = [rs stringForColumn:@"createDate"];
            signIn.lable =[rs stringForColumn:@"lable"];
            [signInItems addObject:signIn];
        }
    }];
    
    return signInItems;
}


@end
