//
//  IChatTagBaseCell.h
//  JianYunBao
//
//  Created by 冰点 on 16/3/3.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IChatTagBaseCell : UITableViewCell

@property (nonatomic, strong) UILabel *tagLabel;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
