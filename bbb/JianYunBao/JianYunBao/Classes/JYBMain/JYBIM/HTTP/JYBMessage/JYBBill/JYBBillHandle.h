//
//  JYBBillManager.h
//  BDSocketIM
//
//  Created by 冰点 on 16/2/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYBSendBaseHandle.h"

@class JYBIMSendBillCommentMessageApi, JYBIMSendBillNodeMessageApi;
@interface JYBBillHandle : JYBSendBaseHandle

@property (nonatomic, assign) JYBBillType billType;

@end
