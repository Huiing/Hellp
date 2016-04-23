//
//  JYBSetOrderStatusView.h
//  JianYunBao
//
//  Created by faith on 16/3/23.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SelectOrderStatusViewDelegate <NSObject>
- (void)cancleOrderStatusAction;
- (void)confirmOrderStatusAction;
- (void)passOrderStatus:(NSInteger)status;
@end

@interface JYBSetOrderStatusView : UIView
@property (nonatomic, assign) id<SelectOrderStatusViewDelegate> delegate;
@end
