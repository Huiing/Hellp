//
//  JYBFileTypeCell.h
//  JianYunBao
//
//  Created by faith on 16/3/14.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^FileTpyeBlock)(UIButton *sender, NSInteger index);
@interface JYBFileTypeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *handleImageView;
@property (nonatomic ,copy)FileTpyeBlock fileTypeBlock;
+ (UINib*)nib;
+ (NSString *)cellReuseIdentifier;
+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
@end
