//
//  JYBQualityOrderListCell.h
//  JianYunBao
//
//  Created by faith on 16/3/24.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYBQualityOrderItem.h"
@interface JYBQualityOrderListCell : UITableViewCell
@property (nonatomic, strong) JYBQualityOrderItem *qualityOrderItem;
@property (weak, nonatomic) IBOutlet UILabel *statusLable;

@property (weak, nonatomic) IBOutlet UILabel *qualityOrderLbl;

@property (weak, nonatomic) IBOutlet UILabel *titleNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *stautsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *programLbl;

@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *responsibeLbl;
@property (weak, nonatomic) IBOutlet UILabel *changeLabel;

@property (weak, nonatomic) IBOutlet UILabel *checkLbl;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

+ (UINib*)nib;
+ (NSString *)cellReuseIdentifier;
+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
@end
