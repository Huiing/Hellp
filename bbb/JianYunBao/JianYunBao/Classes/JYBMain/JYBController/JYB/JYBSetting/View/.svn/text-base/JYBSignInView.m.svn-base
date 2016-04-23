//
//  JYBSignInView.m
//  JianYunBao
//
//  Created by sks on 28/03/16.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBSignInView.h"

@implementation JYBSignInView

- (void)awakeFromNib
{
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowRadius = 10.0;
    struct CGColor *color = RGB(240, 240, 240).CGColor;
    _yearBtn.layer.borderColor = color;
    _yearBtn.layer.borderWidth = 1;
    _clearBtn.layer.borderColor = color;
    _clearBtn.layer.borderWidth = 1;
    _searchBtn.layer.borderWidth = 1;
    _searchBtn.layer.borderColor = color;
}

- (IBAction)yearBtnClick:(id)sender
{
    if (_yearBlock)
    {
        self.yearBlock();
    }
}
- (IBAction)clearBtnClick:(id)sender
{
    if (_clearBlock)
    {
        self.clearBlock();
    }
}
- (IBAction)searchBtnClick:(id)sender
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
