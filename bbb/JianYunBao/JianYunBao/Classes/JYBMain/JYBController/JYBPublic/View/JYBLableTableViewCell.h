//
//  JYBLableTableViewCell.h
//  JianYunBao
//
//  Created by 宋亚伟 on 16/2/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SelectBlock)();
@interface JYBLableTableViewCell : UITableViewCell
+ (UINib*)nib;
+ (NSString *)cellReuseIdentifier;
+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (nonatomic ,copy) SelectBlock selectBlock;
@end
