//
//  JYBSetStatusView.h
//  JianYunBao
//
//  Created by faith on 16/3/19.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SelectStatusViewDelegate <NSObject>
- (void)cancleStatusAction;
- (void)confirmStatusAction;
- (void)passStatu:(NSInteger)status;
@end

@interface JYBSetStatusView : UIView
@property (nonatomic,copy) NSString *state;
@property (nonatomic, assign) id<SelectStatusViewDelegate> delegate;
@end
