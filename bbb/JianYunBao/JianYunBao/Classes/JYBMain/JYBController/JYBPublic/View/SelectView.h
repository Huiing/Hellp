//
//  SelectView.h
//  MySchoolMobile
//
//  Created by faith on 15/10/22.
//  Copyright (c) 2015年 faith. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectIndexDelegate <NSObject>
@optional
- (void)didSelectedAtIndex:(NSInteger )index;
@end

@interface SelectView : UIView
@property(nonatomic ,retain)NSArray *titleArr;
@property(nonatomic ,assign)NSInteger type;
@property(nonatomic ,assign)id<SelectIndexDelegate>delegate;
- (void)initSubView;
@end
