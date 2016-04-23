//
//  JYBPersonalInformationViewController.h
//  JianYunBao
//
//  Created by 宋亚伟 on 16/3/1.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBBaseViewController.h"
#import "JYBFriendItem.h"

@interface JYBPersonalInformationViewController : JYBBaseViewController

@property (nonatomic, strong) JYBFriendItem *friendItem;
@property (nonatomic, copy)void (^updataBlock)();
@end
