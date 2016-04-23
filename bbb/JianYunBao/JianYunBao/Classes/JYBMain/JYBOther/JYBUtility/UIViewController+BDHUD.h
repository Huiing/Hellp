//
//  UIViewController+BDHUD.h
//  
//
//  Created by 冰点 on 15/9/12.
//  Copyright (c) 2015年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>

@interface UIViewController (BDHUD)<UIAlertViewDelegate>

- (void)showHudInView:(UIView *)view hint:(NSString *)hint;

- (void)hideHud;

- (void)showHint:(NSString *)hint;

- (void)showHint:(NSString *)hint afterDelay:(float)delay;

// 从默认(showHint:)显示的位置再往上(下)yOffset
- (void)showHint:(NSString *)hint yOffset:(float)yOffset;

+ (void)showSingleLoginMessage:(NSString *)message delegate:(id<UIAlertViewDelegate>)delegate;

- (BOOL)isCameraAvailable;
- (BOOL)isRearCameraAvailable;
- (BOOL)isFrontCameraAvailable;
- (BOOL)doesCameraSupportTakingPhotos;
- (BOOL)isPhotoLibraryAvailable;
- (BOOL)canUserPickVideosFromPhotoLibrary;
- (BOOL)canUserPickPhotosFromPhotoLibrary;

//是否授权访问照片功能
- (BOOL)isAuthorAssetsLibray;
//是否授权拍照功能
- (BOOL)isAuthorCamera;
@end
