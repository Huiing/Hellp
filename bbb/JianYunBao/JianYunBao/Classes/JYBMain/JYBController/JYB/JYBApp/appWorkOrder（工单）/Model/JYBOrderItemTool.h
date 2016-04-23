//
//  JYBOrderItemTool.h
//  JianYunBao
//
//  Created by 正 on 16/3/18.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JYBOrderItem;
@interface JYBOrderItemTool : NSObject

//添加一条
+ (BOOL)addOrder:(JYBOrderItem *)item;

//更新一条
+ (BOOL)updateOrder:(JYBOrderItem *)item;

//查询数据
+ (NSArray *)orderArray;

//添加一组
+ (BOOL)addArray:(NSArray *)array;

//更新一组
+ (BOOL)updateArray:(NSArray *)array;

//查询工单id
+ (JYBOrderItem *)queryOrderId:(NSString *)orderId;

@end
