//
//  JYBScanUploadFileViewController.m
//  JianYunBao
//
//  Created by 正 on 16/3/21.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBScanUploadFileViewController.h"
@import AVFoundation;
@import MediaPlayer;
@import MobileCoreServices;

#import "SYWCommonRequest.h"
#import "JYBFileTypeView.h"
#import "EMCDDeviceManager.h"
#import "DXRecordView.h"
#import "NSString+BDPath.h"


@interface JYBScanUploadFileViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,JYBFileTypeViewDelegate>

@property (strong, nonatomic) UIWebView * web;

@end

@implementation JYBScanUploadFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSubviews];
}

//string 转 nsdictionary
- (NSDictionary *)stringToDictionary:(NSString *)string{
    NSData * data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    return dic;
}
//文件类型view
- (void)addSubviews{
    JYBFileTypeView *typeView = [[JYBFileTypeView alloc] initWithFrame:CGRectMake(0, SCR_HEIGHT - (SCR_WIDTH/4+10), SCR_WIDTH, SCR_WIDTH/4+10)];
    typeView.delegate = self;
    [self.view addSubview:typeView];
    typeView.itemBlock = ^(NSInteger index){
        switch (index) {
            case 0://拍照
            {
                [self showImagePickViewControllerWithSourceType:UIImagePickerControllerSourceTypeCamera isVideo:NO];
            }
                break;
            case 1://图片
            {
                [self showImagePickViewControllerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary isVideo:NO];
            }
                break;
            case 2://语音
            {
                //－－ 代理实现
            }
                break;
            case 3://视频
            {
                [self showImagePickViewControllerWithSourceType:UIImagePickerControllerSourceTypeCamera isVideo:YES];
            }
                break;
            case 4://文件
            {
                [self showHint:@"iOS 暂无Word、Text、PPT、PDF等文件！"];
            }
                break;
                
            default:
                break;
        }
    };
    
    //webview
    float topHeight = 44.0f;
    if (iOS7){
        topHeight = 64.0f;
    }
    self.web = [[UIWebView alloc] initWithFrame:CGRectMake(0, topHeight, SCR_WIDTH, SCR_HEIGHT - typeView.frame.size.height - topHeight)];
    [self.view addSubview:self.web];
    [self loadWebView];
}
//http://www.yuntech.com.cn/oa/ JiChengLogin.aspx?loginName=zhouchaoyi&urlStr=SCSEXEC/PhoneTaskContent.aspx?htmlindex=100|TblName=oa_ptUpdateState|mainid=4|hidsql=autoid=4&appFunction=0
- (void)loadWebView{
    NSDictionary * dic = [self stringToDictionary:self.codeContent];
    NSString * str = [NSString stringWithFormat:@"%@JiChengLogin.aspx?loginName=%@&urlStr=SCSEXEC/PhoneTaskContent.aspx?htmlindex=100|TblName=%@|mainid=%@|hidsql=autoid=%@&appFunction=0",@"http://www.yuntech.com.cn/oa/",JYB_userName,dic[@"Tblname"],dic[@"mainid"],dic[@"mainid"]];
    NSLog(@"%@",str);
    [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
}

//返回扫描
- (void)backBarBtnItemClick{
    if(self.delegate && [self.delegate respondsToSelector:@selector(backContinue)]){
        [self.delegate backContinue];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

//文件上传
- (void)uploadFileWithDictionary:(NSDictionary *)dictionary withFiledata:(NSData *)filedata withFileName:(NSString *)fileName{
    AFHTTPRequestSerializer * serializer = [AFHTTPRequestSerializer serializer];
    NSString * urlString = [NSString stringWithFormat:@"%@WorkAsp/Extend/FileManager/Muliupload/jianyunbaoUpload.aspx",JYB_erpRootUrl];
    NSLog(@"5555-------%@",dictionary[@"FolderID"]);
    NSDictionary * params = @{@"enterpriseCode":JYB_enterpriseCode,
                              @"FolderID":dictionary[@"FolderID"],
                              @"FolderName":dictionary[@"FileName"],
                              @"BusinessClass":dictionary[@"Tblname"],
                              @"FileName":fileName,
                              @"employeeId":JYB_userId,
                              @"employeeName":JYB_userName,
                              @"filedata":fileName};
    NSLog(@"...%@",params);
    NSMutableURLRequest * request = [serializer multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:filedata name:@"uploadImg" fileName:@"uploadImg.jpg" mimeType:@"image/jpeg"];
    } error:nil];
    AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSError * jsonError;
        NSDictionary * jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableContainers | NSJSONReadingMutableContainers | NSJSONReadingAllowFragments) error:&jsonError];
        if(jsonObject){
            NSLog(@"上传成功：%@",jsonObject);
            if([jsonObject[@"result"] boolValue]){
                showMessage(@"操作成功！");
            }
        }else{
            NSLog(@"json error : %@",jsonError.localizedDescription);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"%@",error.localizedDescription);
    }];
    [operation start];
    
    
}

//MARK: Other
- (void)showImagePickViewControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType isVideo:(BOOL)isVideo
{
    UIImagePickerController *controller = nil;
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            if ([self isAuthorCamera]) {
                controller = [[UIImagePickerController alloc] init];
                controller.sourceType = sourceType;
                if ([self isRearCameraAvailable]) {
                    controller.cameraDevice = UIImagePickerControllerCameraDeviceRear;
                    [self presentImagePickerController:controller isVideo:isVideo];
                }
            } else {
                NSString *msg = [NSString stringWithFormat:@"请在iPhone的\"设置-隐私-相机\"中允许访问相机"];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法使用相机" message:msg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                [alert show];
            }
        } else {
            NSString *msg = [NSString stringWithFormat:@"请检查iPhone的相机"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法使用相机" message:msg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alert show];
        }
    } else if (sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        if ([self isPhotoLibraryAvailable]) {
            if ([self isAuthorAssetsLibray]) {
                controller = [[UIImagePickerController alloc] init];
                controller.sourceType = sourceType;
                [self presentImagePickerController:controller isVideo:isVideo];
            } else {
                NSString *msg = [NSString stringWithFormat:@"请在iPhone的\"设置-隐私-照片\"中允许访问照片"];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法使用相册" message:msg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                [alert show];
            }
        } else {
            NSString *msg = [NSString stringWithFormat:@"请检查iPhone的相册"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法相册" message:msg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
    
}

- (void)presentImagePickerController:(UIImagePickerController *)picker isVideo:(BOOL)isVideo
{
    if (isVideo) {
        picker.mediaTypes = @[(__bridge NSString *)kUTTypeMovie];
        picker.videoQuality = UIImagePickerControllerQualityTypeLow;
        picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
        picker.videoMaximumDuration = 30;//录制视频最大时长30''
    } else {
        picker.mediaTypes = @[(__bridge NSString *)kUTTypeImage];
    }
    picker.allowsEditing = YES;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:NULL];
}


/**
 *  按下录音按钮开始录音
 */
- (void)didStartRecordingVoiceAction:(UIView *)recordView
{
    if ([self canRecord]){
        DXRecordView *tmpView = (DXRecordView *)recordView;
        tmpView.center = self.view.center;
        [self.view addSubview:tmpView];
        [self.view bringSubviewToFront:recordView];
        int x = arc4random() % 100000;
        NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
        NSString *fileName = [NSString stringWithFormat:@"%d%d",(int)time,x];
        
        [[EMCDDeviceManager sharedInstance] asyncStartRecordingWithFileName:fileName
                                                                 completion:^(NSError *error)
         {
             if (error) {
                 DLog(@"开始录音失败");
             }
         }];
    }
}

/**
 *  手指向上滑动取消录音
 */
- (void)didCancelRecordingVoiceAction:(UIView *)recordView
{
    [[EMCDDeviceManager sharedInstance] cancelCurrentRecording];
}

/**
 *  松开手指完成录音
 */
- (void)didFinishRecoingVoiceAction:(UIView *)recordView
{
    __weak typeof(self) weakSelf = self;
    [[EMCDDeviceManager sharedInstance] asyncStopRecordingWithCompletion:^(NSString *recordPath, NSInteger aDuration, NSError *error) {
        if (!error) {
            NSLog(@"录音文件路径 : %@",recordPath);
            [self uploadFileWithDictionary:[self stringToDictionary:self.codeContent] withFiledata:[NSData dataWithContentsOfFile:recordPath] withFileName:[NSString stringWithFormat:@"%@.amr",[self stringFromDate:[NSDate date]]]];
        }else {
            [weakSelf showHudInView:self.view hint:@"录音时间太短了"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf hideHud];
            });
        }
    }];
}

//是否支持录音
- (BOOL)canRecord
{
    __block BOOL bCanRecord = YES;
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
    {
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                bCanRecord = granted;
            }];
        }
    }
    
    return bCanRecord;
}


#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) {//视频
        NSURL *videoURL = info[UIImagePickerControllerMediaURL];
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum([videoURL path])) {
            //            UISaveVideoAtPathToSavedPhotosAlbum([videoURL path], self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
        }
        [picker dismissViewControllerAnimated:YES completion:NULL];
        // video url:
        // file:///private/var/mobile/Applications/B3CDD0B2-2F19-432B-9CFA-158700F4DE8F/tmp/capture-T0x16e39100.tmp.9R8weF/capturedvideo.mp4
        // we will convert it to mp4 format
        NSURL *mp4 = [self convert2Mp4:videoURL];
        NSFileManager *fileman = [NSFileManager defaultManager];
        if ([fileman fileExistsAtPath:videoURL.path]) {
            NSError *error = nil;
            [fileman removeItemAtURL:videoURL error:&error];
            if (error) {
                NSLog(@"failed to remove file, error:%@.", error);
            }
        }
        //根据MP4将文件写入sandbox中
        NSString *toPath = [NSString createWhiteboardVideoFilePath];
        NSError *error = nil;
        [fileman copyItemAtPath:mp4.path toPath:toPath error:&error];
        
        AVURLAsset* audioAsset =[AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:toPath] options:nil];
        CMTime audioDuration = audioAsset.duration;
        float videoDurationSeconds =CMTimeGetSeconds(audioDuration) * 1000;//s * 1000 = ms
        NSLog(@"视频路径：%@",toPath);

        [self uploadFileWithDictionary:[self stringToDictionary:self.codeContent] withFiledata:[NSData dataWithContentsOfFile:toPath] withFileName:[NSString stringWithFormat:@"%@.mp4",[self stringFromDate:[NSDate date]]]];
        
        
    }else{//图片
        UIImage *orgImage = info[UIImagePickerControllerOriginalImage];
        [picker dismissViewControllerAnimated:YES completion:NULL];
        //获取图片路径
        NSURL *imageURL = [info valueForKey:UIImagePickerControllerReferenceURL];
        //获取图片名称
        ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
        {
            ALAssetRepresentation *representation = [myasset defaultRepresentation];
            NSString *fileName = [representation filename];
            NSLog(@"图片名称 : %@",fileName);
            if(fileName.length == 0){
                fileName = [NSString stringWithFormat:@"%@.JPG",[self stringFromDate:[NSDate date]]];
            }
            
            [self uploadFileWithDictionary:[self stringToDictionary:self.codeContent] withFiledata:UIImageJPEGRepresentation(orgImage, 0.5) withFileName:fileName];
        };
        
        ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
        [assetslibrary assetForURL:imageURL
                       resultBlock:resultblock
                      failureBlock:nil];
        
    }
}
//日期转时间
- (NSString *)stringFromDate:(NSDate *)date{
    NSDateFormatter * dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * dateString = [dateformatter stringFromDate:date];
    return dateString;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

//视频保存后的回调
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSLog(@"视频路径：%@",videoPath);
}

//转成mp4格式
- (NSURL *)convert2Mp4:(NSURL *)movUrl {
    NSURL *mp4Url = nil;
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:movUrl options:nil];
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    if ([compatiblePresets containsObject:AVAssetExportPresetHighestQuality]) {
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]initWithAsset:avAsset
                                                                              presetName:AVAssetExportPresetHighestQuality];
        mp4Url = [movUrl copy];
        mp4Url = [mp4Url URLByDeletingPathExtension];
        mp4Url = [mp4Url URLByAppendingPathExtension:@"mp4"];
        exportSession.outputURL = mp4Url;
        exportSession.shouldOptimizeForNetworkUse = YES;
        exportSession.outputFileType = AVFileTypeMPEG4;
        dispatch_semaphore_t wait = dispatch_semaphore_create(0l);
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            switch ([exportSession status]) {
                case AVAssetExportSessionStatusFailed: {
                    NSLog(@"failed, error:%@.", exportSession.error);
                } break;
                case AVAssetExportSessionStatusCancelled: {
                    NSLog(@"cancelled.");
                } break;
                case AVAssetExportSessionStatusCompleted: {
                    NSLog(@"completed.");
                } break;
                default: {
                    NSLog(@"others.");
                } break;
            }
            dispatch_semaphore_signal(wait);
        }];
        long timeout = dispatch_semaphore_wait(wait, DISPATCH_TIME_FOREVER);
        if (timeout) {
            NSLog(@"timeout.");
        }
        if (wait) {
            //dispatch_release(wait);
            wait = nil;
        }
    }
    
    return mp4Url;
}


/**
 扫码讨论：
 二维码内容：jyb:3003:{"employeeId":"5f564311-28ce-4c22-9f44-2e37609a0993","enterpriseCode":"yuntechoa","Tblname":"oa_projectcost","mainid":"931","FolderID":"","FileName":""}
 */

/**
 扫码上传：
 二维码内容：jyb:3003:{"employeeId":"A92118E9-993B-4651-8F11-C440799346D5","enterpriseCode":"YuntechOA","Tblname":"oa_ptUpdateState","mainid":"3","FolderID":"c38fd712-d68c-4f85-8e1e-a9be3b39788b","FileName":"平台更新说明"}
 */

/**
 {
 FileName = "\U5e73\U53f0\U66f4\U65b0\U8bf4\U660e";
 FolderID = "c38fd712-d68c-4f85-8e1e-a9be3b39788b";
 Tblname = "oa_ptUpdateState";
 employeeId = "A92118E9-993B-4651-8F11-C440799346D5";
 enterpriseCode = YuntechOA;
 mainid = 3;
 }
 */

////保存图片在本地
//- (void)saveImage:(UIImage *)tempImage withName:(NSString *)imageName
//{
//    //保存在document中
//    NSString* documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSString* totalPath = [documentPath stringByAppendingPathComponent:imageName];
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
