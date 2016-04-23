//
//  JYBIMLogin.h
//  BDSocketIM
//
//  Created by 冰点 on 16/2/26.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYBIMLogin : NSObject

+ (JYBIMLogin *)parseFromData:(NSData *)data;

@property (nonatomic, readonly, assign) NSTimeInterval s_timestamp;//服务器端始终 ms
@property (nonatomic, readonly, assign) NSTimeInterval c_timestamp;//终端始终
@property (nonatomic, readonly, copy) NSString *port;//终端IP
@end
