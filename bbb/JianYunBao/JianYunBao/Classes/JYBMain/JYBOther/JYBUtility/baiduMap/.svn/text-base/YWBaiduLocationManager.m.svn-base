//
//  YWBaiduLocationManager.m
//  version 1.0
//
//  Created by 冰点 on 15/5/11.
//  Copyright (c) 2015年 冰点. All rights reserved.
//

#import "YWBaiduLocationManager.h"

@interface YWBaiduLocationManager ()
<
BMKLocationServiceDelegate,
BMKGeoCodeSearchDelegate>


@property (strong, nonatomic) BMKLocationService * locService;//定位
@property (readwrite, nonatomic, copy) getUserCurrentLocationBlock getUserCurrentLocation;

@property (strong, nonatomic) BMKGeoCodeSearch * geocodesearch;//编码
@property (nonatomic, copy) onGetGeoCodeResultBlock onGetGeoCodeResult;
//@property (readwrite, nonatomic, copy) onGetReverseGeoCodeReusltBlock onGetReverseGeoCodeResult;

@end
@implementation YWBaiduLocationManager

+ (id)shareManager
{
    static YWBaiduLocationManager * userLocManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userLocManager = [[YWBaiduLocationManager alloc] init];
    });
    return userLocManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initBMKUserLocation];
    }
    return self;
}

- (void)initBMKUserLocation
{
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    [_locService startUserLocationService];
    
    _geocodesearch = [[BMKGeoCodeSearch alloc] init];
    _geocodesearch.delegate = self;
    
    self.startLocationService = YES;
}

- (void)dealloc {
    if (_locService != nil) {
        _locService = nil;
    }
    if (_geocodesearch != nil) {
        _geocodesearch = nil;
    }
}

- (void)setStartLocationService:(BOOL)startLocationService
{
    if (startLocationService) {
        _locService.delegate = self;
        _geocodesearch.delegate = self;
        [_locService startUserLocationService];
    } else {
        [_locService stopUserLocationService];
        _locService.delegate = nil;
        _geocodesearch.delegate = nil;
    }
}


#pragma mark -


//MARK: BMKLocationServiceDelegate

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation;
{
    _userLatitude = userLocation.location.coordinate.latitude;
    _userLongitude = userLocation.location.coordinate.longitude;
    _coordinate = userLocation.location.coordinate;
    
    _locationSuccess = YES;
    if (self.getUserCurrentLocation) {
        self.getUserCurrentLocation(userLocation.location);
        self.getUserCurrentLocation = nil;
    }
    
    [self onClickReverseGeocodeWithCoordinate:userLocation.location.coordinate complete:self.onGetReverseGeoCodeResult];
    
//    self.startLocationService = NO;
}

/**
 *在停止定位后，会调用此函数
 */
- (void)didStopLocatingUser { }
/**
 *定位失败后，会调用此函数
 *@param error 错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    self.startLocationService = NO;
    _locationSuccess = NO;
    if (_didFailToLocateUserWithError) {
        _didFailToLocateUserWithError();
    }
}

//TODO: 返回定位结果
- (void)getUserLocation:(getUserCurrentLocationBlock)currentLocation
{
    self.getUserCurrentLocation = currentLocation;
}

#pragma mark -

//MARK: BMKGeoCodeSearchDelegate

/**
 *返回地址信息搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结BMKGeoCodeSearch果
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (self.onGetGeoCodeResult) {
        self.onGetGeoCodeResult(result, error);
        self.onGetGeoCodeResult = nil;
    }
    self.startLocationService = NO;
}

/**
 *返回反地理编码搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (self.onGetReverseGeoCodeResult) {
        self.onGetReverseGeoCodeResult(result, error);
        self.onGetReverseGeoCodeResult = nil;
    }
    
    
    _address = result.address;
    _city = result.addressDetail.city;
    self.startLocationService = NO;
}

//TODO: 编码和反编码
-(void)onClickGeocode
{
    BMKGeoCodeSearchOption *geocodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    geocodeSearchOption.city= self.city;
    geocodeSearchOption.address = self.address;
    BOOL flag = [_geocodesearch geoCode:geocodeSearchOption];
    NSAssert(flag, @"geo检索发送失败" );
    (void)flag;
    
}

- (void)onClickReverseGeocode
{
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = self.reverseGeoPoint;
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
//    NSAssert(flag, @"反geo检索发送失败" );
    (void)flag;
    
}

/**
 *  返回地址信息搜索结果
 *
 *  @param city    城市
 *  @param address 地址
 *  @param result  block回调
 */
- (void)onClickGeocodeWithCity:(NSString*)city withAddress:(NSString*)address complete:(onGetGeoCodeResultBlock)result
{
    _city = city;
    _address = address;
    [self onClickGeocode];
    self.onGetGeoCodeResult = result;
}

/**
 *  返回反地理编码搜索结果
 *
 *  @param reverseGeoPoint 地理经纬度
 *  @param result          block回调
 */
- (void)onClickReverseGeocodeWithCoordinate:(CLLocationCoordinate2D)reverseGeoPoint complete:(onGetReverseGeoCodeReusltBlock)result
{
    self.reverseGeoPoint = reverseGeoPoint;
    [self onClickReverseGeocode];
    self.onGetReverseGeoCodeResult = result;
}






@end
