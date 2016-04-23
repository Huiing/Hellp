//
//  JYBOrderItem.m
//  JianYunBao
//
//  Created by faith on 16/3/16.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBOrderItem.h"
#import "MJExtension.h"

@implementation JYBOrderItem
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
  return @{@"orderId":@"id"};
}

@end
