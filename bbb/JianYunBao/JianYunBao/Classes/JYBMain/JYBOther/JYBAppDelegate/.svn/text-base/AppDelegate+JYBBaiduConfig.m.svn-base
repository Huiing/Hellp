//
//  AppDelegate+JYBBaiduConfig.m
//  baiduMapTest
//
//  Created by 宋亚伟 on 16/3/11.
//  Copyright © 2016年 SYW. All rights reserved.
//

#import "AppDelegate+JYBBaiduConfig.h"

@interface AppDelegate () <BMKGeneralDelegate>

@end
BMKMapManager *_mapManager;
@implementation AppDelegate (JYBBaiduConfig)

- (void)setupBaidu
{
    _mapManager = [[BMKMapManager alloc]init];
    //csZlkyBxiqSkaBlOsW0lGSsD
    //3iXwqbVsGtig7k9G2o6T9f6t com.rnd.GuangHuaSocialCircle
    //izxmY5r4nO5XZzEilqyXR0w7 com.Michael.GuangHuaSocialCircle
    //zfhGNvUAQztHRI25KLzdwPS9 - Release//com.guanghua.GuanghuaEJia
//    BOOL ret = [_mapManager start:@"7vGmldxTqLaVeCvlb5lLlovZ" generalDelegate:self];
    BOOL ret = [_mapManager start:JYB_BaiDu_MapKey generalDelegate:self];
    
    if (!ret) {
        NSLog(@"manager start failed!");
    }
}

- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}


@end
