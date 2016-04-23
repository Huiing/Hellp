//
//  JYBVEditWorkOrderViewController.h
//  JianYunBao
//
//  Created by faith on 16/3/27.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBBaseViewController.h"
#import "JYBOrderDetailItem.h"
@interface JYBVEditWorkOrderViewController : JYBBaseViewController
@property (nonatomic ,copy)NSString *orderId;
@property (nonatomic ,strong)JYBOrderDetailItem *item;
@end
