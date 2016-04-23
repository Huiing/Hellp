//
//  JYBSearchGroupView.m
//  JianYunBao
//
//  Created by sks on 25/03/16.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBSearchGroupView.h"

@implementation JYBSearchGroupView



- (void)awakeFromNib
{
    struct CGColor *color = RGB(240, 240, 240).CGColor;
    _nameTextView.layer.borderWidth = 1;
    _nameTextView.layer.borderColor = color;
    _styleBtn.layer.borderColor = color;
    _styleBtn.layer.borderWidth = 1;
    _startDateBtn.layer.borderColor = color;
    _startDateBtn.layer.borderWidth = 1;
    _endDateBtn.layer.borderColor = color;
    _endDateBtn.layer.borderWidth = 1;
    _clearBtn.layer.borderColor = color;
    _clearBtn.layer.borderWidth = 1;
    _searchBtn.layer.borderColor = color;
    _searchBtn.layer.borderWidth = 1;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowRadius = 10.0;
}

- (IBAction)styleBtn:(id)sender
{
    if (_styleBlock)
    {
        self.styleBlock();
    }
}


- (IBAction)startBtnClick:(id)sender
{
    if (_startBlock)
    {
        self.startBlock();
    }
}

- (IBAction)endDateClick:(id)sender
{
    if (_endBlock)
    {
        self.endBlock();
    }
}

- (IBAction)clearBtnClick:(id)sender
{
    if (_clearBlock)
    {
        self.clearBlock();
    }
}
- (IBAction)searchClick:(id)sender
{
    if (_searchBlock)
    {
        self.searchBlock();
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
