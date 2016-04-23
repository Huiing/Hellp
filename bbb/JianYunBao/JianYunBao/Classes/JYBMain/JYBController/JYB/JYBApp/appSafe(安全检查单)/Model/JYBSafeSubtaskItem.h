//
//  JYBSafeSubtaskItem.h
//  JianYunBao
//
//  Created by faith on 16/3/27.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYBSafeSubtaskItem : NSObject
@property (nonatomic,copy)NSString *safeSubTaskid;
@property (nonatomic,copy)NSString *safetyId;
@property (nonatomic,copy)NSString *note;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *workState;
@property (nonatomic,copy)NSString *createDt;
@property (nonatomic,copy)NSString *number;
@property (nonatomic,copy)NSArray  *executors;

@end
