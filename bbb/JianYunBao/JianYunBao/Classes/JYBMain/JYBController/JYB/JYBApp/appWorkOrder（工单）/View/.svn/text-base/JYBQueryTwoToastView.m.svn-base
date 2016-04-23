//
//  JYBQueryTwoToastView.m
//  JianYunBao
//
//  Created by faith on 16/3/17.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBQueryTwoToastView.h"

@implementation JYBQueryTwoToastView
- (void)awakeFromNib
{
  self.layer.borderColor = RGB(240, 240, 240).CGColor;
  self.layer.borderWidth =1;
  self.layer.shadowColor = [UIColor blackColor].CGColor;
  self.layer.shadowOffset = CGSizeMake(0, 0);
  self.layer.shadowOpacity = 0.5;
  self.layer.shadowRadius = 10.0;
  _contentTextView.layer.borderWidth = 1;
  _contentTextView.layer.borderColor = RGB(240, 240, 240).CGColor;
  _contentTextView.layer.cornerRadius = 2;
  
  _createButton.layer.borderWidth = 1;
  _createButton.layer.borderColor = RGB(240, 240, 240).CGColor;
  _createButton.layer.cornerRadius = 2;
  
  _responsibleButton.layer.borderWidth = 1;
  _responsibleButton.layer.borderColor = RGB(240, 240, 240).CGColor;
  _responsibleButton.layer.cornerRadius = 2;
  
  _projectButton.layer.borderWidth = 1;
  _projectButton.layer.borderColor = RGB(240, 240, 240).CGColor;
  _projectButton.layer.cornerRadius = 2;
  
  _clearButton.layer.borderWidth = 1;
  _clearButton.layer.borderColor = RGB(240, 240, 240).CGColor;
  _clearButton.layer.cornerRadius = 5;
  
  _searchButton.layer.borderWidth = 1;
  _searchButton.layer.borderColor = RGB(240, 240, 240).CGColor;
  _searchButton.layer.cornerRadius = 5;
}

- (IBAction)progressAction:(UIButton *)sender {
  if(sender.tag == 1500)
  {
    _allDateButton.backgroundColor = RGB(236, 160, 144);
    _notOverdue.backgroundColor = RGB(172, 172, 172);
    _overDue.backgroundColor = RGB(172, 172, 172);
  }
  else if(sender.tag == 1501)
  {
    _notOverdue.backgroundColor = RGB(236, 160, 144);
    _allDateButton.backgroundColor = RGB(172, 172, 172);
    _overDue.backgroundColor = RGB(172, 172, 172);
  }
  else if(sender.tag == 1502)
  {
    _overDue.backgroundColor = RGB(236, 160, 144);
    _notOverdue.backgroundColor = RGB(172, 172, 172);
    _allDateButton.backgroundColor = RGB(172, 172, 172);
  }
  
  
  
}
- (IBAction)statusAction:(UIButton *)sender {
  if(sender.tag == 1600)
  {
    _allTwo.backgroundColor = RGB(236, 160, 144);
    _onWay.backgroundColor = RGB(172, 172, 172);
    _complete.backgroundColor = RGB(172, 172, 172);
    _pause.backgroundColor = RGB(172, 172, 172);
    _cancle.backgroundColor = RGB(172, 172, 172);;
  }
  else if(sender.tag == 1601)
  {
    _onWay.backgroundColor = RGB(236, 160, 144);
    _allTwo.backgroundColor = RGB(172, 172, 172);
    _complete.backgroundColor = RGB(172, 172, 172);
    _pause.backgroundColor = RGB(172, 172, 172);
    _cancle.backgroundColor = RGB(172, 172, 172);;
  }
  else if(sender.tag == 1602)
  {
    _complete.backgroundColor = RGB(236, 160, 144);
    _onWay.backgroundColor = RGB(172, 172, 172);
    _allTwo.backgroundColor = RGB(172, 172, 172);
    _pause.backgroundColor = RGB(172, 172, 172);
    _cancle.backgroundColor = RGB(172, 172, 172);;
  }
  else if(sender.tag == 1603)
  {
    _pause.backgroundColor = RGB(236, 160, 144);
    _onWay.backgroundColor = RGB(172, 172, 172);
    _complete.backgroundColor = RGB(172, 172, 172);
    _allTwo.backgroundColor = RGB(172, 172, 172);
    _cancle.backgroundColor = RGB(172, 172, 172);;
  }
  else if(sender.tag == 1604)
  {
    _cancle.backgroundColor = RGB(236, 160, 144);
    _onWay.backgroundColor = RGB(172, 172, 172);
    _complete.backgroundColor = RGB(172, 172, 172);
    _pause.backgroundColor = RGB(172, 172, 172);
    _allTwo.backgroundColor = RGB(172, 172, 172);;
  }
  
  
}
- (IBAction)dateAction:(UIButton *)sender {
  if(sender.tag ==1700)
  {
    _allThree.backgroundColor = RGB(236, 160, 144);
    _today.backgroundColor = RGB(172, 172, 172);
    _inThreeDay.backgroundColor = RGB(172, 172, 172);
    _thisWeek.backgroundColor = RGB(172, 172, 172);
    _thisMonth.backgroundColor = RGB(172, 172, 172);
  }
  if(sender.tag ==1701)
  {
    _today.backgroundColor = RGB(236, 160, 144);
    _allThree.backgroundColor = RGB(172, 172, 172);
    _inThreeDay.backgroundColor = RGB(172, 172, 172);
    _thisWeek.backgroundColor = RGB(172, 172, 172);
    _thisMonth.backgroundColor = RGB(172, 172, 172);
  }
  if(sender.tag ==1702)
  {
    _inThreeDay.backgroundColor = RGB(236, 160, 144);
    _today.backgroundColor = RGB(172, 172, 172);
    _allThree.backgroundColor = RGB(172, 172, 172);
    _thisWeek.backgroundColor = RGB(172, 172, 172);
    _thisMonth.backgroundColor = RGB(172, 172, 172);
  }
  if(sender.tag ==1703)
  {
    _thisWeek.backgroundColor = RGB(236, 160, 144);
    _today.backgroundColor = RGB(172, 172, 172);
    _inThreeDay.backgroundColor = RGB(172, 172, 172);
    _allThree.backgroundColor = RGB(172, 172, 172);
    _thisMonth.backgroundColor = RGB(172, 172, 172);
  }
  if(sender.tag ==1704)
  {
    _thisMonth.backgroundColor = RGB(236, 160, 144);
    _today.backgroundColor = RGB(172, 172, 172);
    _inThreeDay.backgroundColor = RGB(172, 172, 172);
    _thisWeek.backgroundColor = RGB(172, 172, 172);
    _allThree.backgroundColor = RGB(172, 172, 172);
  }
  
}
- (IBAction)clearAction:(id)sender {
  if(self.clearBlock)
  {
    self.clearBlock();
  }
}
- (IBAction)searchAction:(id)sender {
  if(self.searchBlock)
  {
    self.searchBlock();
  }
}
- (IBAction)selectProject:(id)sender {
  if(self.selectProjectBlock)
  {
    self.selectProjectBlock();
  }
}
- (IBAction)selectPeople:(id)sender {
  if(self.selectPeopleBlock)
  {
    self.selectPeopleBlock();
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
