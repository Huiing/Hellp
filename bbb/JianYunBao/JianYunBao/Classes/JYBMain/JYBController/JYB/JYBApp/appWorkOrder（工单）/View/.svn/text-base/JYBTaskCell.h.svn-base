//
//  JYBTaskCell.h
//  TestView
//
//  Created by faith on 16/3/11.
//  Copyright © 2016年 faith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYBSubtaskItem.h"
typedef void(^StatusImageBlock)();
typedef void(^LookImageBlock)();
@interface JYBTaskCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *topLine;
@property (weak, nonatomic) IBOutlet UIImageView *lineView;

@property (weak, nonatomic) IBOutlet UIView *bottomLine;

@property (weak, nonatomic) IBOutlet UILabel *taskName;
@property (weak, nonatomic) IBOutlet UILabel *executor;
@property (weak, nonatomic) IBOutlet UIImageView *workStateImage;
@property (nonatomic ,copy)StatusImageBlock statusImageBlock;
@property (nonatomic ,copy)LookImageBlock lookImageBlock;
@property (nonatomic ,copy) JYBSubtaskItem *subTaskItem;

@property (weak, nonatomic) IBOutlet UIImageView *lookImage;

+ (UINib*)nib;
+ (NSString *)cellReuseIdentifier;
+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
@end
