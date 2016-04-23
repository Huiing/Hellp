//
//  JYBOrderItemTool.m
//  JianYunBao
//
//  Created by 正 on 16/3/18.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBOrderItemTool.h"
#import "JYBOrderItem.h"
#import "FMDB.h"

@implementation JYBOrderItemTool

static FMDatabaseQueue * _orderQueue;
+ (void)initialize{
    //获取文件路径
    NSString * fileName = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"workOrderList.sqlite"];
    NSLog(@"filename:%@",fileName);
    //创建队列
    _orderQueue = [FMDatabaseQueue databaseQueueWithPath:fileName];
    //建表
    [_orderQueue inDatabase:^(FMDatabase *db) {
        BOOL result = [db executeUpdate:@"create table if not exists orderList (id integer primary key autoincrement,orderId text,titleName text,createUserName text,createUserId text,responUser text,createDate text,emergencyState text,importantState text,workState text);"];
        if(result){
            NSLog(@"工单建表成功");
        }else{
            NSLog(@"工单建表失败");
        }
    }];
}
//添加一条
+ (BOOL)addOrder:(JYBOrderItem *)item{
    __block BOOL result = NO;
    [_orderQueue inDatabase:^(FMDatabase *db) {
        result = [db executeUpdate:@"insert into orderList (orderId,titleName,createUserName,createUserId,responUser,createDate,emergencyState,importantState,workState) values(?,?,?,?,?,?,?,?,?);",item.orderId,item.titleName,item.createUserName,item.createUserId,item.responUser,item.createDate,item.emergencyState,item.importantState,item.workState];
    }];
    return result;
}
//添加一组
+ (BOOL)addArray:(NSArray *)array{
    BOOL result = NO;
    for (JYBOrderItem * item in array){
        result = [self addOrder:item];
    }
    return result;
}
//更新一条
+ (BOOL)updateOrder:(JYBOrderItem *)item{
    __block BOOL result = NO;
    [_orderQueue inDatabase:^(FMDatabase *db) {
        result = [db executeUpdate:@"update orderList set orderId = ?,titleName = ?,createUserName = ?,createUserId = ?,responUser = ?,createDate = ?,emergencyState = ?,importantState = ?,workState = ?;",item.orderId,item.titleName,item.createUserName,item.createUserId,item.responUser,item.createDate,item.emergencyState,item.importantState,item.workState];
    }];
    return result;
}
//更新一组
+ (BOOL)updateArray:(NSArray *)array{
    BOOL result = NO;
    for (JYBOrderItem * item in array){
        result = [self updateOrder:item];
    }
    return result;
}
//查询
+ (NSArray *)orderArray{
    NSMutableArray *orders = [NSMutableArray array];
    [_orderQueue inDatabase:^(FMDatabase *db) {
        FMResultSet * rs = [db executeQuery:@"select * from orderList;"];
        //遍历
        while (rs.next) {
            JYBOrderItem * item = [[JYBOrderItem alloc] init];
            item.orderId = [rs stringForColumn:@"orderId"];
            item.titleName = [rs stringForColumn:@"titleName"];
            item.createUserName = [rs stringForColumn:@"createUserName"];
            item.createUserId = [rs stringForColumn:@"createUserId"];
            item.responUser = [rs stringForColumn:@"responUser"];
            item.createDate = [rs stringForColumn:@"createDate"];
            item.emergencyState = [rs stringForColumn:@"emergencyState"];
            item.importantState = [rs stringForColumn:@"importantState"];
            item.workState = [rs stringForColumn:@"workState"];
            [orders addObject:item];
        }
    }];
    return orders;
}
//查询工单id
+ (JYBOrderItem *)queryOrderId:(NSString *)orderId{
    __block JYBOrderItem * item = nil;
    [_orderQueue inDatabase:^(FMDatabase *db) {
        FMResultSet * rs = [db executeQuery:@"select * from orderList where orderId = ?;",orderId];
        
        if (rs.next){
            item = [[JYBOrderItem alloc] init];
            item.orderId = [rs stringForColumn:@"orderId"];
            item.titleName = [rs stringForColumn:@"titleName"];
            item.createUserName = [rs stringForColumn:@"createUserName"];
            item.createUserId = [rs stringForColumn:@"createUserId"];
            item.responUser = [rs stringForColumn:@"responUser"];
            item.createDate = [rs stringForColumn:@"createDate"];
            item.emergencyState = [rs stringForColumn:@"emergencyState"];
            item.importantState = [rs stringForColumn:@"importantState"];
            item.workState = [rs stringForColumn:@"workState"];
        }
    }];
    return item;
}

@end
