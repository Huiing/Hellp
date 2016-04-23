//
//  JYBDevice.h
//  JianYunBao
//
//  Created by 宋亚伟 on 16/3/11.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYBDevice : NSObject
+ (instancetype)sharedDevice;
//获取手机具体型号
- (NSString*)deviceString;
//这是本地host的IP地址
- (NSString *) localIPAddress;
// 获取系统版本
- (NSString *)systemVersion;
// 获取网络类型
- (NSString *)networkType;
// 获取设备id
- (NSString *)UUIDString;
@end
