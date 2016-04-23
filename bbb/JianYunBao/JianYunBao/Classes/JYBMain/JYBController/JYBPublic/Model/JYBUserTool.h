//
//  JYBUserTool.h
//  JianYunBao
//
//  Created by 宋亚伟 on 16/2/29.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JYBUserItem;

@interface JYBUserTool : NSObject

+ (void)saveUser:(JYBUserItem *)user;


+ (JYBUserItem *)user;


+ (void)removeUser;


@end
