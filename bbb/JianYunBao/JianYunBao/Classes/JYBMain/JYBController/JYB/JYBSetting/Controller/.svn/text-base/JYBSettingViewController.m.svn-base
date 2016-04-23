//
//  JYBSettingViewController.m
//  JianYunBao
//
//  Created by 冰点 on 16/1/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBSettingViewController.h"
#import "JYBSettingCell.h"
#import "JYBSettingHeaderCell.h"
#import "JYBSettingEntity.h"
#import "JYBModifyPwdViewController.h"
#import "JYBTextFieldController.h"
#import "JYBAppSettingViewController.h"
#import "SYWCommonRequest.h"
#import "JYBUserItemTool.h"
#import "JYBUserTool.h"
#import "JYBUserItem.h"

@interface JYBSettingViewController ()<UITableViewDelegate, UITableViewDataSource,JYBTextFieldControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSArray <JYBSettingEntity*>*settingTypeArray;
    UIImage     *_image;
    NSDictionary    *po;
    UIView *view;
}

@property (weak, nonatomic) IBOutlet BDBaseTableView *table;
@property (nonatomic,strong) JYBUserItem *user;
@property (nonatomic, weak) NSIndexPath *tempIndexPath;


@end

@implementation JYBSettingViewController

- (JYBUserItem *)user
{
    if (_user == nil) {
        _user = [JYBUserTool user];
        
    }
    return _user;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
//MARK: Init
- (instancetype)init
{
    if (self = [super init]) {
        settingTypeArray = [self getSettingTypeData];
    }
    return self;
}

//MARK: setter & getter

//MARK: loadData
- (NSArray <JYBSettingEntity *>*)getSettingTypeData
{
    return [JYBSettingEntity mj_objectArrayWithFilename:@"JYBSettingTypeList.plist"];
}





//MARK: Action

//MARK: UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [settingTypeArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [[settingTypeArray[section] list] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (!indexPath.section) {
         JYBSettingHeaderCell  *cell = [JYBSettingHeaderCell cellWithTableView:tableView indexPath:indexPath];
        cell.tag = 123;
        [(JYBSettingHeaderCell *)cell setUser:self.user];
        
        cell.pickerBlock = ^{
            [self loadChoosView];
        };
        return cell;
        
    } else {
       JYBSettingCell *settingCell = [JYBSettingCell cellWithTableView:tableView indexPath:indexPath];
        JYBSettingEntity *entity = settingTypeArray[indexPath.section];
        [(JYBSettingCell *)settingCell setSettingEntity:entity.list[indexPath.row]];
        [(JYBSettingCell *)settingCell setUser:self.user];
        return settingCell;
    }
}
#pragma mark - 上传用户头像

- (void)loadChoosView
{
    
    if (!view)
    {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mwidth, Mheight)];
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        UIView *selectView = [[UIView alloc] init];
        selectView.frame = CGRectMake((Mwidth-260)/2, (Mheight-90)/2, 260, 90);
        selectView.layer.cornerRadius = 10;
        selectView.backgroundColor = [UIColor whiteColor];
        [view addSubview:selectView];
        NSArray *array = @[@"拍照",@"相册"];
        for (int i=0; i<2; i++)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:array[i] forState:UIControlStateNormal];
            btn.tag = i;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(butnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.frame = CGRectMake(0, 45*i, 260, 44);
            
            [selectView addSubview:btn];
        }
        [self.view addSubview:view];
    }
    view.hidden = NO;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    view.hidden = YES;
}

- (void)butnClick:(UIButton *)sender
{
    view.hidden=YES;
    if (sender.tag==0)
    {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            NSLog(@"拍照了！！");
            UIImagePickerController *pic =[[UIImagePickerController alloc] init];
            [pic setSourceType:UIImagePickerControllerSourceTypeCamera];
            pic.delegate = self;
            pic.allowsEditing = YES;
            [self presentViewController:pic animated:YES completion:^{
                
            }];
        }
    }
    else if (sender.tag==1)
    {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            UIImagePickerController *pic = [[UIImagePickerController alloc] init];
            [pic setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            pic.delegate =self;
            pic.allowsEditing = YES;
            [self presentViewController:pic animated:YES completion:^{
                
            }];
        }
    }
}


#pragma mark-UIImagePickerControllerDelegate
// 取消 上传
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
//选择图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    _image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    //获取图片路径
    NSURL *imageURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    //获取图片名称
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        ALAssetRepresentation *representation = [myasset defaultRepresentation];
        NSString *fileName = [representation filename];
    
        if(fileName.length == 0)
        {
            fileName = [NSString stringWithFormat:@"userHeadImage.JPG"];
        }
        
        [self uploadFileWithDictionary:po withFiledata:UIImageJPEGRepresentation(_image, 0.5) withFileName:fileName];
    };
    
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    [assetslibrary assetForURL:imageURL
                   resultBlock:resultblock
                  failureBlock:nil];
}


//上传头像
- (void)uploadFileWithDictionary:(NSDictionary *)dictionary withFiledata:(NSData *)filedata withFileName:(NSString *)fileName
{
    AFHTTPRequestSerializer * serializer = [AFHTTPRequestSerializer serializer];
    NSString * urlString = [NSString stringWithFormat:@"%@WorkAsp/Extend/FileManager/Muliupload/jianyunbaoUpload.aspx",JYB_erpRootUrl];
    NSDictionary * params = @{@"enterpriseCode":JYB_enterpriseCode,
                              @"FolderID":self.user.iconPathId,
                              @"FolderName":@"sys_qx_employee",
                              @"BusinessClass":@"员工基本信息表",
                              @"FileName":fileName,
                              @"employeeId":JYB_userId,
                              @"employeeName":JYB_userName,
                              @"filedata":fileName};
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
                //获取用户资料
                [self getUser:JYB_userId];
            }
        }else{
            NSLog(@"json error : %@",jsonError.localizedDescription);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"%@",error.localizedDescription);
    }];
    [operation start];
    
    
}

- (void)getUser:(NSString *)userId{
    SYWCommonRequest *api = [[SYWCommonRequest alloc] init];
    api.ReqURL = JYBErpHttpUrl(@"jianyunbao.aspx");
    api.ReqDictionary = @{@"method":@"getUserInfo",
                          @"enterpriseCode":JYB_enterpriseCode,
                          @"id":userId};
    __weak typeof(self) weakSelf = self;
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        if (GoodResponse) {
            weakSelf.user = [JYBUserItem mj_objectWithKeyValues:APIJsonObject];
            [RuntimeStatus sharedInstance].userItem = weakSelf.user;
            if ([JYBUserItemTool users:userId].count) {
                [JYBUserItemTool updateUser:weakSelf.user];
            }else{
                [JYBUserItemTool addUser:weakSelf.user];
            }
            [JYBUserTool saveUser:weakSelf.user];
            [weakSelf.table reloadData];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeUserHeadNotification" object:nil];
        }else{
            [self showHint:BadResponseMessage];
        }
        
    } failure:^(YTKBaseRequest *request) {
    }];
}


//MARK: UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (!indexPath.section) {
        return [JYBSettingHeaderCell heightForRow];
    } else {
        return [JYBSettingCell heightForRow];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    if (!section) {
        return Compose_Scale(14);
    } else {
        if (section == 1) {
            return Compose_Scale(24);
        } else {
            return Compose_Scale(10);
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == [settingTypeArray count] - 1) {
        return 0;
    } else {
        return 0.01;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = nil;
    if (section == 1) {
        headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, Compose_Scale(24))];
        headerView.backgroundColor = [UIColor clearColor];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCR_WIDTH - 10 * 2, headerView.height)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.text = @"基础资料";
        titleLabel.textColor = [UIColor hexFloatColor:@"808080"];
        titleLabel.font = [UIFont boldSystemFontOfSize:Compose_Scale(12)];
        [headerView addSubview:titleLabel];
    }
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.tempIndexPath = indexPath;
    __weak typeof(self) weakSelf = self;
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            [self pushNextController:@"JYBTextFieldController" hidesBottomBarWhenPushed:YES complete:^(UIViewController *vCtrl) {
                [(JYBTextFieldController *)vCtrl setDelegate:weakSelf];
                [(JYBTextFieldController *)vCtrl setNavigationTitle:@"更改邮箱"];
                [(JYBTextFieldController *)vCtrl setPlaceholder:@"邮箱"];
                [(JYBTextFieldController *)vCtrl setContent:[weakSelf.user.email copy]];
                [(JYBTextFieldController *)vCtrl setWarm:@"及时更新邮箱可以让你的好朋友更容易联系你"];
                [(JYBTextFieldController *)vCtrl setIndexPath:indexPath];
            }];
        } else if (indexPath.row == 2) {
            [self pushNextController:@"JYBTextFieldController" hidesBottomBarWhenPushed:YES complete:^(UIViewController *vCtrl) {
                [(JYBTextFieldController *)vCtrl setDelegate:weakSelf];
                [(JYBTextFieldController *)vCtrl setNavigationTitle:@"更改手机号"];
                [(JYBTextFieldController *)vCtrl setPlaceholder:@"手机号"];
                [(JYBTextFieldController *)vCtrl setContent:[weakSelf.user.phoneNum copy]];
                [(JYBTextFieldController *)vCtrl setWarm:@"及时更新电话可以让你的好朋友更容易联系你"];
                [(JYBTextFieldController *)vCtrl setIndexPath:indexPath];
            }];
        }
    } else if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            [self pushNextController:@"JYBModifyPwdViewController" hidesBottomBarWhenPushed:YES];
        } else {
            [self pushNextController:@"JYBAppSettingViewController" hidesBottomBarWhenPushed:YES complete:^(UIViewController *vCtrl) {
                [(JYBAppSettingViewController *)vCtrl setNavigationTitle:@"设置"];
            }];
        }
    }
}

//MARK: Other
#pragma mark -JYBTextFieldControllerDelegate 代理方法
- (void)updataContent:(NSString *)content{
    NSLog(@"-------%@",content);
    if (self.tempIndexPath.section == 1) {
        if (self.tempIndexPath.row == 1) {
            //改邮箱
            [self updataReq:content isEmail:YES];
        }else if(self.tempIndexPath.row == 2){
            //改手机
            [self updataReq:content isEmail:NO];
        }
    }
}

#pragma mark - 网络请求方法
- (void)updataReq:(NSString *)content isEmail:(BOOL)isEmail{
    
    SYWCommonRequest *api = [[SYWCommonRequest alloc] init];
    api.ReqURL = [NSString stringWithFormat:@"%@/JianyunBao.aspx?",JYB_erpHttpUrl];

    if (isEmail) {
        api.ReqDictionary =
        @{
          @"method":@"UpdateEmail",
          @"employeeId":JYB_userId,
          @"enterpriseCode":JYB_enterpriseCode,
          @"email":content
          };
    }else{
        api.ReqDictionary =
        @{
          @"method":@"UpdateMobile",
          @"employeeId":JYB_userId,
          @"enterpriseCode":JYB_enterpriseCode,
          @"mobilePhone":content
          };
    }

        __weak typeof(self) weakSelf = self;
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        DLogJSON(request.responseJSONObject);
        if (GoodResponse) {
            [self showHint:@"操作成功"];
            if (isEmail) {
                weakSelf.user.email = content;
            }else{
                weakSelf.user.phoneNum = content;
            }
            [JYBUserTool saveUser:weakSelf.user];
            [JYBUserItemTool updateUser:weakSelf.user];
            [weakSelf.table reloadData];
        }else{
            [self showHint:BadResponseMessage];
        }
        
    } failure:^(YTKBaseRequest *request) {
    }];
}


@end
