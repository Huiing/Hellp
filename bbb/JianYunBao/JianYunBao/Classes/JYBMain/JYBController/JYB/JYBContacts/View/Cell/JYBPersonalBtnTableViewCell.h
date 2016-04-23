//
//  JYBPersonalBtnTableViewCell.h
//  JianYunBao
//
//  Created by 宋亚伟 on 16/3/1.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JYBPersonalBtnTableViewCellDelegate <NSObject>
@optional
- (void)btnClick:(NSIndexPath *)indexPath;
@end

@interface JYBPersonalBtnTableViewCell : UITableViewCell
+ (UINib*)nib;
+ (NSString *)cellReuseIdentifier;
+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
@property (nonatomic, copy) NSIndexPath *indexPath;
@property (weak, nonatomic) IBOutlet UIButton *Btn;
@property (nonatomic, weak) id<JYBPersonalBtnTableViewCellDelegate> delegate;
@property (nonatomic, copy) NSString *contact;
@end
