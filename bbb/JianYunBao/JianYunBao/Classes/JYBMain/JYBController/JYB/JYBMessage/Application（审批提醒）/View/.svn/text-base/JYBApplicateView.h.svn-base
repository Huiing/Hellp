//
//  JYBApplicateView.h
//  JianYunBao
//
//  Created by 正 on 16/3/17.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JYBApplicateViewDelegate;
@interface JYBApplicateView : UIView{
    @private
    __weak IBOutlet UITextField *processNameTF;
    __weak IBOutlet UITextField *taskNameTF;
    __weak IBOutlet UILabel *senderNameLab;
    __weak IBOutlet UILabel *sendTimeLab;    
    __weak IBOutlet UIButton *clearButton;
    __weak IBOutlet UIButton *searchButton;
}
@property (assign, nonatomic) id <JYBApplicateViewDelegate> delegate;

- (void)setSenderWithUserName:(NSString *)userName;
- (void)setTimeWithDate:(NSString *)date;

- (NSString *)gProcessName;
- (NSString *)gTaskName;

- (IBAction)applicateButtonActions:(id)sender;

@end

@protocol JYBApplicateViewDelegate <NSObject>
//选人
- (void)applicateViewSenderHandle;
//选时间
- (void)applicateViewSendTimeHandle;
//搜索
- (void)applicateViewSearchHandle;

@end
