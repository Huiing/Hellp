//
//  JYBSearchView.m
//  JianYunBao
//
//  Created by sks on 25/03/16.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBSearchView.h"

@implementation JYBSearchView

- (void)awakeFromNib
{
    struct CGColor *color = RGB(240, 240, 240).CGColor;
    _clearBtn.layer.borderColor = RGB(240, 240, 240).CGColor;
    _clearBtn.layer.borderWidth = 1;
    _searchBtn.layer.borderWidth=1;
    _searchBtn.layer.borderColor = RGB(240, 240, 240).CGColor;
    self.layer.borderColor= RGB(240, 240, 240).CGColor;
    self.layer.borderWidth = 1;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowRadius = 10.0;
    _titleTextView.layer.borderColor = color;
    _titleTextView.layer.borderWidth = 1;
    _creatButton.layer.borderWidth = 1;
    _creatButton.layer.borderColor = color;
    _responsibleButton.layer.borderColor = color;
    _responsibleButton.layer.borderWidth = 1;
    _startDateButton.layer.borderWidth = 1;
    _startDateButton.layer.borderColor = color;
    _endDateButton.layer.borderColor = color;
    _endDateButton.layer.borderWidth = 1;
    _clearBtn.layer.cornerRadius = 4;
    _searchBtn.layer.cornerRadius = 4;
    _clearBtn.clipsToBounds = YES;
    _searchBtn.clipsToBounds = YES;
}
- (IBAction)clearBtn:(UIButton *)sender
{
    if (_clearBlock)
    {
        self.clearBlock();
    }
}
- (IBAction)searchBtn:(UIButton *)sender
{
    if (_searchBlock)
    {
        self.searchBlock();
    }
}
- (IBAction)creatBtn:(id)sender
{
    if (_creatPeopleBlock)
    {
        self.creatPeopleBlock();
    }
}
- (IBAction)responsBtn:(id)sender
{
    if (_responsblePeopleBlock)
    {
        self.responsblePeopleBlock();
    }
}
- (IBAction)startBtn:(id)sender
{
    if (_startDateBlock)
    {
        self.startDateBlock();
    }
}

- (IBAction)endDateBtn:(id)sender
{
    if (_endDateBlock)
    {
        self.endDateBlock();
    }
}



@end
