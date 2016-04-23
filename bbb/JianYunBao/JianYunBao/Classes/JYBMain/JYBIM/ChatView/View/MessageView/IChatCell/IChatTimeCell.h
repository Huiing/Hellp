//
//  IChatTimeCell.h
//  JianYunBao
//
//  Created by 冰点 on 16/3/3.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IChatTagBaseCell.h"

@interface IChatTimeCell : IChatTagBaseCell
{
    NSString *_time;
}
+ (instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier;
- (void)setFormatTime:(NSString *)time;

@end
