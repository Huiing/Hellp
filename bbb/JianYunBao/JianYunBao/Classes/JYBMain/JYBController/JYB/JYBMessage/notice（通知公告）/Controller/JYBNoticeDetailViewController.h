//
//  JYBNoticeDetailViewController.h
//  JianYunBao
//
//  Created by 正 on 16/3/16.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBBaseViewController.h"

@interface JYBNoticeDetailViewController : JYBBaseViewController

//公告id
@property (nonatomic, strong) NSString * newsId;
//公告url
@property (nonatomic, strong) NSString * url;
//赞数量
@property (nonatomic, strong) NSString * agreeCount;

@end
