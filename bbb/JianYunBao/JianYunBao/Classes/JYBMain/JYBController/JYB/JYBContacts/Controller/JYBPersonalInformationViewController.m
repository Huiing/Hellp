//
//  JYBPersonalInformationViewController.m
//  JianYunBao
//
//  Created by 宋亚伟 on 16/3/1.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBPersonalInformationViewController.h"
#import "JYBPersonalHeaderTableViewCell.h"
#import "JYBPersonalBtnTableViewCell.h"
#import "JYBPersonalTableViewCell.h"
#import "BDBaseTableView.h"
#import "SYWCommonRequest.h"
#import "RegularJudge.h"
#import <UIButton+WebCache.h>
#import "JYBChatViewController.h"
#import "JYBConversationModule.h"
#import "BDIMDatabaseUtil.h"

@interface JYBPersonalInformationViewController ()<JYBPersonalBtnTableViewCellDelegate,JYBPersonalHeaderTableViewCellDelegate>


@property (weak, nonatomic) IBOutlet BDBaseTableView *table;
/** 遮盖 */
@property (nonatomic, weak) UIButton *cover;
@property (nonatomic, copy) NSString *isContact;
@property (nonatomic, assign) CGRect iconFrame;
@property (nonatomic, weak) JYBPersonalHeaderTableViewCell *headerCell;

@property (nonatomic, strong) UIButton *tempBtn;
@property (nonatomic, strong) UIButton *btn;

@end

@implementation JYBPersonalInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.table.sectionFooterHeight = 0.01;
    _isContact = [self.friendItem.isContact copy];
}
//MARK: setter & getter

- (void)setTable:(BDBaseTableView *)table{
    _table = table;
    [table hideTableViewCellSeparator];
}

//MARK: loadData

//MARK: Action
- (void)backBarBtnItemClick
{
    if (![self.friendItem.isContact isEqualToString:_isContact]) {
        if (_updataBlock) {
            _updataBlock();
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}
//MARK: BDIndexTableViewDelegate


//MARK: UITableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!section) {
        return 4;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![indexPath section]) {
        JYBPersonalTableViewCell *cell = [JYBPersonalTableViewCell cellWithTableView:tableView indexPath:indexPath];
        cell.friendItem = self.friendItem;
        return cell;
    }else{
        JYBPersonalBtnTableViewCell *cell = [JYBPersonalBtnTableViewCell cellWithTableView:tableView indexPath:indexPath];
        cell.delegate = self;
        cell.contact = self.friendItem.isContact;
        return cell;
    }

}

//MARK: UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    JYBPersonalHeaderTableViewCell *headerView = nil;
    if (!section) {
    headerView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JYBPersonalHeaderTableViewCell class]) owner:self options:nil] lastObject];
        headerView.backgroundColor = [UIColor clearColor];
        headerView.delegate = self;
        headerView.friendItem = self.friendItem;
    }
    
    return headerView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 100;
    }else if (section == 1){
        return 15;
    }else {
        return 0.01;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}

#pragma mark - 网络请求
- (void)addCommonContactReq{
    
    SYWCommonRequest *api = [[SYWCommonRequest alloc] init];
    api.ReqURL = [NSString stringWithFormat:@"%@/JianyunBao.aspx?",JYB_erpHttpUrl];
    api.ReqDictionary =
    @{
      @"method":@"AddCommonContact",
      @"employeeId":JYB_userId,
      @"commonContactId":self.friendItem.friendId,
      @"enterpriseCode":JYB_enterpriseCode
      };
        __weak typeof(self) weakSelf = self;
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        DLogJSON(request.responseJSONObject);
        if (GoodResponse) {
            weakSelf.friendItem.isContact = @"1";
            [weakSelf.table reloadData];
        }else{
            [self showHint:BadResponseMessage];
        }
        
    } failure:^(YTKBaseRequest *request) {
    }];
}

- (void)deleteCommonContactReq{
    
    SYWCommonRequest *api = [[SYWCommonRequest alloc] init];
    api.ReqURL = [NSString stringWithFormat:@"%@/JianyunBao.aspx?",JYB_erpHttpUrl];
    api.ReqDictionary =
    @{
      @"method":@"DeleteCommonContact",
      @"employeeId":JYB_userId,
      @"recordId":self.friendItem.friendId
      };
    __weak typeof(self) weakSelf = self;
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        DLogJSON(request.responseJSONObject);
        if (GoodResponse) {
            weakSelf.friendItem.isContact = @"0";
            [weakSelf.table reloadData];
        }else{
            [self showHint:BadResponseMessage];
        }
        
    } failure:^(YTKBaseRequest *request) {
    }];
}

#pragma mark - JYBPersonalBtnTableViewCellDelegate代理方法
- (void)btnClick:(NSIndexPath *)indexPath{
    DLog(@"btnClick");
    if (indexPath.section == 1) {
        if ([self.friendItem.friendId isEqualToString:[RuntimeStatus sharedInstance].userItem.userId]) {
            showMessageCenterHUD(@"不能和自己聊天！");
            return;
        }
        
        //insert DB of conversation
        [[JYBConversationModule sharedInstance] getRecentConversationWithConversationType:JYBConversationTypeSingle];
        JYBConversation *conversation = [[JYBConversation alloc] initWithChatter:self.friendItem.friendId conversationtype:JYBConversationTypeSingle];
        
        
        JYBConversation *get_conversation =  [[JYBConversationModule sharedInstance] getConversationWithChatter:conversation.chatter];
        if (!get_conversation) {
            [[BDIMDatabaseUtil sharedInstance] insertConversations:@[conversation]];
        }
        JYBChatViewController *chatView = [[JYBChatViewController alloc] initWithChatter:self.friendItem.friendId type:JYBConversationTypeSingle];
        chatView.navigationTitle = self.friendItem.name;
        [self.navigationController pushViewController:chatView animated:YES];

    }else if (indexPath.section == 2){
        if ([RegularJudge validateMobile:self.friendItem.phoneNum]) {
              [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.friendItem.phoneNum]]];
        }else{
            [self showHint:@"无效的手机号码"];
        }

    }else if (indexPath.section == 3){
        if ([RegularJudge validateMobile:self.friendItem.phoneNum]) {
           [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms://%@",self.friendItem.phoneNum]]];
        }else{
            [self showHint:@"无效的手机号码"];
        }
    }else if (indexPath.section == 4){
        if ([self.friendItem.isContact isEqualToString:@"0"]) {
            [self addCommonContactReq];
        }else{
            [self deleteCommonContactReq];
        }
        
    }
}

#pragma mark - 放大头像
- (UIButton *)btn{
    if (_btn == nil) {
        _btn = [[UIButton alloc] init];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",JYB_erpRootUrl,self.friendItem.iconPaths]];
        [_btn sd_setBackgroundImageWithURL:url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"图片默认图标"]];
    }
    return _btn;
}

- (void)iconClick:(UIButton *)btn view:(JYBPersonalHeaderTableViewCell *)header{
    self.iconFrame = [header convertRect:btn.frame toView:self.view];
    self.headerCell = header;
    if (self.cover == nil) { // 没有遮盖,要放大
        [self bigImg];
    } else { // 有遮盖,要缩小
        [self smallImg];
    }
}

/**
 *  大图
 */
- (void)bigImg{

    // 1.添加阴影
    UIButton *cover = [[UIButton alloc] init];
    cover.frame = [UIScreen mainScreen].bounds;
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.0;
    [cover addTarget:self action:@selector(smallImg) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cover];
    self.cover = cover;
    self.btn.hidden = NO;
    self.btn.frame = self.iconFrame;
    // 2.更换阴影和头像的位置
    [self.view addSubview:self.btn];
    [self.view bringSubviewToFront:self.btn];
    
    // 3.执行动画
    [UIView animateWithDuration:0.25 animations:^{
        // 3.1.阴影慢慢显示出来
        cover.alpha = 0.7;
        
        // 3.2.头像慢慢变大,慢慢移动到屏幕的中间
        CGFloat iconW = Mwidth;
        CGFloat iconH = iconW;
        CGFloat iconY = (Mheight - iconH) * 0.5;
        self.btn.frame = CGRectMake(0, iconY, iconW, iconH);
    }];
}

/**
 *  小图
 */
- (void)smallImg
{
    
    // 1.头像慢慢变为原来的位置和尺寸
//    self.btn.frame = [self.view convertRect:self.iconFrame toView:self.headerCell];

//    [self.headerCell addSubview:self.btn];
    
    // 执行动画
    [UIView animateWithDuration:0.25 animations:^{
        // 存放需要执行动画的代码
        self.btn.frame = self.iconFrame;
        
        // 2.阴影慢慢消失
        self.cover.alpha = 0.0;
    } completion:^(BOOL finished) {
        // 动画执行完毕后会自动调用这个block内部的代码
        
        // 3.动画执行完毕后,移除遮盖(从内存中移除)
//        [self.btn removeFromSuperview];
//        self.btn = nil;
        self.btn.hidden = YES;
        [self.cover removeFromSuperview];
        self.cover = nil;
    }];
}



@end
