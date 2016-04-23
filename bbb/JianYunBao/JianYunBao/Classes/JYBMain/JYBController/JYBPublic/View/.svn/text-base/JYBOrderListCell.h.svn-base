//
//  JYBOrderListCell.h
//  JianYunBao
//
//  Created by faith on 16/3/11.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYBOrderItem.h"

typedef void(^selectBlock)();


@interface JYBOrderListCell : UITableViewCell
@property (nonatomic, strong) JYBOrderItem *orderItem;
@property (weak, nonatomic) IBOutlet UILabel *titleNameLbl;

@property (weak, nonatomic) IBOutlet UILabel *dateLbl;
@property (weak, nonatomic) IBOutlet UILabel *importanceLbl;
@property (weak, nonatomic) IBOutlet UILabel *emergencyLbl;

@property (weak, nonatomic) IBOutlet UILabel *workStatusLbl;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;

@property (weak, nonatomic) IBOutlet UILabel *responsibeLbl;
@property (weak, nonatomic) IBOutlet UILabel *orderIdLabel;

@property (weak, nonatomic) IBOutlet UILabel *backGroundLbl;
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *stateLabel;

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@property (nonatomic,copy) selectBlock selectBlock;


+ (UINib*)nib;
+ (NSString *)cellReuseIdentifier;
+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
@end
