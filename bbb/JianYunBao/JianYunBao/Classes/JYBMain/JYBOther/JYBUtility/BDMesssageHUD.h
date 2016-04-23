//
//  BDMesssageHUD.h
//  JianYunBao
//
//  Created by 冰点 on 16/1/27.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 HUD 配置
 */

@interface BDMesssageHUD : UIView
@end

void showMessage(NSString *message);
void showMessageBottomHUD(NSString *message);
void showMessageCenterHUD(NSString *message);