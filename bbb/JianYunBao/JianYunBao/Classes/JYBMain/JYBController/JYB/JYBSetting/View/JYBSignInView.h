//
//  JYBSignInView.h
//  JianYunBao
//
//  Created by sks on 28/03/16.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^yearBlock)();
typedef void(^clearBlock)();
typedef void(^searchBlock)();

@interface JYBSignInView : UIView
@property (weak, nonatomic) IBOutlet UIButton *yearBtn;
@property (weak, nonatomic) IBOutlet UIButton *clearBtn;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;

@property (nonatomic,copy) yearBlock yearBlock;
@property (nonatomic,copy) clearBlock clearBlock;
@property (nonatomic,copy) searchBlock searchBlock;


@end
