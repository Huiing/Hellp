//
//  JYBToastView.h
//  JianYunBao
//
//  Created by faith on 16/3/12.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ToastViewDelegate <NSObject>
- (void)cancleAction;
- (void)confirmAction;
@end

@interface JYBToastView : UIView
@property (nonatomic, assign) id<ToastViewDelegate> delegate;
@property (nonatomic ,strong) UITextField *orderTextField;
@property (nonatomic ,strong) UITextField *taskTextField;
@property (nonatomic ,strong) UITextView *describeTextView;
@end
