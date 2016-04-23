//
//  JYBAddTeamViewController.m
//  JianYunBao
//
//  Created by 宋亚伟 on 16/2/26.
//  Copyright © 2016年 冰点. All rights reserved.
//

@import AVFoundation;
@import MediaPlayer;
@import MobileCoreServices;
#import "JYBAddTeamViewController.h"
#import "JYBMultiContainerView.h"
#import "JYBUserTool.h"
#import "JYBFriendItem.h"
#import "JYBPersonalInformationViewController.h"
#import "JYBSelectFriendViewController.h"
#import "JYBCreateDiscussNameView.h"
#import "JYBCreateDiscussInputTextView.h"
#import "SYWCommonRequest.h"
#import "EasyAlert.h"
#import "JYBSyncGroupModel.h"
#import "JYBGetGroupUserApi.h"
#import "BDIMDatabaseUtil.h"
#import "JYBChatGroupViewController.h"

#import "JYBFileTypeCell.h"
#import "JYBFileTypeView.h"
#import "JYBFileTypeCollectionView.h"
#import "EMCDDeviceManager.h"
#import <AVFoundation/AVFoundation.h>
#import "DXRecordView.h"
#import "NSString+BDPath.h"
#import "BDBaseTableView.h"


@interface JYBAddTeamViewController ()<JYBMultiContainerViewDelegate,JYBSelectFriendViewControllerDelegate ,UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,JYBFileTypeViewDelegate>{
    UIScrollView * backScrollView;
    JYBCreateDiscussNameView * discussNameView;
    JYBCreateDiscussInputTextView * inputTextView;
    JYBMultiContainerView * container;
    BDBaseTableView *fileTable;
    float originY;
    UIButton * saveBtn;
    BOOL _isWillAdd;
    NSMutableArray *nameArr;
    NSMutableArray *iconArr;
    NSMutableArray *iconArray;
    NSMutableArray *nameArray;
    NSMutableArray *photoArray;
    NSMutableArray *voiceArray;
    NSMutableArray *voiceDurationArray;
    NSMutableArray *videoArray;
    NSMutableArray *videoDurationArray;
    NSMutableArray *fileArray;
    JYBDownloadFileType fileType;
}
@property (strong, nonatomic) NSMutableArray * addMembersIds;
@property (strong, nonatomic) NSMutableArray * addMembers;
@end

@implementation JYBAddTeamViewController

- (NSMutableArray *)addMembers{
    if (!_addMembers){
        _addMembers = [NSMutableArray array];
    }
    return _addMembers;
}
- (NSMutableArray *)addMembersIds{
    if (!_addMembersIds){
        _addMembersIds = [NSMutableArray array];
    }
    return _addMembersIds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.addMembersIds addObject:JYB_userId];
    backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HEIGHT)];
    backScrollView.contentSize = CGSizeMake(SCR_WIDTH, SCR_HEIGHT);
    [self.view addSubview:backScrollView];
    
    originY = 5.0f;
    container = [[JYBMultiContainerView alloc] initWithFrame:CGRectMake(5, originY, SCR_WIDTH - 10, 60)];
    container.delegate = self;
    container.isRemoveable = YES;
    JYBUserItem * item = [JYBUserTool user];
    NSDictionary * mine = [item mj_keyValues];
    [container addPerson:mine];
    [backScrollView addSubview:container];
    
    originY += container.frame.size.height + 5;
    discussNameView = [[JYBCreateDiscussNameView alloc] initWithFrame:CGRectMake(5, originY, SCR_WIDTH - 10, 80)];
    [backScrollView addSubview:discussNameView];
    
    originY += discussNameView.frame.size.height + 5;
    inputTextView = [[JYBCreateDiscussInputTextView alloc] initWithFrame:CGRectMake(5, originY, SCR_WIDTH - 10, 80)];
    [backScrollView addSubview:inputTextView];
    
    originY += inputTextView.frame.size.height + 10;
    //file
    fileTable = [[BDBaseTableView alloc] initWithFrame:CGRectMake(5, originY, SCR_WIDTH - 10, 140) style:UITableViewStylePlain];
    fileTable.delegate = self;
    fileTable.dataSource = self;
    fileTable.scrollEnabled = NO;
    fileTable.showsVerticalScrollIndicator = NO;
    [fileTable hideSeparatorForNotDataSource];
    [backScrollView addSubview:fileTable];
    
    originY += fileTable.frame.size.height + 5;
    //save
    saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(5, originY, SCR_WIDTH - 10, 40);
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveTheDiscuss) forControlEvents:UIControlEventTouchUpInside];
    [saveBtn setBackgroundColor:JYBMainColor];
    [backScrollView addSubview:saveBtn];
    
    [self loadData];
}
- (void)loadData
{
    nameArr = [NSMutableArray array];
    iconArr = [NSMutableArray array];
    nameArray = [NSMutableArray array];
    iconArray = [NSMutableArray array];
    photoArray = [NSMutableArray array];
    voiceArray = [NSMutableArray array];
    videoArray = [NSMutableArray array];
    fileArray = [NSMutableArray array];
    voiceDurationArray = [NSMutableArray array];
    videoDurationArray = [NSMutableArray array];
}

- (void)multiplayerContainerView:(JYBMultiContainerView *)multiplayerContainerView actionForRemovePerson:(NSDictionary *)person{
    [self.addMembers removeObject:person];
    [self.addMembersIds removeObject:person[@"id"]];
    [container removePerson:person];
}
- (void)multiplayerContainerView:(JYBMultiContainerView *)multiplayerContainerView actionForSelectedPerson:(NSDictionary *)person{
    JYBPersonalInformationViewController *ctr = [[JYBPersonalInformationViewController alloc] init];
    ctr.navigationTitle = @"详细资料";
    NSArray *ary = [JYBFriendItem mj_objectArrayWithKeyValuesArray:@[person]];
    ctr.friendItem = ary[0];
    [self.navigationController pushViewController:ctr animated:YES];
}
- (void)multiplayerContainerViewActionForAddPerson:(JYBMultiContainerView *)multiplayerContainerView{
    [self selectedFriends];
}
- (void)selectedFriends{
    JYBSelectFriendViewController * senderVC = [[JYBSelectFriendViewController alloc] init];
    senderVC.title = @"发起人";
    senderVC.delegate = self;
    senderVC.selectedMembersIds = self.addMembersIds;
    senderVC.isFromAddPerson = YES;
    [self.navigationController pushViewController:senderVC animated:YES];
}
- (void)selectedFriendWithItems:(NSArray *)friends{
    [self.addMembers removeAllObjects];
    for (JYBFriendItem * item in friends){
        [self.addMembersIds addObject:item.friendId];
        [self.addMembers addObject:[item mj_keyValues]];
    }
    [container addPersons:self.addMembers];
}
//新建讨论组
- (void)saveTheDiscuss{
    if (discussNameView.input.text.length == 0){
        showMessage(@"请输入讨论组名称！");
        return;
    }
    if (self.addMembersIds.count == 1){
        showMessage(@"请选择人员！");
        return;
    }
    [self creatDiscuss];
}
//创建群聊 type：0为群聊 1为讨论组
- (void)creatDiscuss{
    NSInteger groupType = 1;
    
    //设置请求体
    NSString * ids = [self.addMembersIds componentsJoinedByString:@"&po.userIds="];
    NSString * params = [NSString stringWithFormat:@"po.enterpriseCode=%@&po.userId=%@&po.userName=%@&po.name=%@&po.type=%@&po.userIds=%@",JYB_enterpriseCode,JYB_userId,JYB_userName,discussNameView.input.text,@(groupType),ids];
    NSString *urlString = [NSString stringWithFormat:@"%@/phone/Group!create.action",JYB_bcHttpUrl];
    NSMutableURLRequest  *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    [request setTimeoutInterval:20.0];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (connection == nil) {
        [EasyAlert say:@"创建失败！"];
        return;
    }
}

#pragma mark NSURLConnection Delegate

// 收到回应
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"receive the response");
    
}
// 接收数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    if ([dic[@"result"] boolValue]){
        //插入数据
        [EasyAlert say:^{
            NSDictionary * po = dic[@"po"];
            NSDictionary * group = @{@"createDate":po[@"dt"],
                                     @"enterpriseCode":po[@"enterpriseCode"],
                                     @"id":po[@"id"],
                                     @"name":po[@"name"],
                                     @"userId":po[@"userId"],
                                     @"userName":po[@"userName"],
                                     @"version":po[@"version"]};
            JYBSyncGroupModel * model = [JYBSyncGroupModel mj_objectWithKeyValues:group];
            [self asyncLoadGroupUserWithGroups:model];
        } message:@"创建成功！"];
    }else{
        [EasyAlert say:@"创建失败！"];
    }
}
//获得该群所有用户
- (void)asyncLoadGroupUserWithGroups:(JYBSyncGroupModel *)model
{
    JYBGetGroupUserApi *groupUserApi = [[JYBGetGroupUserApi alloc] initWithGroupId:model.sid];
    [groupUserApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        if ([APIJsonObject[@"result"] boolValue] && ![APIJsonObject[@"deleted"] boolValue]) {
            model.userIds  = APIJsonObject[@"po"][@"userIds"];
            //插入数据
            [[BDIMDatabaseUtil sharedInstance] insertGroup:@[model]];
            //进入群聊
            JYBChatGroupViewController *chatView = [[JYBChatGroupViewController alloc] initWithChatter:model.sid type:JYBConversationTypeGroup];
            chatView.navigationTitle = model.name;
            chatView.groupModel = model;
            [self.navigationController pushViewController:chatView animated:YES];
            
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
}

// 数据接收完毕
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    NSLog(@"finishLoading");
}
// 返回错误
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    NSLog(@"Connection failed: %@", error);
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(!_isWillAdd)
    {
        return 2;
    }
    else
    {
        return 3;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row ==0)
    {
        JYBFileTypeCell *cell = [JYBFileTypeCell cellWithTableView:tableView indexPath:indexPath];
        if(!_isWillAdd)
        {
            cell.handleImageView.image = [UIImage imageNamed:@"添加附件"];
        }
        else
        {
            cell.handleImageView.image = [UIImage imageNamed:@"减少"];
        }
        cell.fileTypeBlock = ^(UIButton *sender,NSInteger index)
        {
            NSLog(@"index:%ld %ld",(long)index,(long)sender.tag);
            if(index ==154)
            {
                _isWillAdd = !_isWillAdd;
                NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
                [fileTable reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                float height = 0.0f;
                if (_isWillAdd){
                    height += 100;
                }else{
                    height -= 100;
                }
                CGRect tableFrame = fileTable.frame;
                fileTable.frame = CGRectMake(tableFrame.origin.x, tableFrame.origin.y, tableFrame.size.width, tableFrame.size.height + height);
                CGRect btnFrame = saveBtn.frame;
                saveBtn.frame = CGRectMake(btnFrame.origin.x, fileTable.frame.origin.y + fileTable.frame.size.height + 5, btnFrame.size.width, btnFrame.size.height);
            }
            else if(index ==150)
            {
                fileType = JYBDownloadFileTypeImage;
                iconArray = photoArray;
                nameArray = [NSMutableArray array];
                for(int i = 0;i< iconArray.count ; i++)
                {
                    [nameArray addObject:@""];
                }
                [fileTable reloadData];
            }
            else if (index ==151)
            {
                fileType = JYBDownloadFileTypeMP3;
                
                iconArray = voiceArray;
                nameArray = voiceDurationArray;
                [fileTable reloadData];
            }
            else if(index ==152)
            {
                fileType = JYBDownloadFileTypeMP4;
                
                iconArray = videoArray;
                nameArray = videoDurationArray;
                [fileTable reloadData];
            }
            else if(index == 153)
            {
                iconArray = fileArray;
                nameArray = [NSMutableArray array];
                for(int i = 0;i< iconArray.count ; i++)
                {
                    [nameArray addObject:@""];
                }
                
            }
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    if(indexPath.row ==1)
    {
        if(!_isWillAdd)
        {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
            [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
            NSInteger count = iconArray.count/4 +1 ;
            JYBFileTypeCollectionView *collectionView =[[JYBFileTypeCollectionView alloc] initWithFrame:CGRectMake(0, 0, Mwidth, Mwidth/4*count) collectionViewLayout:flowLayout];
            collectionView.fileType = fileType;
            collectionView.type = 1;
            collectionView.nameArr = nameArray;
            collectionView.imageArr = iconArray;
            collectionView.substractBlock = ^{
                
            };
            [cell.contentView addSubview:collectionView];
            return cell;
        }
        else
        {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            JYBFileTypeView *typeView = [[JYBFileTypeView alloc] initWithFrame:CGRectMake(0, 0, Mwidth, Mwidth/4+10)];
            typeView.delegate = self;
            typeView.itemBlock = ^(NSInteger index)
            {
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
            [cell.contentView addSubview:typeView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        }
    }
    else if (indexPath.row ==2)
    {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        NSInteger count = iconArray.count/4 +1 ;
        JYBFileTypeCollectionView *collectionView =[[JYBFileTypeCollectionView alloc] initWithFrame:CGRectMake(0, 0, Mwidth, Mwidth/4*count) collectionViewLayout:flowLayout];
        collectionView.type =1;
        collectionView.fileType = fileType;
        collectionView.nameArr = nameArray;
        collectionView.imageArr = iconArray;
        collectionView.substractBlock = ^{
            
        };
        [cell.contentView addSubview:collectionView];
        return cell;
        
    }
    return nil;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row ==0)
    {
        return 44;
    }
    else if(indexPath.row ==1)
    {
        if(!_isWillAdd)
        {
            
            NSInteger count = iconArray.count/4 +1 ;
            return Mwidth/4*count;
        }
        else
        {
            
            return Mwidth/4+20;
        }
    }
    else if(indexPath.row ==2)
    {
        NSInteger count = iconArray.count/4 +1 ;
        return Mwidth/4*count;
    }
    return 0;
}

//文件上传
- (void)uploadFileWithDictionary:(NSDictionary *)dictionary withFiledata:(NSData *)filedata withFileName:(NSString *)fileName{
//    AFHTTPRequestSerializer * serializer = [AFHTTPRequestSerializer serializer];
//    NSString * urlString = [NSString stringWithFormat:@"%@WorkAsp/Extend/FileManager/Muliupload/jianyunbaoUpload.aspx",JYB_erpRootUrl];
//    NSDictionary * params = @{@"enterpriseCode":JYB_enterpriseCode,
//                              @"FolderID":dictionary[@"projectId"],
//                              @"FolderName":dictionary[@"titleName"],
//                              @"BusinessClass":dictionary[@"projectName"],
//                              @"FileName":fileName,
//                              @"employeeId":JYB_userId,
//                              @"employeeName":JYB_userName,
//                              @"filedata":fileName};
//    NSLog(@"...%@",params);
//    NSMutableURLRequest * request = [serializer multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        [formData appendPartWithFileData:filedata name:@"uploadImg" fileName:@"uploadImg.jpg" mimeType:@"image/jpeg"];
//    } error:nil];
//    AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        NSError * jsonError;
//        NSDictionary * jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableContainers | NSJSONReadingMutableContainers | NSJSONReadingAllowFragments) error:&jsonError];
//        if(jsonObject){
//            NSLog(@"上传成功：%@",jsonObject);
//            if([jsonObject[@"result"] boolValue]){
//                showMessage(@"操作成功！");
//            }
//        }else{
//            NSLog(@"json error : %@",jsonError.localizedDescription);
//        }
//    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
//        NSLog(@"%@",error.localizedDescription);
//    }];
//    [operation start];
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
            [self uploadFileWithDictionary:@{} withFiledata:[NSData dataWithContentsOfFile:recordPath] withFileName:[NSString stringWithFormat:@"%@.amr",[self stringFromDate:[NSDate date]]]];
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
        
        [self uploadFileWithDictionary:@{} withFiledata:[NSData dataWithContentsOfFile:toPath] withFileName:[NSString stringWithFormat:@"%@.mp4",[self stringFromDate:[NSDate date]]]];
        
        
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
            
            [self uploadFileWithDictionary:@{} withFiledata:UIImageJPEGRepresentation(orgImage, 0.5) withFileName:fileName];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
