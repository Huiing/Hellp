//
//  CtrlCodeScan.m
//  WisdomSchoolBadge
//
//  Created by zhangyilong on 15/7/16.
//  Copyright (c) 2015年 zhangyilong. All rights reserved.
//

#import "CtrlCodeScan.h"
#import "JYBScanCodeResultViewController.h"

//扫码相关
#import "EasyAlert.h"
#import "RegularJudge.h"
//工单
#import "JYBOrderItem.h"
#import "JYBOrderItemTool.h"
#import "JYBPersonImplementViewController.h"
#import "JYBAppQualityViewController.h"
#import "JYBAppSafeViewController.h"
//讨论组
#import "JYBAppProwledViewController.h"
//上传附件
#import "JYBScanUploadFileViewController.h"

@interface CtrlCodeScan () <JYBScanCodeResultViewControllerDelegate,JYBScanUploadFileViewControllerDelegate,JYBAppQualityViewControllerDelegate,JYBAppSafeViewControllerDelegate,JYBAppProwledViewControllerDelegate,JYBPersonImplementViewControllerDelegate>

@end

@implementation CtrlCodeScan

@synthesize overlayer;
@synthesize device;
@synthesize input;
@synthesize output;
@synthesize session;
@synthesize preview;
@synthesize line;
@synthesize scanFrame;
@synthesize isLightOn;

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    if ([super init])
    {
        return self;
    }
    
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(resetScan)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
    isLightOn = NO;
    [self initScan];
    
    [session startRunning];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self startScanLineAnimate];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [session stopRunning];
    [output setMetadataObjectsDelegate:nil queue:nil];
    [line.layer removeAllAnimations];
}
- (void)resetScan{
    CGRect frame = CGRectZero;
    frame.size.width = 230;
    frame.size.height= 230;
    line.frame = CGRectMake(self.scanFrame.frame.origin.x + 1, self.scanFrame.frame.origin.y + 1, frame.size.width - 2, 10);
    [self startScanLineAnimate];
}
- (void)initScan
{
    CGSize winsize = [UIScreen mainScreen].bounds.size;
    
    // Device
    device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    output = [[AVCaptureMetadataOutput alloc] init];
    
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    session = [[AVCaptureSession alloc] init];
    
    
    [session setSessionPreset:AVCaptureSessionPresetHigh];
    
    if ([session canAddInput:self.input])
    {
        [session addInput:self.input];
    }
    
    if ([session canAddOutput:self.output])
    {
        [session addOutput:self.output];
    }
    
    output.rectOfInterest = CGRectMake(((winsize.height - 300) / 2 - 5) / winsize.height, (winsize.width - 300) / 2 / winsize.width , 300 / winsize.height, 300 / winsize.width);
    
    // 条码类型 AVMetadataObjectTypeQRCode
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    // Preview
    preview = [AVCaptureVideoPreviewLayer layerWithSession:session];
    
    preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    preview.frame = CGRectMake(0, 0, winsize.width, winsize.height);//self.view.layer.bounds;
    
    [self.view.layer insertSublayer:preview atIndex:0];
    
    CGRect rect = output.rectOfInterest;
    CGRect frame = CGRectZero;
    
    frame.origin.x = (winsize.width - 230) / 2;//winsize.width * rect.origin.y;
    frame.origin.y = (winsize.height - 230) / 2;//winsize.height * rect.origin.x;
    frame.size.width = 230;
    frame.size.height= 230;
    
    UIView* view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor= [UIColor clearColor];
    view.layer.borderWidth = 1;
    view.layer.borderColor = [[UIColor grayColor] CGColor];
    self.scanFrame = view;
    [self.view addSubview:view];
    
    //top
    UIView* shadow = [[UIView alloc] initWithFrame:CGRectMake(0, 0, winsize.width, view.frame.origin.y)];
    shadow.backgroundColor = [UIColor blackColor];
    shadow.alpha = 0.5;
    [self.view addSubview:shadow];
    
    //bottom
    shadow = [[UIView alloc] initWithFrame:CGRectMake(0, view.frame.origin.y + view.frame.size.height, winsize.width, winsize.height - (view.frame.origin.y + view.frame.size.height))];
    shadow.backgroundColor = [UIColor blackColor];
    shadow.alpha = 0.5;
    [self.view addSubview:shadow];
    
    //left
    shadow = [[UIView alloc] initWithFrame:CGRectMake(0, view.frame.origin.y, (winsize.width - view.frame.size.width) / 2, view.frame.size.height)];
    shadow.backgroundColor = [UIColor blackColor];
    shadow.alpha = 0.5;
    [self.view addSubview:shadow];
    
    //right
    shadow = [[UIView alloc] initWithFrame:CGRectMake(view.frame.origin.x + view.frame.size.width, view.frame.origin.y, (winsize.width - view.frame.size.width) / 2, view.frame.size.height)];
    shadow.backgroundColor = [UIColor blackColor];
    shadow.alpha = 0.5;
    [self.view addSubview:shadow];
    
    line = [[UIView alloc] initWithFrame:CGRectMake(view.frame.origin.x + 1, view.frame.origin.y + 1, frame.size.width - 2, 10)];
    //line.center = view.center;
    line.backgroundColor = [UIColor clearColor];
    [self.view addSubview:line];
    
    CAGradientLayer* gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = line.bounds;
    gradientLayer.colors = [NSArray arrayWithObjects:
                            (id)[[UIColor colorWithRed:35/255.0 green:237/255.0 blue:248/255.0 alpha:0.1] CGColor],
                            (id)[[UIColor colorWithRed:35/255.0 green:237/255.0 blue:248/255.0 alpha:0.35] CGColor],
                            (id)[[UIColor colorWithRed:35/255.0 green:237/255.0 blue:248/255.0 alpha:0.8] CGColor],
                            (id)[[UIColor colorWithRed:35/255.0 green:237/255.0 blue:248/255.0 alpha:0.35] CGColor],
                            (id)[[UIColor colorWithRed:35/255.0 green:237/255.0 blue:248/255.0 alpha:0.1] CGColor],
                            nil];
    [line.layer insertSublayer:gradientLayer atIndex:0];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, view.frame.origin.y - 18, line.frame.size.width, 15)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:12];
    label.numberOfLines = 0;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.center = CGPointMake(line.center.x, label.center.y);
    label.text = @"将二维码放入框内，即可自动扫描";//@"二维码: 将二维码置于灰色方形区域内; 条形码: 将条形码置于灰色方形区域内并将红线置于条形码竖直中心位置";
    [self.view addSubview:label];
    
    //light
    UIButton* light = [UIButton buttonWithType:UIButtonTypeCustom];
    light.frame = CGRectMake(0, view.frame.origin.y + view.frame.size.height + 5, 35, 35);
    light.center = CGPointMake(winsize.width / 2, light.center.y);
    light.backgroundColor = [UIColor clearColor];
    [light setBackgroundImage:[UIImage imageNamed:@"light_off"] forState:UIControlStateNormal];
    [light setBackgroundImage:[UIImage imageNamed:@"light_on"] forState:UIControlStateSelected];
    [light addTarget:self action:@selector(openLight:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:light];
    
    [self initConner];
}

- (void)initConner
{
    CGFloat w = 2;
    CGFloat h = 10;
    CGFloat d = 2;
    CGPoint point = CGPointZero;
    
    //left - top
    point = CGPointMake(scanFrame.frame.origin.x - w - d, scanFrame.frame.origin.y - w - d);
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(point.x, point.y, w, h)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(point.x, point.y, h, w)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    //left - down
    point = CGPointMake(scanFrame.frame.origin.x - w - d, scanFrame.frame.origin.y + scanFrame.frame.size.height + d + w - h);
    view = [[UIView alloc] initWithFrame:CGRectMake(point.x, point.y, w, h)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    point = CGPointMake(point.x, scanFrame.frame.origin.y + scanFrame.frame.size.height + d);
    view = [[UIView alloc] initWithFrame:CGRectMake(point.x, point.y, h, w)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    //right - top
    point = CGPointMake(scanFrame.frame.origin.x + scanFrame.frame.size.width + d, scanFrame.frame.origin.y - w - d);
    view = [[UIView alloc] initWithFrame:CGRectMake(point.x, point.y, w, h)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    point = CGPointMake(scanFrame.frame.origin.x + scanFrame.frame.size.width + w + d - h, point.y);
    view = [[UIView alloc] initWithFrame:CGRectMake(point.x, point.y, h, w)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    //right - down
    point = CGPointMake(scanFrame.frame.origin.x + scanFrame.frame.size.width + d, scanFrame.frame.origin.y + scanFrame.frame.size.height + w + d - h);
    view = [[UIView alloc] initWithFrame:CGRectMake(point.x, point.y, w, h)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    point = CGPointMake(point.x + w - h, scanFrame.frame.origin.y + scanFrame.frame.size.height + d);
    view = [[UIView alloc] initWithFrame:CGRectMake(point.x, point.y, h, w)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
}

- (void)openLight:(UIButton*)sender
{
    [device lockForConfiguration:nil];
    if (!sender.selected)
    {
        [device setTorchMode:AVCaptureTorchModeOn];
        [device setFlashMode:AVCaptureFlashModeOn];
        
        sender.selected = YES;
    }
    else
    {
        [device setTorchMode:AVCaptureTorchModeOff];
        [device setFlashMode:AVCaptureFlashModeOff];
        
        sender.selected = NO;
    }
    [device unlockForConfiguration];
}
//开始扫描动画
- (void)startScanLineAnimate
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationRepeatAutoreverses:YES];
    [UIView setAnimationRepeatCount:HUGE_VALF];
    line.center = CGPointMake(line.center.x, scanFrame.frame.origin.y + scanFrame.frame.size.height - 5);
    [UIView commitAnimations];
}
//结束扫描动画
- (void)stopScanLineAnimate{
    [line.layer removeAllAnimations];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    [session stopRunning];
    [self stopScanLineAnimate];
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        
        stringValue = metadataObject.stringValue;
    }
    
    [self didCodeScanOk:stringValue];
    
    [output setMetadataObjectsDelegate:nil queue:nil];
}


//二维码扫描结果
/**
 jyb:功能码:内容 例jyb:2000:380
 注意,内容中可能存在英文“:”
 */

- (void)didCodeScanOk:(id)info{
    NSString *text = info;
    NSLog(@"二维码内容：%@",text);
    //如果是jyb的
    if([text rangeOfString:@"jyb:"].location != NSNotFound){
        //由于内容里可能出现：所以不能用：分割
        //功能码
        NSString * fnCode = [text substringWithRange:NSMakeRange(4, 4)];
        //内容
        NSString * content = [text substringFromIndex:9];
        //区分功能码类型
        int type = 0;
        if([fnCode intValue] >= 1000 && [fnCode intValue] <= 1999){//基本功能
            if([fnCode intValue] == 1000){//大于1000的作为不能识别的二维码
                type = 1;
            }
        }else if([fnCode intValue] >= 2000 && [fnCode intValue] <= 2999){//app功能
            type = 2;
        }else if([fnCode intValue] >= 3000 && [fnCode intValue] <= 3999){//web功能
            type = 3;
        }
        //相应处理
        switch (type) {
            case 0://不能识别的
            {
                showMessage(@"不能识别的二维码！");
                [self.navigationController popViewControllerAnimated:YES];
                return;
            }
                break;
            case 1://基本功能
            {
                [self basicCodeWithContent:content withType:fnCode];
            }
                break;
            case 2://app功能
            {
                switch ([fnCode intValue]) {
                    case 2000://内容为工单ID
                    {
                        //去缓存里查询工单ID是否存在
                        JYBOrderItem * item = [JYBOrderItemTool queryOrderId:content];
                        if (item && item != nil){
                            JYBPersonImplementViewController *vc = [[JYBPersonImplementViewController alloc] init];
                            vc.delegate = self;
                            vc.orderId = item.orderId;
                            vc.navigationTitle = item.titleName;
                            [self.navigationController pushViewController:vc animated:YES];
                        }else {
                            showMessage(@"您不是工单相关人员，不能得到工单");
                        }
                    }
                        break;
                    case 2010://内容为质量检查单ID
                    {
                        JYBAppQualityViewController * quality = [[JYBAppQualityViewController alloc] init];
                        quality.navigationTitle = @"质量检查";
                        quality.delegate = self;
                        [self.navigationController pushViewController:quality animated:YES];
                    }
                        break;
                    case 2020://内容为安全检查单ID
                    {
                        JYBAppSafeViewController * safe = [[JYBAppSafeViewController alloc] init];
                        safe.navigationTitle = @"安全检查";
                        safe.delegate = self;
                        [self.navigationController pushViewController:safe animated:YES];
                    }
                        break;
                    case 2030://内容为日常巡查单ID
                    {
                        JYBAppProwledViewController * prowled = [[JYBAppProwledViewController alloc] init];
                        prowled.navigationTitle = @"日常巡查";
                        prowled.delegate = self;
                        [self.navigationController pushViewController:prowled animated:YES];
                    }
                        break;
                        
                    default:
                        break;
                }
            }
                break;
            case 3://web功能
            {
                switch ([fnCode intValue]) {
                    case 3000://系统网页
                    {
                        
                    }
                        break;
                    case 3001://上传附件
                    {
                        JYBScanUploadFileViewController * uploadFileVC = [[JYBScanUploadFileViewController alloc] init];
                        uploadFileVC.navigationTitle = @"上传附件";
                        uploadFileVC.delegate = self;
                        uploadFileVC.codeContent = content;
                        uploadFileVC.codeType = fnCode;
                        [self.navigationController pushViewController:uploadFileVC animated:YES];
                    }
                        break;
                    case 3002://专题讨论
                    {
                        JYBScanCodeResultViewController * scanResult = [[JYBScanCodeResultViewController alloc] init];
                        scanResult.navigationTitle = @"扫描结果";
                        scanResult.delegate = self;
                        scanResult.codeType = fnCode;
                        scanResult.codeResult = content;
                        [self.navigationController pushViewController:scanResult animated:YES];
                    }
                        break;
                    case 3003://3003为3001与3002功能合集
                    {
                        JYBScanCodeResultViewController * scanResult = [[JYBScanCodeResultViewController alloc] init];
                        scanResult.navigationTitle = @"扫描结果";
                        scanResult.delegate = self;
                        scanResult.codeType = fnCode;
                        scanResult.codeResult = content;
                        [self.navigationController pushViewController:scanResult animated:YES];
                    }
                        break;
                        
                    default:
                        break;
                }
            }
                break;
                
            default:
                break;
        }
    }else{
        [self basicCodeWithContent:text withType:@""];
    }
}

/**
 扫码讨论：
 二维码内容：jyb:3003:{"employeeId":"5f564311-28ce-4c22-9f44-2e37609a0993","enterpriseCode":"yuntechoa","Tblname":"oa_projectcost","mainid":"931","FolderID":"","FileName":""}
 */

/**
 扫码上传：
 二维码内容：jyb:3003:{"employeeId":"A92118E9-993B-4651-8F11-C440799346D5","enterpriseCode":"YuntechOA","Tblname":"oa_ptUpdateState","mainid":"3","FolderID":"c38fd712-d68c-4f85-8e1e-a9be3b39788b","FileName":"平台更新说明"}
 */

//二维码基础功能
- (void)basicCodeWithContent:(NSString *)content withType:(NSString *)type{
    JYBScanCodeResultViewController * scanResultVC = [[JYBScanCodeResultViewController alloc] init];
    scanResultVC.codeResult = content;
    scanResultVC.delegate = self;
    scanResultVC.codeType = type;
    scanResultVC.title = @"扫描结果";
    [self.navigationController pushViewController:scanResultVC animated:YES];
}

- (void)backContinue{
    [self continueScan];
}
//继续扫描
- (void)continueScan{
    [session startRunning];
    [self resetScan];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
}

//呼叫手机号
- (void)dialPhoneNumber:(NSString*)phoneNumber{
    static UIWebView *__phoneCallWebView;
    if (__phoneCallWebView == nil) {
        __phoneCallWebView = [[UIWebView alloc] init];
    }
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNumber]];
    [__phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
}

@end
