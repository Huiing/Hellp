//
//  JYBCreateDiscussNameView.h
//  JianYunBao
//
//  Created by 正 on 16/4/1.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JYBCreateDiscussNameViewDelegate <NSObject>

- (void)discussName;

@end

@interface JYBCreateDiscussNameView : UIView

@property(strong, nonatomic) UITextField * input;
@property(assign, nonatomic) id <JYBCreateDiscussNameViewDelegate> delegate;

@end
