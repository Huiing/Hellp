//
//  JYBSafeTaskCell.h
//  JianYunBao
//
//  Created by faith on 16/3/27.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYBSafeSubtaskItem.h"
typedef void(^StatusImageBlock)();
typedef void(^LookImageBlock)();
@interface JYBSafeTaskCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *topLine;
@property (weak, nonatomic) IBOutlet UIImageView *lineView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomLine;
@property (weak, nonatomic) IBOutlet UILabel *taskName;
@property (weak, nonatomic) IBOutlet UILabel *executor;
@property (weak, nonatomic) IBOutlet UIImageView *workStateImage;

@property (weak, nonatomic) IBOutlet UIImageView *lookImage;

@property (nonatomic ,copy)StatusImageBlock statusImageBlock;
@property (nonatomic ,copy)LookImageBlock lookImageBlock;
@property (nonatomic ,copy) JYBSafeSubtaskItem *safeSubtaskItem;

+ (UINib*)nib;
+ (NSString *)cellReuseIdentifier;
+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
