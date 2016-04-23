//
//  JYBAppSafeViewController.h
//  JianYunBao
//
//  Created by 宋亚伟 on 16/2/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBBaseViewController.h"

@protocol JYBAppSafeViewControllerDelegate <NSObject>

- (void)backContinue;

@end

@interface JYBAppSafeViewController : JYBBaseViewController

@property (nonatomic, assign) id <JYBAppSafeViewControllerDelegate> delegate;

@end
