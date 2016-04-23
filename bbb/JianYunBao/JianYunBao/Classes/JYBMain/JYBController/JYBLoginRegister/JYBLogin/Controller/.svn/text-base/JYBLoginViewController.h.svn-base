//
//  JYBLoginViewController.h
//  JianYunBao
//
//  Created by 冰点 on 16/1/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBBaseViewController.h"

///登录类型
typedef NS_ENUM(NSUInteger, JYBLoginModal) {
    JYBLoginModalPush = 0,//Nav
    JYBLoginModalPresent,//模态
    JYBLoginModalDefault = JYBLoginModalPush,
};

@interface JYBLoginViewController : JYBBaseViewController

@property (nonatomic, assign) JYBLoginModal loginModal;
@property (nonatomic, copy) void(^loginCompleted)();

@end
