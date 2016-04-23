//
//  JYBDevice.m
//  JianYunBao
//
//  Created by 宋亚伟 on 16/3/11.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBDevice.h"
#import "sys/utsname.h"//加入了检测系统设备型号

typedef enum {
    NetWorkType_None = 0,
    NetWorkType_WIFI,
    NetWorkType_2G,
    NetWorkType_3G,
} NetWorkType;

@implementation JYBDevice
 static JYBDevice * _device = nil;
+ (instancetype)sharedDevice {
   
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _device = [[JYBDevice alloc] init];
    });
    return _device;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _device = [super allocWithZone:zone];
    });
    return _device;
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return _device;
}

#pragma mark - 获取手机具体型号
- (NSString*)deviceString
{
    // 需要#import "sys/utsname.h"
    //手机型号。
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *correspondVersion = [NSString stringWithFormat:@"%s", systemInfo.machine];
    
    if ([correspondVersion isEqualToString:@"i386"])        return@"Simulator";
    if ([correspondVersion isEqualToString:@"x86_64"])       return @"Simulator";
    
    if ([correspondVersion isEqualToString:@"iPhone1,1"])   return@"iPhone 1";
    if ([correspondVersion isEqualToString:@"iPhone1,2"])   return@"iPhone 3";
    if ([correspondVersion isEqualToString:@"iPhone2,1"])   return@"iPhone 3S";
    if ([correspondVersion isEqualToString:@"iPhone3,1"] || [correspondVersion isEqualToString:@"iPhone3,2"])   return@"iPhone 4";
    if ([correspondVersion isEqualToString:@"iPhone4,1"])   return@"iPhone 4S";
    if ([correspondVersion isEqualToString:@"iPhone5,1"] || [correspondVersion isEqualToString:@"iPhone5,2"])   return @"iPhone 5";
    if ([correspondVersion isEqualToString:@"iPhone5,3"] || [correspondVersion isEqualToString:@"iPhone5,4"])   return @"iPhone 5C";
    if ([correspondVersion isEqualToString:@"iPhone6,1"] || [correspondVersion isEqualToString:@"iPhone6,2"])   return @"iPhone 5S";
    if ([correspondVersion isEqualToString:@"iPhone7,1"])   return @"iPhone 6 Plus";
    if ([correspondVersion isEqualToString:@"iPhone7,2"])   return @"iPhone 6";
    if ([correspondVersion isEqualToString:@"iPhone8,1"])   return @"iPhone 6s";
    if ([correspondVersion isEqualToString:@"iPhone8,2"])   return @"iPhone 6";
    
    if ([correspondVersion isEqualToString:@"iPod1,1"])     return@"iPod Touch 1";
    if ([correspondVersion isEqualToString:@"iPod2,1"])     return@"iPod Touch 2";
    if ([correspondVersion isEqualToString:@"iPod3,1"])     return@"iPod Touch 3";
    if ([correspondVersion isEqualToString:@"iPod4,1"])     return@"iPod Touch 4";
    if ([correspondVersion isEqualToString:@"iPod5,1"])     return@"iPod Touch 5";
    
    if ([correspondVersion isEqualToString:@"iPad1,1"])     return@"iPad 1";
    if ([correspondVersion isEqualToString:@"iPad2,1"] || [correspondVersion isEqualToString:@"iPad2,2"] || [correspondVersion isEqualToString:@"iPad2,3"] || [correspondVersion isEqualToString:@"iPad2,4"])     return@"iPad 2";
    if ([correspondVersion isEqualToString:@"iPad2,5"] || [correspondVersion isEqualToString:@"iPad2,6"] || [correspondVersion isEqualToString:@"iPad2,7"] )      return @"iPad Mini";
    if ([correspondVersion isEqualToString:@"iPad3,1"] || [correspondVersion isEqualToString:@"iPad3,2"] || [correspondVersion isEqualToString:@"iPad3,3"] || [correspondVersion isEqualToString:@"iPad3,4"] || [correspondVersion isEqualToString:@"iPad3,5"] || [correspondVersion isEqualToString:@"iPad3,6"])      return @"iPad 3";
    if ([correspondVersion isEqualToString:@"iPad4,4"] || [correspondVersion isEqualToString:@"iPad4,5"] || [correspondVersion isEqualToString:@"iPad4,6"] || [correspondVersion isEqualToString:@"iPad4,7"] || [correspondVersion isEqualToString:@"iPad4,8"] || [correspondVersion isEqualToString:@"iPad4,9"] || [correspondVersion isEqualToString:@"iPad2,5"] || [correspondVersion isEqualToString:@"iPad2,6"] || [correspondVersion isEqualToString:@"iPad2,7"])     return @"iPad Mini";//检测ipad mini 和4s一样需要调整
    return correspondVersion;
}

#pragma mark - 获取IP地址
//获取host的名称
- (NSString *) hostname
{
    char baseHostName[256]; // Thanks, Gunnar Larisch
    int success = gethostname(baseHostName, 255);
    if (success != 0) return nil;
    baseHostName[255] = '/0';
    
#if TARGET_IPHONE_SIMULATOR
    return [NSString stringWithFormat:@"%s", baseHostName];
#else
    return [NSString stringWithFormat:@"%s", baseHostName];
#endif
}

//这是本地host的IP地址
- (NSString *) localIPAddress
{
    struct hostent *host = gethostbyname([[self hostname] UTF8String]);
    if (!host) {herror("resolv"); return nil;}
    struct in_addr **list = (struct in_addr **)host->h_addr_list;
    return [NSString stringWithCString:inet_ntoa(*list[0]) encoding:NSUTF8StringEncoding];
}

#pragma mark - 获取系统版本
- (NSString *)systemVersion{
    return  [NSString stringWithFormat:@"IOS %@",[[UIDevice currentDevice] systemVersion]];
}

#pragma mark - 获取网络类型
- (NSString *)networkType{

    UIApplication *application = [UIApplication sharedApplication];
    NSArray *subviews = [[[application valueForKey:@"statusBar"] valueForKey:@"foregroundView"]subviews];
    NSNumber *dataNetWorkItemView = nil;
    for (id subView in subviews) {
        　　if ([subView isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            dataNetWorkItemView = subView;
            break;
        }
    }
    NSString  *networkType = @"none";
    switch ([[dataNetWorkItemView valueForKey:@"dataNetworkType"] integerValue]) {
        case 0:
            NSLog(@"No wifi or cellular");
            networkType = @"none";
            break;
        case 1:
            NSLog(@"2G");
            networkType = @"2G";
            break;
        case 2:
            NSLog(@"3G");
            networkType = @"3G";
            break;
        default:      
            NSLog(@"Wifi");
            networkType = @"Wifi";
            break;
    }
    return networkType;
}

#pragma mark - 获取设备id
- (NSString *)UUIDString{

    return [[UIDevice currentDevice].identifierForVendor UUIDString];
}
@end
