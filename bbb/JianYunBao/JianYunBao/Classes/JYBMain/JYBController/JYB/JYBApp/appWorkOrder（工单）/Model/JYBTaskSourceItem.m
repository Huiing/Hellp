//
//  JYBTaskSourceItem.m
//  JianYunBao
//
//  Created by faith on 16/3/15.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBTaskSourceItem.h"
#import "MJExtension.h"
@implementation JYBTaskSourceItem
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
  return @{@"taskId":@"id"};
}

@end
