//
//  JYBCreateDiscussInputTextView.h
//  JianYunBao
//
//  Created by 正 on 16/4/1.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JYBCreateDiscussInputTextViewDelegate <NSObject>

- (void)inputDiscussText;

@end
@interface JYBCreateDiscussInputTextView : UIView

@property (nonatomic, strong) UITextField * input;
@property (nonatomic, assign) id <JYBCreateDiscussInputTextViewDelegate> delegate;

@end
