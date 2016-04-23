//
//  JYBQueryTwoToastView.h
//  JianYunBao
//
//  Created by faith on 16/3/17.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ClearBlock)();
typedef void(^SearchBlock)();
typedef void(^SelectPeopleBlock)();
typedef void(^SelectProjectBlock)();
@interface JYBQueryTwoToastView : UIView
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIButton *createButton;
@property (weak, nonatomic) IBOutlet UIButton *responsibleButton;
@property (weak, nonatomic) IBOutlet UIButton *projectButton;

@property (weak, nonatomic) IBOutlet UIButton *clearButton;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@property (weak, nonatomic) IBOutlet UIButton *allDateButton;

@property (weak, nonatomic) IBOutlet UIButton *notOverdue;

@property (weak, nonatomic) IBOutlet UIButton *overDue;
@property (weak, nonatomic) IBOutlet UIButton *allTwo;

@property (weak, nonatomic) IBOutlet UIButton *onWay;
@property (weak, nonatomic) IBOutlet UIButton *complete;
@property (weak, nonatomic) IBOutlet UIButton *pause;
@property (weak, nonatomic) IBOutlet UIButton *cancle;
@property (weak, nonatomic) IBOutlet UIButton *allThree;
@property (weak, nonatomic) IBOutlet UIButton *today;
@property (weak, nonatomic) IBOutlet UIButton *inThreeDay;
@property (weak, nonatomic) IBOutlet UIButton *thisWeek;
@property (weak, nonatomic) IBOutlet UIButton *thisMonth;
@property (nonatomic ,copy) ClearBlock clearBlock;
@property (nonatomic ,copy) SearchBlock searchBlock;
@property (nonatomic ,copy) SelectPeopleBlock selectPeopleBlock;
@property (nonatomic ,copy) SelectProjectBlock selectProjectBlock;


@property (nonatomic ,assign) NSInteger type;

@property (weak, nonatomic) IBOutlet UILabel *typeLBL;


@property (weak, nonatomic) IBOutlet UIView *responsibleView;

@property (weak, nonatomic) IBOutlet UIView *createView;

@property (weak, nonatomic) IBOutlet UIView *projectView;

@property (weak, nonatomic) IBOutlet UIView *statusView;
@property (weak, nonatomic) IBOutlet UIView *dateView;

@end
