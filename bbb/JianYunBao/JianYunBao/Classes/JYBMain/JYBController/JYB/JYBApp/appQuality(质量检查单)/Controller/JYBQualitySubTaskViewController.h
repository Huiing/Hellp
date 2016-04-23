//
//  JYBQualitySubTaskViewController.h
//  JianYunBao
//
//  Created by faith on 16/3/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBBaseViewController.h"
#import "JYBQualitySubtaskItem.h"
@interface JYBQualitySubTaskViewController : JYBBaseViewController
@property (nonatomic ,copy) NSString *taskStatus;
@property (nonatomic ,copy) NSMutableArray *userIdsArray;
@property (nonatomic ,strong) JYBQualitySubtaskItem *qualitySubtaskItem;

@end
