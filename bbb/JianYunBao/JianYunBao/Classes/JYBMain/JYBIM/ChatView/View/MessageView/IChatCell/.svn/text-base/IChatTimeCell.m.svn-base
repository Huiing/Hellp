//
//  IChatTimeCell.m
//  JianYunBao
//
//  Created by 冰点 on 16/3/3.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "IChatTimeCell.h"

@implementation IChatTimeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier;
{
    IChatTimeCell *cell = (IChatTimeCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[IChatTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setFormatTime:(NSString *)time
{
    _time = time;
    self.tagLabel.text = time;
    [self layoutIfNeeded];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width = [_time sizeWithFont:JYBFont(12) maxSize:CGSizeMake(SCR_WIDTH, self.width)].width;
    self.tagLabel.frame = CGRectMake((SCR_WIDTH-width)/2.0, (self.height-15)/2.0, width + 2, 15);
}

@end
