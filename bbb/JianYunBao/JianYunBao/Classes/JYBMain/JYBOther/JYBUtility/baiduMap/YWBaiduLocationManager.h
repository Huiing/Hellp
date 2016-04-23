//
//  YWBaiduLocationManager.h
//  version 1.0
//
//  Created by 冰点 on 15/5/11.
//  Copyright (c) 2015年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <BaiduMapAPI/BMapKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

typedef void (^getUserCurrentLocationBlock)(CLLocation *loc);
///编码结果
typedef void (^onGetGeoCodeResultBlock)(BMKGeoCodeResult *result, BMKSearchErrorCode errorCode);
///反编码结果
typedef void (^onGetReverseGeoCodeReusltBlock)(BMKReverseGeoCodeResult *result, BMKSearchErrorCode errorCode);

@interface YWBaiduLocationManager : NSObject

+ (id)shareManager;

///获取用户当前位置
- (void)getUserLocation:(getUserCurrentLocationBlock)currentLocation;

///开启定位---YES开启---NO关闭 默认为YES
@property (assign, nonatomic) BOOL startLocationService;

///YES成功NO失败
@property (assign, nonatomic, readonly, getter=isLocationSuccess) BOOL locationSuccess;

@property (nonatomic, copy) void(^didFailToLocateUserWithError)(void);
///定位后的纬度
@property (assign, nonatomic, readonly) double userLatitude;
///定位后的经度
@property (assign, nonatomic, readonly) double userLongitude;
///定位后的坐标集合
@property (assign, nonatomic, readonly) CLLocationCoordinate2D coordinate;


///地址
@property (nonatomic, strong) NSString *address;
///城市名
@property (nonatomic, strong) NSString *city;

///经纬度
@property (nonatomic, assign) CLLocationCoordinate2D reverseGeoPoint;
@property (nonatomic, copy) onGetReverseGeoCodeReusltBlock onGetReverseGeoCodeResult;

/**
 *  返回地址信息搜索结果
 *
 *  @param city    城市
 *  @param address 地址
 *  @param result  block回调
 */
- (void)onClickGeocodeWithCity:(NSString*)city withAddress:(NSString*)address complete:(onGetGeoCodeResultBlock)result;

/**
 *  返回反地理编码搜索结果
 *
 *  @param reverseGeoPoint 地理经纬度
 *  @param result          block回调
 */
- (void)onClickReverseGeocodeWithCoordinate:(CLLocationCoordinate2D)reverseGeoPoint complete:(onGetReverseGeoCodeReusltBlock)result;

@end





/**
 ========== ========== ========== ========== ========== ========== ========== ==========
 
                                    ========== ========== ========== ==========
                                    ||                    使用方法：                  ||
                                    ========== ========== ========== ==========
 
 ///调用单利后默认开启定位
 YWBaiduLocationManager*locationManager = [YWBaiduLocationManager shareManager];
 ///开启定位
 locationManager.startLocationService = YES;
 
 ///默认
 NSLog(@"address - %@",locationManager.address);
 NSLog(@"userLatitude - %.8f, userLongitude - %.8f", locationManager.userLatitude, locationManager.userLongitude);
 
 
 
 *****************************************【定位】*************************************************
 判断是否定位成功
 失败：开启定位服务重新定位，通过block回调重新获取定位后的用户地理位置，根据返回值处理业务逻辑
 成功：获取到用户当前地理位置，处理业务逻辑。。。。
 **********************************************************************************

if (![locationManager isLocationSuccess]) {
    [locationManager setStartLocationService:YES];
    [locationManager getUserLocation:^(CLLocation *loc) {
        double lat = loc.coordinate.latitude;
        double lng = loc.coordinate.longitude;
        NSLog(@"用户当前经纬度：lat:%.8f ,lng:%.8f",lat, lng);
    }];
} else {
    NSLog(@"定位Success" );
    NSLog(@"%@",locationManager.address);
    NSLog(@"用户当前经纬度：lat:%.8f ,lng:%.8f", locationManager.userLatitude, locationManager.userLongitude);
}

 **************************************反编码******************************************
 默认根据定位后的经纬度进行反编码
 ************************************************************************

locationManager.onGetReverseGeoCodeResult = ^(BMKReverseGeoCodeResult *result, BMKSearchErrorCode errorCode){
    [self printf:result.addressDetail.city];
}

 **************************************反编码********************************************
 设置条件进行反编码block回调返回值，
 根据返回值处理业务逻辑
 **************************************************************************
CLLocationCoordinate2D coordinate2D = CLLocationCoordinate2DMake(40.04295876, 116.31483994);

[locationManager onClickReverseGeocodeWithCoordinate:coordinate2D complete:^(BMKReverseGeoCodeResult *result, BMKSearchErrorCode errorCode) {
    NSLog(@"反编码 address - %@",result.addressDetail.city);
}];

 ***************************************编码******************************************
 设置条件进行编码block回调返回值，
 根据返回值处理业务逻辑
 ************************************************************************
[[YWBaiduLocationManager shareManager] onClickGeocodeWithCity:@"北京" withAddress:@"上地西街金隅嘉华大厦" complete:^(BMKGeoCodeResult *result, BMKSearchErrorCode errorCode) {
    NSLog(@"geocode - %.8f, %.8f",result.location.latitude, result.location.longitude);
    _lat = result.location.latitude;
    [self printf:_lat];
}];
 
 ========== ========== ========== ========== ========== ========== ========== ==========

 **/












