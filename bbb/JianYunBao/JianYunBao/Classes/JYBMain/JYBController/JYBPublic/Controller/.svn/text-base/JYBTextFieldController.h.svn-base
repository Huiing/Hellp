//
//  JYBTextFieldController.h
//  JianYunBao
//
//  Created by 冰点 on 16/1/28.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBBaseViewController.h"

@protocol JYBTextFieldControllerDelegate <NSObject>

@optional
- (void)updataContent:(NSString *)content;

@end

@interface JYBTextFieldController : JYBBaseViewController

@property (nonatomic, weak) id<JYBTextFieldControllerDelegate> delegate;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *warm;
@property (nonatomic, weak) NSIndexPath *indexPath;

@end
