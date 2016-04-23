//
//  JYBAnnouncementView.h
//  JianYunBao
//
//  Created by sks on 28/03/16.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^monthBtnBlock)();
typedef void(^clearchBlock)();
typedef void(^searchBlock)();



@interface JYBAnnouncementView : UIView
@property (weak, nonatomic) IBOutlet UITextView *titleTextView;
@property (weak, nonatomic) IBOutlet UIButton *monthBtn;
@property (weak, nonatomic) IBOutlet UIButton *clearBtn;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;

@property (nonatomic,copy) monthBtnBlock monthBlock;
@property (nonatomic,copy) clearchBlock clearchBlock;
@property (nonatomic,copy) searchBlock searchBlock;

@end
