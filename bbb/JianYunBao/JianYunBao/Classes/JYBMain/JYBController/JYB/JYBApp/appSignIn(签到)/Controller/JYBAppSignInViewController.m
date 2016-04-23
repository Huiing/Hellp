//
//  JYBBaseCalendarViewController.m
//  JianYunBao
//
//  Created by 宋亚伟 on 16/3/10.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBAppSignInViewController.h"
#import "YHBaseCalendarView.h"
#import "YHBaseDateModel.h"
#import "YWBaiduLocationManager.h"
#import "SYWCommonRequest.h"
#import "JYBSignInItem.h"
#import "JYBSignInTableViewCell.h"
#import "JYBSignInItemTool.h"
#import "JYBDevice.h"


@interface JYBAppSignInViewController ()<YHBaseCalendarViewDelegate,TouchTableDelegate,BMKGeoCodeSearchDelegate>

@property (weak, nonatomic) IBOutlet UIView *dateView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) YHBaseCalendarView *calendarView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (nonatomic, strong) YHBaseDateModel *selectedModel;
@property (nonatomic, strong) NSMutableArray *markArray;
@property (weak, nonatomic) IBOutlet UIView *showNoDataView;
@property (weak, nonatomic) IBOutlet BDBaseTableView *table;
@property (nonatomic, strong) NSMutableArray *signArray;
@end

@implementation JYBAppSignInViewController

- (NSMutableArray *)signArray{
    if (_signArray == nil) {
        _signArray = [NSMutableArray array];
    }
    if ([_signArray count]) {
        self.table.hidden = NO;
        self.showNoDataView.hidden = YES;
    }else{
        self.table.hidden = YES;
        self.showNoDataView.hidden = NO;
    }
    return _signArray;
}

- (NSMutableArray *)markArray{
    if (_markArray == nil) {
        _markArray = [NSMutableArray array];
    }
    return _markArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    [self getSignList];
    [self addNavgationBarButtonWithImage:nil title:@"签到" titleColor:[UIColor whiteColor] addTarget:self action:@selector(signInClick) direction:JYBNavigationBarButtonDirectionRight];
    YHBaseCalendarView *view = [[YHBaseCalendarView alloc] initWithFrame:CGRectMake(5, 0 , Mwidth - 10 , (Mwidth - 10)/7*6)];
    view.userInteractionEnabled = YES;
    self.calendarView = view;
    view.currentDate = [NSDate date];
    
    view.delegate = self;
    [self.backView addSubview:view];
    [self setupMarkView];
}

- (void)setupMarkView{
    //获取当前时间
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    YHBaseDateModel *dateModel = [[YHBaseDateModel alloc] init];
    dateModel.year = [NSString stringWithFormat:@"%ld",[dateComponent year]];
    dateModel.month = [NSString stringWithFormat:@"%ld",[dateComponent month]];
    dateModel.day = [NSString stringWithFormat:@"%ld",[dateComponent day]];
    _selectedModel = [[YHBaseDateModel alloc] init];
    _selectedModel = dateModel;
    self.calendarView.markArray = [self getMarkArray:dateModel];
}
#pragma mark - 签到方法
- (void)signInClick{
    if (![self isToday]){
        showMessage(@"请在当天签到！");
        return ;
    }

    ///调用单利后默认开启定位
    YWBaiduLocationManager*locationManager = [YWBaiduLocationManager shareManager];
    ///开启定位
    locationManager.startLocationService = YES;
    if (![locationManager isLocationSuccess])
    {
        [locationManager setStartLocationService:YES];
        __weak typeof(self) weakSelf = self;
        [locationManager getUserLocation:^(CLLocation *loc) {
//            NSLog(@"%f----%f",loc.coordinate.latitude,loc.coordinate.longitude);
        CLLocationCoordinate2D pt = (CLLocationCoordinate2D){loc.coordinate.latitude, loc.coordinate.longitude};
            [weakSelf reverseGeo:locationManager Coordinate2D:pt];
        }];
        
    } else {
//        NSLog(@"%f======%f",locationManager.userLatitude,locationManager.userLongitude);
        CLLocationCoordinate2D pt = (CLLocationCoordinate2D){locationManager.userLatitude, locationManager.userLongitude};

        [self reverseGeo:locationManager Coordinate2D:pt];
    }
}

- (void)reverseGeo:(YWBaiduLocationManager*)locationManager Coordinate2D:(CLLocationCoordinate2D)Coordinate{
    __weak typeof(self) weakSelf = self;
    [locationManager onClickReverseGeocodeWithCoordinate:Coordinate complete:^(BMKReverseGeoCodeResult *result, BMKSearchErrorCode errorCode) {
        [weakSelf signInlatitude:[NSString stringWithFormat:@"%f",Coordinate.latitude] longitude:[NSString stringWithFormat:@"%f",Coordinate.longitude] address:result.address];
    }];
}

- (void)signInlatitude:(NSString *)lat longitude:(NSString *)lon address:(NSString *)address{
    SYWCommonRequest *api = [[SYWCommonRequest alloc] init];
    api.ReqURL = [NSString stringWithFormat:@"%@/jianyunbao.aspx",JYB_erpHttpUrl];
    api.ReqDictionary =
    @{
      @"method":@"Sign",
      @"enterpriseCode":JYB_enterpriseCode,
      @"employeeId":JYB_userId,
      @"location_X":lat,
      @"location_Y":lon,
      @"scale":@"",
      @"label":address,
      @"deviceId":[[JYBDevice sharedDevice] UUIDString]?[[JYBDevice sharedDevice] UUIDString]:@"",
      @"netType":[[JYBDevice sharedDevice] networkType]?[[JYBDevice sharedDevice] networkType]:@"",
      @"sourceSystem":[[JYBDevice sharedDevice] deviceString]?[[JYBDevice sharedDevice] deviceString]:@"",
      @"platFormInfo":[[JYBDevice sharedDevice] systemVersion]?[[JYBDevice sharedDevice] systemVersion]:@"",
      @"userIp":[[JYBDevice sharedDevice] localIPAddress]?[[JYBDevice sharedDevice] localIPAddress]:@""};
    __weak typeof(self) weakSelf = self;
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        DLogJSON(request.responseJSONObject);
        if (GoodResponse) {
            JYBSignInItem *item = [[JYBSignInItem alloc] init];
            
            NSString *time = request.responseJSONObject[@"signTime"];

            NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init] ;
            [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
            [inputFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
            NSDate* inputDate = [inputFormatter dateFromString:time];
            NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init] ;
            [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            time = [outputFormatter stringFromDate:inputDate];

            item.createDate = [time copy];
            item.lable = [address copy];
            [JYBSignInItemTool addSignInItem:item];
            [weakSelf showHint:@"签到成功"];
            [weakSelf setupMarkView];
            [weakSelf.signArray insertObject:item atIndex:0];
            [weakSelf.table reloadData];
            
        }else{
            [self showHint:BadResponseMessage];
        }
        
    } failure:^(YTKBaseRequest *request) {
    }];
}

- (BOOL)createDateIsToday:(NSString *)createDate{
    if (createDate.length == 0 || createDate == nil){
        return NO;
    }
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];

    NSString * year = [[createDate componentsSeparatedByString:@"-"] objectAtIndex:0];
    NSString * month = [[createDate componentsSeparatedByString:@"-"] objectAtIndex:1];
    NSString * day = [[createDate componentsSeparatedByString:@"-"] objectAtIndex:2];
    if ([year integerValue] == [dateComponent year] && [month integerValue] == [dateComponent month] && [day integerValue] == [dateComponent day]){
        return YES;
    }
    return NO;
}
- (BOOL)isToday{
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    if ([_selectedModel.year integerValue] == [dateComponent year] && [_selectedModel.month integerValue] == [dateComponent month] && [_selectedModel.day integerValue] == [dateComponent day]) {
        return YES;
    }
    return NO;
}

#pragma mark - 同步签到数据，该方法需要在设置中实现，请将本方法放入设置同步当中。
- (void)getSignList{
    SYWCommonRequest *api = [[SYWCommonRequest alloc] init];
    api.ReqURL = [NSString stringWithFormat:@"%@/phone/SignList!list.action",JYB_bcHttpUrl];
    api.ReqDictionary =
    @{
      @"userId":JYB_userId,
      @"year":@""};
//    __weak typeof(self) weakSelf = self;
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        DLogJSON(request.responseJSONObject);
        if (GoodResponse)
        {
            NSArray *tempArr = [JYBSignInItem mj_objectArrayWithKeyValuesArray:APIJsonObject[@"list"]];
            [JYBSignInItemTool addSignInItems:tempArr];
            
            for (JYBSignInItem * item in tempArr){
                NSString * createDate = item.createDate;
                if ([self createDateIsToday:createDate]){
                    [self.signArray insertObject:item atIndex:0];
                }
            }
            [self.table reloadData];
        }else{
            [self showHint:BadResponseMessage];
        }
        
    } failure:^(YTKBaseRequest *request) {
    }];
}

#pragma mark - 日历按钮点击和代理方法
- (IBAction)leftBtnClick:(id)sender {
    [self.calendarView scrollDate:YES];
}

- (IBAction)rightBtnClick:(id)sender {
    [self.calendarView scrollDate:NO];
}

-(void)YHBaseCalendarViewSelectAtDateModel:(YHBaseDateModel *)dateModel{
    self.selectedModel = dateModel;
        [self.signArray removeAllObjects];
    NSArray *tempArr = [self getResult:dateModel];
    [self.signArray addObjectsFromArray:tempArr];
    [self.table reloadData];
    
}

-(void)YHBaseCalendarViewScrollEndToDate:(YHBaseDateModel *)dateModel{
    NSLog(@"songyawei=========%@年%@月%@日",dateModel.year,dateModel.month,dateModel.day);
    self.calendarView.markArray = [self getMarkArray:dateModel];
    self.dateLabel.text = [NSString stringWithFormat:@"%@年%@月",dateModel.year,dateModel.month];
}

- (NSArray *)getMarkArray:(YHBaseDateModel *)dateModel{
    NSMutableArray *tempMarkArray = [NSMutableArray array];
    for (int i = 0; i < 31; i++) {
        YHBaseDateModel *model = [[YHBaseDateModel alloc] init];
        model.year = dateModel.year;
        model.month = dateModel.month;
        model.day = [NSString stringWithFormat:@"%d",i + 1];
        NSArray *tempArr = [self getResult:model];
        if (![tempArr count]) {
            continue;
        }
        model.num = [NSString stringWithFormat:@"%ld",[tempArr count]];
        [tempMarkArray addObject:model];
    }
    
    return tempMarkArray;
}

- (NSArray *)getResult:(YHBaseDateModel *)dateModel{
    NSLog(@"songyawei--------%@年%@月%@日",dateModel.year,dateModel.month,dateModel.day);
    NSString *date = nil;
    if ([dateModel.month integerValue]< 10 && [dateModel.day integerValue] < 10) {
        date = [NSString stringWithFormat:@"%@-0%@-0%@",dateModel.year,dateModel.month,dateModel.day];
    }else if ([dateModel.day integerValue] < 10){
        date = [NSString stringWithFormat:@"%@-%@-0%@",dateModel.year,dateModel.month,dateModel.day];
    }else if ([dateModel.month integerValue] < 10){
        date = [NSString stringWithFormat:@"%@-0%@-%@",dateModel.year,dateModel.month,dateModel.day];
    }else{
        date = [NSString stringWithFormat:@"%@-%@-%@",dateModel.year,dateModel.month,dateModel.day];
    }
    
    return [JYBSignInItemTool signInItems:date];
}

#pragma mark - tableview 相关
- (void)setTable:(BDBaseTableView *)table{
    _table = table;
    table.hidden = YES;
    table.touchDelegate = self;
    table.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    [table hideSeparatorForNotDataSource];
}

//MARK: UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [self.signArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    JYBSignInItem *item = self.signArray[indexPath.row];
    JYBSignInTableViewCell *cell = [JYBSignInTableViewCell cellWithTableView:tableView indexPath:indexPath];
    cell.timeLabel.text = item.createDate;
    cell.addressLabel.text = item.lable;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView touchesBegin:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


@end
