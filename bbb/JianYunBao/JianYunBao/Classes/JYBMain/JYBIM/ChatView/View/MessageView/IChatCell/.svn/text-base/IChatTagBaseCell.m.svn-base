//
//  IChatTagBaseCell.m
//  JianYunBao
//
//  Created by 冰点 on 16/3/3.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "IChatTagBaseCell.h"

@implementation IChatTagBaseCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.tagLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.tagLabel.backgroundColor = [UIColor jyb_grayColor];
        self.tagLabel.textAlignment = NSTextAlignmentCenter;
        self.tagLabel.font = JYBFont(10);
        self.tagLabel.textColor = [UIColor jyb_whiteColor];
        [self.contentView addSubview:self.tagLabel];
        [self.tagLabel.layer setMasksToBounds:YES];
        self.tagLabel.layer.cornerRadius = 5;
        self.tagLabel.layer.masksToBounds = YES;
    }
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return self;
}

@end
