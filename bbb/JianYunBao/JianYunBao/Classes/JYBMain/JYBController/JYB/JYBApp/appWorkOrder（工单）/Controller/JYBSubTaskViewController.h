//
//  JYBSubTaskViewController.h
//  JianYunBao
//
//  Created by faith on 16/3/20.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBBaseViewController.h"
#import "JYBSubtaskItem.h"
@interface JYBSubTaskViewController : JYBBaseViewController
@property (nonatomic ,copy) NSString *taskStatus;
@property (nonatomic ,copy) NSMutableArray *userIdsArray;
@property (nonatomic ,strong) JYBSubtaskItem *subTaskItem;
@property (nonatomic ,copy) NSString *orderId;
@end
