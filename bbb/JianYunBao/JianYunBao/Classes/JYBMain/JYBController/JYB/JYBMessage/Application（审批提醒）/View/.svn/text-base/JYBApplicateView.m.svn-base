//
//  JYBApplicateView.m
//  JianYunBao
//
//  Created by 正 on 16/3/17.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBApplicateView.h"

@implementation JYBApplicateView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib{
    self.layer.shadowOffset = CGSizeMake(0, 2);
    self.layer.shadowOpacity = 0.6f;
    
    processNameTF.layer.borderWidth = 1;
    processNameTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    taskNameTF.layer.borderWidth = 1;
    taskNameTF.layer.borderColor = [UIColor lightGrayColor].CGColor;

    senderNameLab.layer.borderWidth = 1;
    senderNameLab.layer.borderColor = [UIColor lightGrayColor].CGColor;

    sendTimeLab.layer.borderWidth = 1;
    sendTimeLab.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    senderNameLab.enabled = NO;
    senderNameLab.enabled = NO;
    
    clearButton.layer.cornerRadius = 4;
    clearButton.layer.masksToBounds = YES;
    
    searchButton.layer.cornerRadius = 4;
    searchButton.layer.masksToBounds = YES;
}

- (void)clearApplicateSubviewsData{
    processNameTF.text = @"";
    taskNameTF.text = @"";
    senderNameLab.text = @"";
    sendTimeLab.text = @"";
}

- (IBAction)applicateButtonActions:(id)sender {
    UIButton * btn = (UIButton *)sender;
    switch (btn.tag) {
        case 101://发起人
        {
            if(self.delegate && [self.delegate respondsToSelector:@selector(applicateViewSenderHandle)]){
                [self.delegate applicateViewSenderHandle];
            }
        }
            break;
        case 102://发起时间
        {
            if(self.delegate && [self.delegate respondsToSelector:@selector(applicateViewSendTimeHandle)]){
                [self.delegate applicateViewSendTimeHandle];
            }
        }
            break;
        case 201://清空
        {
            [self clearApplicateSubviewsData];
        }
            break;
        case 202://搜索
        {
            if(self.delegate && [self.delegate respondsToSelector:@selector(applicateViewSearchHandle)]){
                [self.delegate applicateViewSearchHandle];
            }
        }
            break;
        default:
            break;
    }
}
- (void)setSenderWithUserName:(NSString *)userName{
    senderNameLab.text = userName;
}
- (void)setTimeWithDate:(NSString *)date{
    sendTimeLab.text = date;
}
- (NSString *)gProcessName{
    return processNameTF.text.length != 0 ? processNameTF.text : @"";
}

- (NSString *)gTaskName{
    return taskNameTF.text.length != 0 ? taskNameTF.text : @"";
}

@end
