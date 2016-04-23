//
//  JYBSearchView.h
//  JianYunBao
//
//  Created by sks on 25/03/16.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClearBlock)();
typedef void(^SearchBlock)();
typedef void(^CreatPeopleBlock)();
typedef void(^ResponsblePeopleBlock)();
typedef void(^StartDateBlock)();
typedef void(^EndDateBlock)();


@interface JYBSearchView : UIView




@property (weak, nonatomic) IBOutlet UITextView *titleTextView;

@property (weak, nonatomic) IBOutlet UIButton *creatButton;

@property (weak, nonatomic) IBOutlet UIButton *responsibleButton;
@property (weak, nonatomic) IBOutlet UIButton *startDateButton;

@property (weak, nonatomic) IBOutlet UIButton *endDateButton;

@property (weak, nonatomic) IBOutlet UIButton *clearBtn;

@property (weak, nonatomic) IBOutlet UIButton *searchBtn;

@property (nonatomic,copy) ClearBlock clearBlock;
@property (nonatomic,copy) SearchBlock searchBlock;
@property (nonatomic,copy) CreatPeopleBlock creatPeopleBlock;
@property (nonatomic,copy) ResponsblePeopleBlock responsblePeopleBlock;
@property (nonatomic,copy) StartDateBlock startDateBlock;
@property (nonatomic,copy) EndDateBlock endDateBlock;



@end
