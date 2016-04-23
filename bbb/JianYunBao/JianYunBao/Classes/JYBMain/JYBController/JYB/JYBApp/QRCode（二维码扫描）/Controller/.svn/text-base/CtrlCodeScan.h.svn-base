//
//  CtrlCodeScan.h
//  WisdomSchoolBadge
//
//  Created by zhangyilong on 15/7/16.
//  Copyright (c) 2015年 zhangyilong. All rights reserved.
//
// 此类可抽出来单独使用，不依赖zbar。

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "JYBBaseViewController.h"

@interface CtrlCodeScan : JYBBaseViewController <AVCaptureMetadataOutputObjectsDelegate>

@property(nonatomic, weak) IBOutlet UIView*     overlayer;

@property(strong, nonatomic) AVCaptureDevice*            device;
@property(strong, nonatomic) AVCaptureDeviceInput*       input;
@property(strong, nonatomic) AVCaptureMetadataOutput*    output;
@property(strong, nonatomic) AVCaptureSession*           session;
@property(strong, nonatomic) AVCaptureVideoPreviewLayer* preview;

@property(nonatomic, strong) UIView*                     scanFrame;
@property(nonatomic, strong) UIView*                     line;
@property(nonatomic, assign) BOOL                        isLightOn;

@end
