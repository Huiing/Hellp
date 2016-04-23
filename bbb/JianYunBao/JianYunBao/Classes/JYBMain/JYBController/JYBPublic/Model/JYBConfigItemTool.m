//
//  JYBConfigItemTool.m
//  JianYunBao
//
//  Created by 宋亚伟 on 16/2/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBConfigItemTool.h"
#import "JYBConfigItem.h"
#import "FMDB.h"

@implementation JYBConfigItemTool
// static的作用：能保证_queue这个变量只被JYBConfigItemTool.m直接访问
static FMDatabaseQueue * _queue;
+ (void)initialize{
    
    // 0.获得沙盒中的数据库文件名
    NSString *filename = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"bcClient.sqlite"];
    
    // 1.创建数据库队列
    _queue = [FMDatabaseQueue databaseQueueWithPath:filename];
    
    // 2.创表
    [_queue inDatabase:^(FMDatabase *db) {
        BOOL result = [db executeUpdate:@"create table if not exists t_config (id integer primary key autoincrement,isLocData text,androidAppSize text,iphoneDownLoad text,bcHttpUrl text,isAutoPlayAudio text,xtglhtUrl text,iphoneAppSize text,androidVersionCode text,isServerStop text,enable text,erpRootUrl text,androidDownLoad text,compName text,isForceUpdate text,erpHttpUrl text,enterpriseCode text,bcTcpUrl text,message text,stopOverTime text,bcfHttpUrl text,result text,iphoneVersion text,autoid text);"];
        
        if (result) {
            NSLog(@"创表成功");
        } else {
            NSLog(@"创表失败");
        }
    }];
}

+ (BOOL)addConfig:(JYBConfigItem *)config{

    [_queue inDatabase:^(FMDatabase *db) {
 
        [db executeUpdate:@"delete from t_config;"];
        
        [db executeUpdate:@"insert into t_config (isLocData,androidAppSize,iphoneDownLoad,bcHttpUrl,isAutoPlayAudio,xtglhtUrl,iphoneAppSize,androidVersionCode,isServerStop,enable,erpRootUrl,androidDownLoad,compName,isForceUpdate,erpHttpUrl,enterpriseCode,bcTcpUrl,message,stopOverTime,bcfHttpUrl,result,iphoneVersion,autoid) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);", config.isLocData,config.androidAppSize,config.iphoneDownLoad,config.bcHttpUrl,config.isAutoPlayAudio,config.xtglhtUrl,config.iphoneAppSize,config.androidVersionCode,config.isServerStop,config.enable,config.erpRootUrl,config.androidDownLoad,config.compName,config.isForceUpdate,config.erpHttpUrl,config.enterpriseCode,config.bcTcpUrl,config.message,config.stopOverTime,config.bcfHttpUrl,config.result,config.iphoneVersion,config.autoid];
        
    }];
    return NO;
}

+ (JYBConfigItem *)config{
//    __weak typeof(self) weakSelf = [self class];
    JYBConfigItem *item = nil;
    [_queue inDatabase:^(FMDatabase *db) {
        // 1.查询数据
        FMResultSet *rs = [db executeQuery:@"select isLocData,androidAppSize,iphoneDownLoad,bcHttpUrl,isAutoPlayAudio,xtglhtUrl,iphoneAppSize,androidVersionCode,isServerStop,enable,erpRootUrl,androidDownLoad,compName,isForceUpdate,erpHttpUrl,enterpriseCode,bcTcpUrl,message,stopOverTime,bcfHttpUrl,result,iphoneVersion,autoid from t_config;"];
        
        // 2.遍历结果集
        while (rs.next) {
//            item = [[JYBConfigItem alloc] init];
            NSString *androidAppSize = [rs stringForColumn:@"androidAppSize"];
            NSString *bcHttpUrl = [rs stringForColumn:@"bcHttpUrl"];
            
            NSLog(@" %@ %@", androidAppSize, bcHttpUrl);
        }
    }];
    return item;
}

+ (NSArray *)configs{
    // 0.定义数组
    NSMutableArray *configs = nil;
    [_queue inDatabase:^(FMDatabase *db) {
        // 1.查询数据
        FMResultSet *rs = [db executeQuery:@"select isLocData,androidAppSize,iphoneDownLoad,bcHttpUrl,isAutoPlayAudio,xtglhtUrl,iphoneAppSize,androidVersionCode,isServerStop,enable,erpRootUrl,androidDownLoad,compName,isForceUpdate,erpHttpUrl,enterpriseCode,bcTcpUrl,message,stopOverTime,bcfHttpUrl,result,iphoneVersion,autoid from t_config;"];
        
        // 2.遍历结果集
        while (rs.next) {
            NSString *androidAppSize = [rs stringForColumn:@"androidAppSize"];
            NSString *bcHttpUrl = [rs stringForColumn:@"bcHttpUrl"];
            
            NSLog(@" %@ %@", androidAppSize, bcHttpUrl);
        }
    }];
    
    return configs;
    
}

@end
