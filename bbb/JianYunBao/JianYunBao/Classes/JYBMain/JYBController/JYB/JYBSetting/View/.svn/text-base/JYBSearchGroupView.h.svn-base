//
//  JYBSearchGroupView.h
//  JianYunBao
//
//  Created by sks on 25/03/16.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clearBtnBlock)();
typedef void(^searchBtnBlock)();
typedef void(^styleBtnBlock)();
typedef void(^startDateBtnBlock)();
typedef void(^endDateBtnBlock)();


@interface JYBSearchGroupView : UIView

@property (weak, nonatomic) IBOutlet UITextView *nameTextView;

@property (weak, nonatomic) IBOutlet UIButton *styleBtn;

@property (weak, nonatomic) IBOutlet UIButton *startDateBtn;
@property (weak, nonatomic) IBOutlet UIButton *endDateBtn;
@property (weak, nonatomic) IBOutlet UIButton *clearBtn;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;

@property (nonatomic,copy)  clearBtnBlock clearBlock;
@property (nonatomic,copy) searchBtnBlock searchBlock;
@property (nonatomic,copy) styleBtnBlock styleBlock;
@property (nonatomic,copy) startDateBtnBlock startBlock;
@property (nonatomic,copy) endDateBtnBlock endBlock;

@end
