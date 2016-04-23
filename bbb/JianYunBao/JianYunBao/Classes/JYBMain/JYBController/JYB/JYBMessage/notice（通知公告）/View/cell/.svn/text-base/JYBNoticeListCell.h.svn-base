//
//  JYBNoticeListCell.h
//  JianYunBao
//
//  Created by 正 on 16/3/16.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYBNoticeListItem.h"

@interface JYBNoticeListCell : UITableViewCell{
    @private
    __weak IBOutlet JYBLabel * titleLab;
    __weak IBOutlet JYBLabel * contentLab;
    __weak IBOutlet JYBLabel * dateLab;
    __weak IBOutlet JYBLabel * commentCountLab;
    __weak IBOutlet JYBLabel * agreeCountLab;

}
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
+ (CGFloat)heightForRow;
- (void)setNoticeEntity:(JYBNoticeListItem *)item;

@end
